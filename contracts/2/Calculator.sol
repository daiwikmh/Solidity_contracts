// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Calculator {
    function add(uint a, uint b) public pure returns(uint){
        uint c = a+b;
        require(c >= a, "variable overflow");
        return c;
    }

    function subtract(uint a, uint b) public pure returns(uint){
        require(b <= a,"variable underflow");
        uint c = a-b;
        return c;
    }

    function divide(uint a, uint b)public pure returns(uint){
        require(a > b,"variable underflow");
        uint c = a/b;
        return c;
    }
}