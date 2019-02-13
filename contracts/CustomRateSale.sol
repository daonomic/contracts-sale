pragma solidity ^0.5.0;

import "./AutoRateSale.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract CustomRateSale is Ownable, AutoRateSale {
    mapping(address => mapping(address => uint)) public customRates;

    function _getConversionRate(address _source, address _destination, uint _value) view internal returns (uint rate) {
        return customRates[_source][_destination];
    }

    function setConversionRate(address _source, address _destination, uint _rate) public onlyOwner {
        customRates[_source][_destination] = _rate;
    }
}
