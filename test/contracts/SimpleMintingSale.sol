pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;


import "../../contracts/MintingSale.sol";
import "../../contracts/RatesChangingSale.sol";


contract SimpleMintingSale is MintingSale, RatesChangingSale {

    constructor(ERC20Mintable _token) MintingSale(_token) public {

    }
}
