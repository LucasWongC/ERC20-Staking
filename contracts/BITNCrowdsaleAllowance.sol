pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/crowdsale/Crowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/emission/AllowanceCrowdsale.sol";

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract BITNCrowdsaleAllowance is Ownable, AllowanceCrowdsale {
    uint256 private customRate;

    event RateUpdated(uint256 newRate);

    constructor(
        uint256 _initialRate,
        address payable _destinationWallet,
        ERC20 _token
    ) public Crowdsale(_initialRate, _destinationWallet, _token) {
        customRate = 1;
    }

    function setRate(uint256 _newRate) public onlyOwner {
        customRate = _newRate;
        emit RateUpdated(_newRate); //Used for realizing a graph, cheaper than SSTORE
    }

    function _getTokenAmount(uint256 weiAmount)
        internal
        view
        returns (uint256)
    {
        return weiAmount.mul(customRate);
    }

    function getCurrentRate() external view returns (uint256) {
        return customRate;
    }
}
