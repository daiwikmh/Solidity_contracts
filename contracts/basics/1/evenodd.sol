// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Evenodd {
    function check(uint x) public pure returns(string memory){
        if(x%2 == 0)
        return "even";
        return "odd";

    }
}