// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "./BaseLevel.sol";
import "./Delegation.sol";

contract DelegationFactory is Level {
    uint totalSupply = 1000;
    uint playerBalanceInit = 20;

    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        Delegate delegate = new Delegate(address(0));
        Delegation instance = new Delegation(address(delegate));
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        Delegation instance = Delegation(_instance);
        return instance.owner() == _player;
    }
}
