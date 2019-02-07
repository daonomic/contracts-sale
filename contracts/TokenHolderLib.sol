pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";

library TokenHolderLib {
    struct Holder {
        IERC20 token;
        address beneficiary;
        uint releaseTime;
    }

    function release(Holder storage self) public {
        require(msg.sender == self.beneficiary);
        require(block.timestamp >= self.releaseTime);
        uint amount = self.token.balanceOf(address(this));
        require(amount > 0);
        self.token.transfer(msg.sender, amount);
    }
}
