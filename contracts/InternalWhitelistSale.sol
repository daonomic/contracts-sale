pragma solidity ^0.5.0;

import "./WhitelistImpl.sol";
import "./WhitelistSale.sol";

contract InternalWhitelistSale is WhitelistImpl, WhitelistSale {
    function _isWhitelisted(address account) internal view returns (bool) {
        return isWhitelisted(account);
    }
}
