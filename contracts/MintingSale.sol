pragma solidity ^0.5.0;


import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "@daonomic/lib/contracts/Minting.sol";
import "./Sale.sol";


contract MintingSale is Minting, Sale {

    constructor(ERC20Mintable token) Minting(token) public {
    }

    function _deliver(address _beneficiary, uint _amount) internal {
        require(token.mint(_beneficiary, _amount));
    }
}
