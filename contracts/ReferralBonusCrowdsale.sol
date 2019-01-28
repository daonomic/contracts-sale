pragma solidity ^0.5.0;

import "./ReferrerProvider.sol";
import "./BonusCrowdsale.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract ReferralBonusCrowdsale is ReferrerProvider, BonusCrowdsale {

    uint public referrerBonus;
    uint public refereeBonus;

    function _getBonus(address _beneficiary, uint _amount) internal returns (uint) {
        address referrer = getReferrer(_beneficiary);
        if (referrer != address(0) && referrer != address(1)) {
            uint realReferrerBonus = _amount.mul(referrerBonus).div(1000);
            emit Bonus(referrer, realReferrerBonus, BonusType.REFERRER);
            uint realRefereeBonus = _amount.mul(refereeBonus).div(1000);
            emit Bonus(_beneficiary, realRefereeBonus, BonusType.REFEREE);
            _deliver(referrer, realReferrerBonus);
            return realRefereeBonus;
        } else {
            return 0;
        }
    }
}
