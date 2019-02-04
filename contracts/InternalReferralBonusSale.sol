pragma solidity ^0.5.0;

import "./ReferrerProvider.sol";
import "./ReferralBonusSale.sol";

contract InternalReferralBonusSale is ReferrerProviderImpl, ReferralBonusSale {

    constructor(uint _referrerBonus, uint _refereeBonus) ReferralBonusSale(_referrerBonus, _refereeBonus) public {

    }

    function _getReferrer(address account) internal view returns (address referrer) {
        return getReferrer(account);
    }

    function getWhitelists() public view returns (address[] memory) {
        address[] memory result = new address[](1);
        result[0] = address(this);
        return result;
    }
}
