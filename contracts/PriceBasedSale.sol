pragma solidity ^0.5.0;


import "./Sale.sol";
import "./Decimals.sol";


contract PriceBasedSale is Sale {
    using Decimals for address;

    function _getTokenDecimals() internal pure returns (uint);

    function getPrice(address _token, uint  _value) view public returns (uint price);

    function _getPurchasedAmount(address _beneficiary, address _token, uint _value) internal returns (uint amount, uint change) {
        uint price = getPrice(_token, _value);
        if (price == 0) {
            return (0, 0);
        }
        uint realValue = uint(10 ** 18).mul(_value.div(_token.mult()));
        amount = (10 ** _getTokenDecimals()).mul(realValue.div(price));
        change = 0;
    }

}
