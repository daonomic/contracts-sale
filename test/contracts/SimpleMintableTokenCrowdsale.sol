pragma solidity ^0.5.0;


import "../../contracts/MintableTokenCrowdsale.sol";
import "../../contracts/RatesCrowdsale.sol";


contract SimpleMintableTokenCrowdsale is MintableTokenCrowdsale, RatesCrowdsale {

    constructor(ERC20Mintable _token) MintableTokenCrowdsale(_token) public {

    }
}
