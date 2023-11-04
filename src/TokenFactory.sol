// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "./BaseLevel.sol";
import "./Token.sol";

contract TokenFactory is Level {
    uint totalSupply = 1000;
    uint playerBalanceInit = 20;

    function createInstance(
        address _player
    ) public payable override returns (address) {
        Token instance = new Token(totalSupply);
        instance.transfer(_player, playerBalanceInit);
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        Token instance = Token(_instance);
        return instance.balanceOf(_player) > playerBalanceInit;
    }
}
