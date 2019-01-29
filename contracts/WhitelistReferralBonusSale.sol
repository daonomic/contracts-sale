pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./ReferrerProvider.sol";
import "./Sale.sol";

contract WhitelistReferralBonusSale is ReferrerProvider, Sale {

    uint public referrerBonus;
    uint public refereeBonus;

    constructor(uint _referrerBonus, uint _refereeBonus) public {
        referrerBonus = _referrerBonus;
        refereeBonus = _refereeBonus;
    }

    function _getBonus(address _beneficiary, uint _amount) internal returns (uint) {
        address referrer = getReferrer(_beneficiary);
        require(referrer != address(0), "beneficiary is not whitelisted");
        if (referrer != address(1)) {
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

    function setReferrer(address _address, address _referrer) public onlyWhitelistAdmin {
        if (_referrer != address(0) && _referrer != address(1)) {
            require(getReferrer(_referrer) != address(0));
        }
        referrers[_address] = _referrer;
    }

    function setReferrerBonus(uint _referrerBonus) public onlyOwner {
        referrerBonus = _referrerBonus;
    }

    function setRefereeBonus(uint _refereeBonus) public onlyOwner {
        refereeBonus = _refereeBonus;
    }
}
