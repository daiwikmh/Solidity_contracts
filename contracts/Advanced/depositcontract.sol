// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract depositContract{
    address owner;
    uint balances;


    event Moneysent(address ContractAdd, uint amount);

    constructor() payable{
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender,"only owner is required");
        _;
    }

    function deposit() public payable{
        balances += msg.value;
        emit Moneysent(address(this), address(this).balance);
    }

    function getContractBalance()public view returns(uint){
        return address(this).balance;
    }

    function killContract()public onlyOwner{
        selfdestruct(payable(msg.sender));
    }

}