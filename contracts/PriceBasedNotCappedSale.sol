pragma solidity ^0.5.0;


import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "./Decimals.sol";
import "./PriceBasedSale.sol";
import "./Sale.sol";


contract PriceBasedNotCappedSale is Ownable, PriceBasedSale, Sale {
    using SafeMath for uint;
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
