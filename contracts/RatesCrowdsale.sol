pragma solidity ^0.5.0;

import "./Crowdsale.sol";

contract RatesCrowdsale is Crowdsale {
    mapping(address => uint) public rates;

    function _getAmount(address _beneficiary, address _token, uint _value) internal returns (uint amount, uint change) {
        uint rate = rates[_token];
        require(rate != 0, "Rate is not set");
        return (_value.mul(rate), 0);
    }

    function getRate(address _token) view public returns (uint) {
        return rates[_token];
    }

    function setRate(address _token, uint _rate) public onlyOwner {
        rates[_token] = _rate;
    }
}
