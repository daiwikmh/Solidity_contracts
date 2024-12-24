// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract SelfWhitelist{

    address[] public whitelisted;

    function whitelist(address addr) public {
        if(addr == msg.sender){
        whitelisted.push(addr);
        }
    }

    function check() public view returns(bool) {
        for (uint i = 0; i< whitelisted.length; i++) {
           if(whitelisted[i] == msg.sender)
           return true; 
        }
        return false;
    }
}