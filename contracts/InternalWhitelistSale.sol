pragma solidity ^0.5.0;

import "./WhitelistImpl.sol";
import "./WhitelistSale.sol";

contract InternalWhitelistSale is WhitelistImpl, WhitelistSale {
    function getWhitelists() public view returns (address[] memory) {
        address[] memory result = new address[](1);
        result[0] = address(this);
        return result;
    }

    function _isWhitelisted(address account) internal view returns (bool) {
        return isWhitelisted(account);
    }
}
