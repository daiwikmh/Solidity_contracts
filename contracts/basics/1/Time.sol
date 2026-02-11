// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Time{
    function getTime(uint t) public view returns(uint) {
        if(t > block.timestamp)
        return t + 1 hours + 60 seconds;
        else return 0;
    }
}