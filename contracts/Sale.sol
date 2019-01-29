pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";
import "./Events.sol";

/**
 * @title Sale
 * @dev Sale is a base contract for managing a crowdsale,
 * allowing investors to purchase with ether or other payment methods (ERC-20 tokens or BTC etc.)
 * This contract implements such functionality in its most fundamental form and can be extended
 * to provide additional functionality and/or custom behavior.
 * The external interface represents the basic interface for purchasing items, and conform
 * the base architecture for crowdsales. They are *not* intended to be modified / overridden.
 * The internal interface conforms the extensible and modifiable surface of crowdsales. Override
 * the methods to add functionality. Consider using 'super' where appropriate to concatenate
 * behavior.
 * This contract is based on openzeppeling Crowdsale contract
 */
//todo change
contract Sale is Ownable, Events {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    function () external payable {
        _purchase(msg.sender, address(0), msg.value);
    }

    function buyTokens(address _beneficiary) external payable {
        _purchase(_beneficiary, address(0), msg.value);
    }

    function receiveERC20(address _beneficiary, IERC20 _token, uint256 _value) external {
        _token.safeTransferFrom(msg.sender, address(this), _value);
        _purchase(_beneficiary, address(_token), _value);
    }

    /**
     * @dev low level purchase ***DO NOT OVERRIDE***
     * @param _beneficiary Recipient of the purchase
     * @param _token Token paid
     * @param _value value paid
     */
    function _purchase(address _beneficiary, address _token, uint _value) internal {
        _preValidatePurchase(_beneficiary, _token, _value);
        (uint purchased, ) = _getPurchasedAmount(_beneficiary, _token, _value);
        uint bonus = _getBonus(_beneficiary, purchased);
        _deliver(_beneficiary, purchased + bonus);
        emit Purchase(_beneficiary, _token, _value, purchased, bonus);
        _updateState(_beneficiary, _token, _value, purchased, bonus);
        _postValidatePurchase(_beneficiary, _token, _value, purchased, bonus);
    }

    function _preValidatePurchase(address _beneficiary, address /*_token*/, uint _value) view internal {
        require(_beneficiary != address(0));
        require(_value != 0);
    }

    function _getPurchasedAmount(address _beneficiary, address _token, uint _value) internal returns (uint amount, uint change);

    function _getBonus(address _beneficiary, uint _amount) internal returns (uint) {
        return 0;
    }

    function _deliver(address _beneficiary, uint _amount) internal;

    function _updateState(address _beneficiary, address _token, uint _value, uint _purchased, uint _bonus) internal {

    }

    function _postValidatePurchase(address _beneficiary, address _token, uint _value, uint _purchased, uint _bonus) internal {

    }

    function withdrawEth(address payable _to, uint _value) public onlyOwner {
        _to.transfer(_value);
    }

    function withdrawToken(IERC20 _token, address _to, uint _value) public onlyOwner {
        _token.safeTransfer(_to, _value);
    }
}
