pragma solidity ^0.5.0;


import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./Decimals.sol";
import "./PriceBasedSale.sol";
import "./Sale.sol";


contract PriceBasedCappedSale is Ownable, PriceBasedSale, Sale {
    using Decimals for address;
    using SafeMath for uint;

    function _getTokenDecimals() internal pure returns (uint);

    function _getCapLeft() internal view returns (uint);

    function _getPurchasedAmount(address _beneficiary, address _token, uint _value) internal returns (uint amount, uint change) {
        uint price = getPrice(_token, _value);
        if (price == 0) {
            return (0, 0);
        }
        uint tokenMult = _token.mult();
        uint realValue = uint(10 ** 18).mul(_value).div(tokenMult);
        amount = (10 ** _getTokenDecimals()).mul(realValue).div(price);
        change = 0;

        uint left = _getCapLeft();
        if (left < amount) {
            amount = left;
            change = _value - tokenMult.mul(amount).mul(price).div(10 ** _getTokenDecimals()).div(10 ** 18);
        }
    }

}
