pragma solidity ^0.5.0;

import "./Crowdsale.sol";
import "openzeppelin-solidity/contracts/access/roles/WhitelistedRole.sol";

contract WhitelistCrowdsale is WhitelistedRole, Crowdsale {
    function _preValidatePurchase(address _beneficiary, address _token, uint _value) view internal {
        super._preValidatePurchase(_beneficiary, _token, _value);
        require(isWhitelisted(_beneficiary));
    }
}
