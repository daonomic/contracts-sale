pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "../../contracts/MintingSale.sol";
import "../../contracts/WhitelistSale.sol";
import "../../contracts/ReferralBonusSale.sol";

contract SimpleReferralBonusSale is ReferrerProviderImpl, WhitelistSale, ReferralBonusSale, MintingSale {

    constructor(ERC20Mintable _token, uint _referrerBonus, uint _refereeBonus) ReferralBonusSale(_referrerBonus, _refereeBonus) MintingSale(_token) public {

    }

    function _getPurchasedAmount(address _beneficiary, address _token, uint _value) internal returns (uint amount, uint change) {
        require(_token == address(0), "only eth payments accepted");
        return (_value * 10, 0);
    }

    function _getReferrer(address account) internal view returns (address referrer) {
        referrer = getReferrer(account);
    }

    function _isWhitelisted(address account) internal view returns (bool) {
        return isWhitelisted(account);
    }

    function setReferrer(address _address, address _referrer) public onlyWhitelistAdmin {
        if (_referrer != address(0) && _referrer != address(1)) {
            require(getReferrer(_referrer) != address(0));
        }
        referrers[_address] = _referrer;
    }
}
