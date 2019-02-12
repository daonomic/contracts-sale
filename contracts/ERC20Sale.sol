pragma solidity ^0.5.0;

import "./Sale.sol";

contract ERC20Sale is Sale {
    using SafeERC20 for IERC20;

    function receiveERC20(address payable _beneficiary, IERC20 _token, uint256 _value) external {
        _token.safeTransferFrom(msg.sender, address(this), _value);
        _purchase(_beneficiary, address(_token), _value);
    }

    function withdrawToken(IERC20 _token, address _to, uint _value) public onlyOwner {
        _token.safeTransfer(_to, _value);
    }

    function _processChange(address payable _beneficiary, address _token, uint _change) internal {
        super._processChange(_beneficiary, _token, _change);
        if (_token != address(0) && _token != address(1) && _token != address(2) && _token != address(3) && _token != address(4)) {
            IERC20(_token).safeTransfer(_beneficiary, _change);
        }
    }
}
