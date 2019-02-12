pragma solidity ^0.5.0;

import "./Sale.sol";

contract ERC20Sale is Sale {
    using SafeERC20 for IERC20;

    function receiveERC20(address _beneficiary, IERC20 _token, uint256 _value) external {
        _token.safeTransferFrom(msg.sender, address(this), _value);
        _purchase(_beneficiary, address(_token), _value);
    }

    function withdrawToken(IERC20 _token, address _to, uint _value) public onlyOwner {
        _token.safeTransfer(_to, _value);
    }
}
