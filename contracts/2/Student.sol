// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Student {

mapping (uint => string) public students;

event enrolled (uint roll);

    function enroll(uint roll, string memory name)public {
        students[roll] = name;
        emit enrolled(roll);
        
    }
}