
// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract ParentOrg {
    struct EmployeeDetails {
        string name;
        uint age;
        string department;
    }

    mapping(address => EmployeeDetails) public details;

    function enroll(string memory _name, uint _age, string memory _department) virtual external {
        details[msg.sender] = EmployeeDetails(_name, _age, _department);
    }
}

contract NewCompany is ParentOrg {
    function enroll(string memory _name, uint _age, string memory _department) virtual override public {
                        details[msg.sender] = EmployeeDetails(_name, _age, _department );

    }
}

contract AnotherCompany is ParentOrg {
    function enroll(string memory _name, uint _age, string memory _department) virtual override public {
                        details[msg.sender] = EmployeeDetails(_name, _age, _department );

    }

    function getDepartment(address _employee) public view returns (string memory) {
        return details[_employee].department;
    }
}
