// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;


import "../2/attendanceregister.sol";

contract AttendanceRegisterextended is AttendanceRegister{

    function getstudentbyroll(uint rollnumber)public view returns(Student memory){
        return registered[rollnumber];
    }

}