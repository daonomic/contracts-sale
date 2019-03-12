pragma solidity ^0.5.0;

import "./Sale.sol";
import "./Whitelist.sol";
import "./WhitelistSale.sol";

contract ExternalWhitelistSale is Ownable, Events, Sale, WhitelistSale {

    Whitelist public whitelist;

    constructor(Whitelist _whitelist) public {
        whitelist = _whitelist;
    }

    function _isWhitelisted(address account) internal view returns (bool) {
        return whitelist.isWhitelisted(account);
    }

    function setWhitelist(Whitelist _whitelist) public onlyOwner {
        whitelist = _whitelist;
    }

    function getWhitelists() public view returns (address[] memory) {
        address[] memory result = new address[](1);
        result[0] = address(whitelist);
        return result;
    }
}
