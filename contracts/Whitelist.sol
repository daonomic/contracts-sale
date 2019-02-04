pragma solidity ^0.5.0;

contract Whitelist {
    event WhitelistCreatedEvent(address account);
    event WhitelistChangeEvent(address account, bool allowed);

    constructor() public {
        emit WhitelistCreatedEvent(address(this));
    }

    function isWhitelisted(address account) public view returns (bool);
}
