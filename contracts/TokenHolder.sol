pragma solidity ^0.5.0;


import "./TokenHolderLib.sol";


/**
 * @title TokenHolder
 * @dev TokenHolder is a token holder contract that will allow a
 * beneficiary to extract the tokens after a given release time
 */
contract TokenHolder {
    using TokenHolderLib for TokenHolderLib.Holder;

    TokenHolderLib.Holder private holder;

    constructor(IERC20 token, address beneficiary, uint256 releaseTime) public {
        holder = TokenHolderLib.Holder(token, beneficiary, releaseTime);
    }

    /**
     * @notice Transfers tokens held by timelock to beneficiary.
     */
    function release() public {
        holder.release();
    }
}
