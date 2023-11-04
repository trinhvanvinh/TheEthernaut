// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Ethernaut.sol";
import "../src/CoinFlip.sol";
import "../src/CoinFlipFactory.sol";
import "../src/CoinFlipHack.sol";

contract CoinFlipTest is Test {
    Ethernaut ethernaut;
    CoinFlipFactory level;
    CoinFlip instance;
    CoinFlipHack attacker;

    address player = address(123);
    address instanceAddress;

    function setUp() external {
        startHoax(msg.sender);
        ethernaut = new Ethernaut();
        level = new CoinFlipFactory();
        ethernaut.registerLevel(level);
        instanceAddress = ethernaut.createLevelInstance(level);
        instance = CoinFlip(payable(instanceAddress));
        attacker = new CoinFlipHack(instanceAddress);
    }

    function testCoinFlipHack() public {
        for (uint8 i = 1; i <= 10; i++) {
            attacker.attack();
        }

        bool levelCompleted = ethernaut.submitLevelInstance(
            payable(instanceAddress)
        );
        assert(levelCompleted);
    }
}
