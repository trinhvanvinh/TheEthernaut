// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Ethernaut.sol";
import "../src/Token.sol";
import "../src/TokenFactory.sol";

contract TokenTest is Test {
    Ethernaut ethernaut;
    TokenFactory level;
    Token instance;

    address player = address(123);
    address instanceAddress;

    function setUp() external {
        startHoax(msg.sender);
        ethernaut = new Ethernaut();
        level = new TokenFactory();
        ethernaut.registerLevel(level);
        instanceAddress = ethernaut.createLevelInstance(level);
        instance = Token(instanceAddress);
    }

    function testToken() public {
        console.log("ba ",instance.balanceOf(msg.sender) );
        instance.transfer(address(345), 30);

        bool levelCompleted = ethernaut.submitLevelInstance(
            payable(instanceAddress)
        );
        assert(levelCompleted);
    }
}
