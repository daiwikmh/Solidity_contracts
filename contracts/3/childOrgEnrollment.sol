// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Parentorg{
    struct EmployeeDetails {
        string name;
        uint age;
        string department;
    }

    mapping(address =>EmployeeDetails ) details;

    function enroll(string memory _name, uint _age, string memory _department)virtual external{
        details[msg.sender] = EmployeeDetails(_name, _age, _department);
    }
}

contract newcompany is Parentorg{
        function enroll(string memory _name, uint _age, string memory _department)override public{

                details[msg.sender] = EmployeeDetails(_name, _age, _department );

}
}