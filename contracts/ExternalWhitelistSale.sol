pragma solidity ^0.5.0;

import "./Sale.sol";
import "./Whitelist.sol";

contract ExternalWhitelistSale is Sale {

    Whitelist public whitelist;

    constructor(Whitelist _whitelist) public {
        whitelist = _whitelist;
    }

    function _preValidatePurchase(address _beneficiary, address _token, uint _value) view internal {
        super._preValidatePurchase(_beneficiary, _token, _value);
        require(whitelist.isWhitelisted(_beneficiary));
    }

    function setWhitelist(Whitelist _whitelist) public onlyOwner {
        whitelist = _whitelist;
    }
}
