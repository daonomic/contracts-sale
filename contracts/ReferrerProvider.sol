pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/access/roles/WhitelistAdminRole.sol";

contract ReferrerProvider is WhitelistAdminRole {
    mapping(address => address) public referrers;

    function getReferrer(address _address) public view returns (address referrer) {
        referrer = referrers[_address];
    }

    function setReferrer(address _address, address _referrer) public onlyWhitelistAdmin {
        referrers[_address] = _referrer;
    }
}
