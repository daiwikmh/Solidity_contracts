// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Rent{
    address payable public landlord;
    string tenantname;
    uint tenantage;
    string tenantocc;


constructor (string memory name, uint age, string memory occupation) {
    tenantname = name;
    tenantage = age;
    tenantocc = occupation;
    landlord = payable(msg.sender);
}

receive() external payable {
    landlord.transfer(msg.value);
}

}