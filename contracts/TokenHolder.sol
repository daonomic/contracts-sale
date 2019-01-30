pragma solidity ^0.5.0;


import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";


/**
 * @title Token Holder with vesting period
 * @dev holds any amount of tokens and allows to release all tokens at start time
 */
contract TokenHolder is Ownable {
    event Released(uint amount);

    /**
     * @dev start of the vesting period
     */
    uint public start;
    /**
     * @dev holding token
     */
    IERC20 public token;

    constructor(uint _start, IERC20 _token) public {
        start = _start;
        token = _token;
    }

    /**
     * @dev transfers vested tokens to beneficiary (to the owner of the contract)
     * @dev automatically calculates amount to release
     */
    function release() onlyOwner public {
        require(now >= start);

        uint amount = token.balanceOf(address(this));
        require(amount > 0);
        require(token.transfer(msg.sender, amount));
        emit Released(amount);
    }
}
