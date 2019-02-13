pragma solidity ^0.5.0;

import "../../contracts/PriceBasedSale.sol";
import "../../contracts/MintingSale.sol";
import "../../contracts/SidechainSale.sol";

contract SimplePriceBasedSale is PriceBasedSale, MintingSale, SidechainSale {

    constructor(ERC20Mintable token) MintingSale(token) public {
    }

    function _getTokenDecimals() internal pure returns (uint) {
        return 18;
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
