pragma solidity ^0.5.0;

import "./Sale.sol";

contract CountingTotalSale is Sale {
    uint public purchasedTotal;
    uint public bonusTotal;

    function _updateState(address _beneficiary, address _token, uint _value, uint _purchased, uint _bonus) internal {
        super._updateState(_beneficiary, _token, _value, _purchased, _bonus);
        purchasedTotal += _purchased;
        bonusTotal += _bonus;
    }
}
