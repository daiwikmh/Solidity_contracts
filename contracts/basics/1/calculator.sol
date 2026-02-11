// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Calculator{


    function addition(uint a, uint b)public pure returns (uint) {
    
    return (a+b);

    }

    function subtraction(uint a, uint b)public pure returns(uint){
        return (a-b);
    } 

    function boolean(uint a, uint b) public  pure returns(bool){
        return (a>b);
    }

    function bitwise(uint a, uint b) public pure returns(uint){
        return (a ^ b);
    }
}