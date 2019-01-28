pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "../../contracts/WhitelistReferralBonusCrowdsale.sol";
import "../../contracts/MintableTokenCrowdsale.sol";

contract SimpleReferralBonusCrowdsale is WhitelistReferralBonusCrowdsale, MintableTokenCrowdsale {
    constructor(ERC20Mintable _token, uint _referrerBonus, uint _refereeBonus) WhitelistReferralBonusCrowdsale(_referrerBonus, _refereeBonus) MintableTokenCrowdsale(_token) public {

    }

    function _getPurchasedAmount(address _token, uint _value) internal returns (uint amount, uint change) {
        require(_token == address(0), "only eth payments accepted");
        return (_value * 10, 0);
    }
}
