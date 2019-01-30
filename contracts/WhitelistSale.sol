pragma solidity ^0.5.0;


import "./WhitelistImpl.sol";
import "./Sale.sol";


contract WhitelistSale is WhitelistImpl, Sale {

    function _preValidatePurchase(address _beneficiary, address _token, uint _value) view internal {
        super._preValidatePurchase(_beneficiary, _token, _value);
        require(isWhitelisted(_beneficiary));
    }
}
