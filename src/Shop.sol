// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;
import "forge-std/console.sol";

interface Buyer {
    function price() external view returns (uint);
}

contract Shop {
    uint public price = 100;
    bool public isSold;

    function buy() public {
        Buyer _buyer = Buyer(msg.sender);
        console.log("bb: ", _buyer.price(), isSold);
        if (_buyer.price() >= price && !isSold) {
            isSold = true;
            price = _buyer.price();
        }
    }
}
