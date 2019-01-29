pragma solidity ^0.5.0;

import "./Sale.sol";
import "./roles/OperatorRole.sol";
import "./UiEvents.sol";

contract SidechainSale is UiEvents, OperatorRole, Sale {
    event XPubChange(address token, string xpub);
    mapping(address => string) xpubs;

    function setXPub(address _token, string memory _xpub) onlyOwner public {
        setXPubInternal(_token, _xpub);
    }

    function setXPubInternal(address _token, string memory _xpub) internal {
        xpubs[_token] = _xpub;
        emit XPubChange(_token, _xpub);
    }

    function getXPub(address token) view public returns (string memory) {
        return xpubs[token];
    }

    function onReceive(address _buyer, address _token, uint256 _value, bytes memory _txId) onlyOperator public {
        require(_token != address(0));
        emit ExternalTx(_txId);
        _purchase(_buyer, _token, _value);
    }
}
