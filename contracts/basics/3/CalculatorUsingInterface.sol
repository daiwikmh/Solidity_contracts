// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;


interface Calculator {

    function add(uint a, uint b) external returns(uint);
    
    function sub(uint a, uint b) external returns(uint);
    
    function mul(uint a, uint b) external returns(uint);
    
    function div(uint a, uint b) external returns(uint);
}

contract CalculatorUsingInterface is Calculator{

    function add(uint a, uint b)public pure returns(uint){
    uint c = a + b;
    return c;
    }

    
    function sub(uint a, uint b) public pure returns (uint) {
        require(b <= a, "variable underflow");
        uint c = a - b;
        return c;
    }



    function mul(uint a, uint b) public pure returns (uint) {
        uint c = a * b;
        require(c/a == b, "variable overflow");
        return c;
    }

    
    function div(uint a, uint b) public pure returns (uint) {
        require(b > 0, "invalid operation");
        uint c = a/b;
        return c;
    }
    
}