pragma solidity ^0.5.0;

import "../../contracts/SidechainSale.sol";
import "../../contracts/MintingSale.sol";
import "../../contracts/RatesChangingSale.sol";

contract SimpleSidechainSale is SidechainSale, MintingSale, RatesChangingSale {

    constructor(ERC20Mintable _token) MintingSale(_token) public {

    }
}
