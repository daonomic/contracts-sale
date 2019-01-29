pragma solidity ^0.5.0;

import "../../contracts/SidechainSale.sol";
import "../../contracts/MintingSale.sol";
import "../../contracts/RatesSale.sol";

contract SimpleSidechainSale is SidechainSale, MintingSale, RatesSale {

    constructor(ERC20Mintable _token) MintingSale(_token) public {

    }
}
