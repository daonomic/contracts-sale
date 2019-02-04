pragma solidity ^0.5.0;

import "./Sale.sol";
import "./ReferralBonusSale.sol";

contract ExternalReferralBonusSale is ReferralBonusSale {

    ReferrerProvider public referrerProvider;

    constructor(ReferrerProvider _referrerProvider) public {
        referrerProvider = _referrerProvider;
    }

    function _getReferrer(address account) internal view returns (address) {
        return referrerProvider.getReferrer(account);
    }
}
