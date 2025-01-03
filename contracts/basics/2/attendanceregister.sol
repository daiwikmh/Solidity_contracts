// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract AttendanceRegister{

    struct Student {
        string name;
        uint class;
        uint joiningdate;
    }

    address public teacher;
    uint rollnumber;

    event Added(string name,
        uint class,
        uint joiningdate);

        mapping(uint => Student) public registered;

        modifier isteacher{
            require(msg.sender == teacher, "modifier should be teacher");
            _;
        }

        constructor(){
             teacher = msg.sender;
        }

       function add(string memory name, uint class, uint joiningdate)public isteacher{
        require(class > 0 && class <=12, "invalid class");
        Student memory s = Student(name, class, joiningdate);
        rollnumber++;
        registered[rollnumber] = s;
        emit Added(name, class, block.timestamp);


       }
}