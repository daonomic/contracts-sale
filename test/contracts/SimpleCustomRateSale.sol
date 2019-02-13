pragma solidity ^0.5.0;

import "../../contracts/MintingSale.sol";
import "../../contracts/SidechainSale.sol";
import "../../contracts/CustomRateSale.sol";
import "../../contracts/PriceBasedNotCappedSale.sol";

contract SimpleCustomRateSale is Ownable, PriceBasedSale, PriceBasedNotCappedSale, MintingSale, SidechainSale, CustomRateSale {

    constructor(ERC20Mintable token) MintingSale(token) public {
    }

    function _getBasePrice() view internal returns (address token, uint price) {
        return (USD, 10 ** 17);
    }

    function _getTokenDecimals() internal pure returns (uint) {
        return 18;
    }
}
