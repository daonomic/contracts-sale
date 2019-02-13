pragma solidity ^0.5.0;

import "../../contracts/MintingSale.sol";
import "../../contracts/SidechainSale.sol";
import "../../contracts/PriceBasedCappedSale.sol";

contract SimplePriceBasedCappedSale is PriceBasedSale, PriceBasedCappedSale, MintingSale, SidechainSale {

    constructor(ERC20Mintable token) MintingSale(token) public {
    }

    function _getTokenDecimals() internal pure returns (uint) {
        return 18;
    }

    function _getCapLeft() internal view returns (uint) {
        return 20 * 10 ** 18;
    }

    function getPrice(address _token, uint  _value) view public returns (uint price) {
        if (_token == ETH) {
            return 10 ** 17;
        } else if (_token == BTC) {
            return 10 ** 15;
        } else {
            return 0;
        }
    }
}
