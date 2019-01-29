pragma solidity ^0.5.0;


import "./CountingTotalSale.sol";


contract CappedSale is CountingTotalSale {
    uint public cap;

    constructor(uint _cap) public {
        cap = _cap;
    }

    function _postValidatePurchase(address _beneficiary, address _token, uint _value, uint _purchased, uint _bonus) internal {
        super._postValidatePurchase(_beneficiary, _token, _value, _purchased, _bonus);
        require(purchasedTotal + bonusTotal < cap);
    }
}
