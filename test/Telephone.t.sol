// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Ethernaut.sol";
import "../src/Telephone.sol";
import "../src/TelephoneFactory.sol";
import "../src/TelephoneHack.sol";

contract TelephoneTest is Test {
    Ethernaut ethernaut;
    TelephoneFactory level;
    Telephone instance;
    TelephoneHack attacker;

    address player = address(123);
    address instanceAddress;

    function setUp() external {
        startHoax(msg.sender);
        ethernaut = new Ethernaut();
        level = new TelephoneFactory();
        ethernaut.registerLevel(level);
        instanceAddress = ethernaut.createLevelInstance(level);
        instance = Telephone(payable(instanceAddress));
        attacker = new TelephoneHack(instanceAddress);
    }

    function testTelephoneHack() public {
        attacker.attack();

        bool levelCompleted = ethernaut.submitLevelInstance(
            payable(instanceAddress)
        );
        assert(levelCompleted);
    }
}
