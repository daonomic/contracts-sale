pragma solidity ^0.5.0;

contract Whitelist {
    event WhitelistChangeEvent(address account, bool allowed);

    function isWhitelisted(address account) public view returns (bool);
}
