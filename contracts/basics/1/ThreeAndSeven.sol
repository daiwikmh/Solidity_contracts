// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract ThreeAndSeven{
    function check(uint x) public  pure returns(bool){
        return (x % 3 & x % 7 == 0 && x > 10);
    }
}