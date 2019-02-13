pragma solidity ^0.5.0;


import "./Sale.sol";
import "./Decimals.sol";


contract PriceBasedSale is Sale {
    function getPrice(address _token, uint _value) view public returns (uint price);
}
