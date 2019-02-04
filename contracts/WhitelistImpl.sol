pragma solidity ^0.5.0;


import "@daonomic/lib/contracts/roles/WhitelistAdminRole.sol";
import "./Whitelist.sol";


contract WhitelistImpl is WhitelistAdminRole, Whitelist {
    mapping(address => bool) public whitelist;

    function isWhitelisted(address account) public view returns (bool) {
        return whitelist[account];
    }

    function addToWhitelist(address[] memory accounts) public onlyOwner {
        for(uint i = 0; i < accounts.length; i++) {
            _setWhitelisted(accounts[i], true);
        }
    }

    function removeFromWhitelist(address[] memory accounts) public onlyOwner {
        for(uint i = 0; i < accounts.length; i++) {
            _setWhitelisted(accounts[i], false);
        }
    }

    function setWhitelisted(address account, bool whitelisted) public onlyOwner {
        _setWhitelisted(account, whitelisted);
    }

    function setWhitelist(address account, bool whitelisted) public onlyOwner {
        _setWhitelisted(account, whitelisted);
    }

    function _setWhitelisted(address account, bool whitelisted) internal {
        whitelist[account] = whitelisted;
        emit WhitelistChange(account, whitelisted);
    }
}
