/**
 * You are given 20 tokens to start. Preferably a very large amount of tokens.
 */
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

//import "openzeppelin-contracts/contracts/utils/math/SafeMath.sol";

contract Token {
    mapping(address => uint) balances;
    uint public totalSupply;

    constructor(uint _initialSupply) {
        balances[msg.sender] = totalSupply = _initialSupply;
    }

    function transfer(address _to, uint _value) public returns (bool) {
        unchecked {
            require(balances[msg.sender] - _value >= 0);
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            return true;
        }
    }

    function balanceOf(address _owner) public view returns (uint balance) {
        return balances[_owner];
    }
}
