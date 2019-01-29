pragma solidity ^0.5.0;


import "../../contracts/MintableTokenSale.sol";
import "../../contracts/RatesSale.sol";


contract SimpleMintableTokenSale is MintableTokenSale, RatesSale {

    constructor(ERC20Mintable _token) MintableTokenSale(_token) public {

    }
}
