pragma solidity ^0.5.0;

import "./Crowdsale.sol";

contract BonusCrowdsale is Crowdsale {
    function _getPurchasedAmount(address _token, uint _value) internal returns (uint amount, uint change);

    function _getBonus(address _beneficiary, uint _amount) internal returns (uint);

    function _getAmount(address _beneficiary, address _token, uint _value) internal returns (uint amount, uint change) {
        (amount, change) = _getPurchasedAmount(_token, _value);
        amount += _getBonus(_beneficiary, amount);
    }
}
