pragma solidity ^0.5.0;


import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "./TokenHolder.sol";


contract Pools is Ownable {
    using SafeMath for uint256;

    enum StartType { Fixed, Floating, Direct }

    event PoolCreatedEvent(string name, uint maxAmount, uint start, StartType startType);
    event TokenHolderCreatedEvent(string name, address addr, uint amount);

    ERC20Mintable public token;
    mapping(string => PoolDescription) pools;

    struct PoolDescription {
        /**
         * @dev maximal amount of tokens in this pool
         */
        uint maxAmount;
        /**
         * @dev amount of tokens already released
         */
        uint releasedAmount;
        /**
         * @dev start of the vesting period
         */
        uint start;
        /**
         * @dev start type of the holder (fixed - date is set in seconds since 01.01.1970, floating - date is set in seconds since holder creation)
         */
        StartType startType;
    }

    constructor(ERC20Mintable _token) public {
        token = _token;
    }

    function registerPool(string memory _name, uint _maxAmount, uint _start, StartType _startType) internal {
        require(_maxAmount > 0, "maxAmount should be greater than 0");
        if (_startType == StartType.Direct) {
            require(_start == 0, "start time should be 0 for Direct StartType");
        }
        if (_start == 0) {
            require(_startType == StartType.Direct, "start time can be 0 only for StartType.Direct");
        }
        pools[_name] = PoolDescription(_maxAmount, 0, _start, _startType);
        emit PoolCreatedEvent(_name, _maxAmount, _start, _startType);
    }

    function createHolder(string memory _name, address _beneficiary, uint _amount) onlyOwner public {
        PoolDescription storage pool = pools[_name];
        require(pool.maxAmount != 0, "pool is not defined");
        require(_amount.add(pool.releasedAmount) <= pool.maxAmount, "pool is depleted");
        pool.releasedAmount = _amount.add(pool.releasedAmount);
        uint start;
        if (pool.startType == StartType.Fixed) {
            start = pool.start;
        } else {
            start = now.add(pool.start);
        }
        if (now >= start) {
            require(token.mint(_beneficiary, _amount));
        } else {
            TokenHolder created = new TokenHolder(start, token);
            created.transferOwnership(_beneficiary);
            require(token.mint(address(created), _amount));
            emit TokenHolderCreatedEvent(_name, address(created), _amount);
        }
    }

    function getTokensLeft(string memory _name) view public returns (uint) {
        PoolDescription storage pool = pools[_name];
        require(pool.maxAmount != 0, "pool is not defined");
        return pool.maxAmount.sub(pool.releasedAmount);
    }
}
