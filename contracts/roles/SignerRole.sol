pragma solidity ^0.5.0;


import "openzeppelin-solidity/contracts/access/Roles.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";


contract SignerRole is Ownable {
    using Roles for Roles.Role;

    event SignerAdded(address indexed account);
    event SignerRemoved(address indexed account);

    Roles.Role private _signers;

    constructor () internal {
        _addSigner(msg.sender);
    }

    modifier onlySigner() {
        require(isSigner(msg.sender));
        _;
    }

    function isSigner(address account) public view returns (bool) {
        return _signers.has(account);
    }

    function addSigner(address account) public onlyOwner {
        _addSigner(account);
    }

    function removeSigner(address account) public onlyOwner {
        _removeSigner(account);
    }

    function _addSigner(address account) internal {
        _signers.add(account);
        emit SignerAdded(account);
    }

    function _removeSigner(address account) internal {
        _signers.remove(account);
        emit SignerRemoved(account);
    }
}
