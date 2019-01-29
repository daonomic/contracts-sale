pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "../../contracts/WhitelistReferralBonusSale.sol";
import "../../contracts/MintingSale.sol";

contract SimpleReferralBonusSale is WhitelistReferralBonusSale, MintingSale {

    constructor(ERC20Mintable _token, uint _referrerBonus, uint _refereeBonus) WhitelistReferralBonusSale(_referrerBonus, _refereeBonus) MintingSale(_token) public {

    }

    function _getPurchasedAmount(address _beneficiary, address _token, uint _value) internal returns (uint amount, uint change) {
        require(_token == address(0), "only eth payments accepted");
        return (_value * 10, 0);
    }
}
