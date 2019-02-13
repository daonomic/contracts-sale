pragma solidity ^0.5.0;


import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./Sale.sol";


contract AutoRateSale is Sale {
    using SafeMath for uint;

    function _getBasePrice() view internal returns (address token, uint price, uint decimals);

    function _getConversionRate(address _source, address _destination, uint _value) view internal returns (uint rate, uint decimals);

    function getPrice(address _token, uint  _value) view public returns (uint price, uint decimals) {//сколько стоит в BTC один токен * 10 ** 18
        (address baseToken, uint basePrice, uint baseDecimals) = _getBasePrice();//baseToken = DAI, basePrice = сколько стоит один токен в DAI (0.1 * 10 ** 18)
        if (_token == baseToken) {
            return (basePrice, baseDecimals);
        }
        (uint conversionRate, uint dec) = _getConversionRate(_token, baseToken, _value);//сколько DAI дают за 1 BTC = 3500 * 10 ** 18
        return (uint(10 ** 18).mul(basePrice.div(conversionRate)), dec);//0.1 * 10 ** 18 / 3500 * 10 ** 18 =
    }//500000000000000000000000000000000
}
