pragma solidity ^0.5.0;


import "./Decimals.sol";
import "./PriceBasedSale.sol";


contract PriceBasedNotCappedSale is PriceBasedSale {
    using Decimals for address;

    function _getTokenDecimals() internal pure returns (uint);

    function _getPurchasedAmount(address _beneficiary, address _token, uint _value) internal returns (uint amount, uint change) {
        uint price = getPrice(_token, _value);
        if (price == 0) {
            return (0, 0);
        }
        uint tokenMult = _token.mult();
        uint realValue = uint(10 ** 18).mul(_value).div(tokenMult);
        amount = (10 ** _getTokenDecimals()).mul(realValue).div(price);
        change = 0;
    }

}
