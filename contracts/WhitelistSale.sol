pragma solidity ^0.5.0;


import "./WhitelistImpl.sol";
import "./Sale.sol";


contract WhitelistSale is Ownable, Events, Sale {

    function getWhitelists() public view returns (address[] memory);

    function _isWhitelisted(address account) internal view returns (bool);

    function _preValidatePurchase(address _beneficiary, address _token, uint _value) view internal {
        super._preValidatePurchase(_beneficiary, _token, _value);
        require(_isWhitelisted(_beneficiary));
    }
}
