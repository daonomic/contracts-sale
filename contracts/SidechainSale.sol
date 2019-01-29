pragma solidity ^0.5.0;

import "./Sale.sol";
import "./roles/OperatorRole.sol";

contract SidechainSale is OperatorRole, Sale {

    function onReceive(address _buyer, address _token, uint256 _value, bytes memory _txId) onlyOperator public {
        require(_token != address(0));
        _purchase(_buyer, _token, _value);
    }
}
