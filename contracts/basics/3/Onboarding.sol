// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Onboarding{
    struct Employee{
        string name;
        string email;
        uint salary;
    }

    Employee public employee;

    function join(string memory _name, string memory _email, uint _salary)public virtual{
                employee = Employee(_name, _email, _salary);

    }

        function nextSteps() public view virtual returns (string memory){}
}

contract Allocation is Onboarding{
    function allocate(string memory _employeeId, string memory _projectId)public view returns(string memory){
        string memory text = string.concat("The employee with id: ", _employeeId, ", is added to project with id: ", _projectId);
        nextSteps();
        return text;
    }

        function nextSteps() public view override returns (string memory){
            return sendWelcomeEmail();
        }

        function sendWelcomeEmail() internal view returns (string memory) {
        return string.concat("Sent welcome email to employee with email: ", employee.email);
    }
    
}
