pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./ReferrerProvider.sol";
import "./Sale.sol";

contract ReferralBonusSale is Sale {

    uint public referrerBonus;
    uint public refereeBonus;

    constructor(uint _referrerBonus, uint _refereeBonus) public {
        referrerBonus = _referrerBonus;
        refereeBonus = _refereeBonus;
    }

    function _getReferrer(address account) internal view returns (address referrer);

    function _getBonus(address _beneficiary, uint _amount) internal returns (uint) {
        address referrer = _getReferrer(_beneficiary);
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

    function setReferrerBonus(uint _referrerBonus) public onlyOwner {
        referrerBonus = _referrerBonus;
    }

    function setRefereeBonus(uint _refereeBonus) public onlyOwner {
        refereeBonus = _refereeBonus;
    }
}
