pragma solidity ^0.5.0;


import "./Sale.sol";
import "./Decimals.sol";


contract PriceBasedSale is Sale {
    using Decimals for address;

    function _getTokenDecimals() internal pure returns (uint);

    function getPrice(address _token, uint  _value) view public returns (uint price);

    function _getPurchasedAmount(address _beneficiary, address _token, uint _value) internal returns (uint amount, uint change) {
        uint price = getPrice(_token, _value);//для BTC = 0.00002 * 10 ** 18
        if (price == 0) {
            return (0, 0);
        }
        uint realValue = uint(10 ** 18).mul(_value.div(_token.mult()));//1 BTC = 1 * 10 ** 18
        amount = (10 ** _getTokenDecimals()).mul(realValue.div(price));//10 ** 18 * 1 * 10 ** 18 / 0.00002 * 10 ** 18
        change = 0;
    }

}
