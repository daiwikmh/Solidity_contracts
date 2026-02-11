// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SimpleBank {

    mapping(address => uint) bankBalance;

    event VaultDeposit(address accountHolder, uint deposit, uint newBalance);
    event VaultWithdrawal(address accountHolder, uint withdrawal, uint newBalance);

    address payable contractOwner;


    constructor() payable {
        contractOwner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(contractOwner == msg.sender, "Only Bank Owner is authorized");
        _;
    }

    function deposit() public payable {
        require(bankBalance[msg.sender] + msg.value >= bankBalance[msg.sender], "Addition: balance overflow");
        bankBalance[msg.sender] += msg.value;
        uint amount = msg.value;
        emit VaultDeposit(msg.sender, amount, bankBalance[msg.sender]);
    }

    function withdraw(uint amount) public payable returns (bool) {
        require(amount <= bankBalance[msg.sender], "Subtraction: balance underflow");
        bankBalance[msg.sender] -= amount;
        emit VaultWithdrawal(msg.sender, amount, bankBalance[msg.sender]);
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
        return true;
    }

    function getBalance() public view returns (uint) {
        return bankBalance[msg.sender];
    }

    function vaultBalance() public view onlyOwner returns (uint) {
        return address(this).balance;
    }

}