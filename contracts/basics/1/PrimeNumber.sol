// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract PrimeNumber{
    function ifPrime(uint x) public pure returns (bool) {
 for (uint i = 2; i * i <= x; i++) {
        if(x % i == 0){
            return false;
        }
    }
    return true;
    } 
}