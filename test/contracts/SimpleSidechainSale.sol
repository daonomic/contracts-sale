pragma solidity ^0.5.0;

import "../../contracts/SidechainSale.sol";
import "../../contracts/MintableTokenSale.sol";
import "../../contracts/RatesSale.sol";

contract SimpleSidechainSale is SidechainSale, MintableTokenSale, RatesSale {

    constructor(ERC20Mintable _token) MintableTokenSale(_token) public {

    }
}
