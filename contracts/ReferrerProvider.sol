pragma solidity ^0.5.0;


import "@daonomic/lib/contracts/roles/WhitelistAdminRole.sol";
import "./Whitelist.sol";


contract ReferrerProvider is Whitelist {
    function getReferrer(address account) public view returns (address referrer);

    function isWhitelisted(address account) public view returns (bool) {
        return getReferrer(account) != address(0);
    }
}

contract ReferrerProviderImpl is ReferrerProvider, WhitelistAdminRole {
    mapping(address => address) public referrers;

    function getReferrer(address _address) public view returns (address referrer) {
        referrer = referrers[_address];
    }

    function setReferrer(address _address, address _referrer) public onlyWhitelistAdmin {
        referrers[_address] = _referrer;
        emit WhitelistChangeEvent(_address, _referrer != address(0));
    }
}
