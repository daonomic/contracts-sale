pragma solidity ^0.5.0;


contract PriceBasedSale {
    function getPrice(address _token, uint _value) view public returns (uint price);
}
