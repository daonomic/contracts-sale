pragma solidity ^0.5.0;


import "openzeppelin-solidity/contracts/math/SafeMath.sol";


contract AutoRateSale {
    using SafeMath for uint;

    function _getBasePrice() view internal returns (address token, uint price);

    function _getConversionRate(address _source, address _destination, uint _value) view internal returns (uint rate);

    function getPrice(address _token, uint  _value) view public returns (uint price) {
        (address baseToken, uint basePrice) = _getBasePrice();
        if (_token == baseToken) {
            return basePrice;
        }
        uint conversionRate = _getConversionRate(_token, baseToken, _value);
        if (conversionRate == 0) {
            return 0;
        }
        return uint(10 ** 18).mul(basePrice).div(conversionRate);
    }
}
