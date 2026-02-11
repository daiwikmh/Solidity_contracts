// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

library Calclib{
    function add(uint a, uint b)external pure returns(uint){
        uint c = a+b;
        return c;
    }

    function subtract(uint a, uint b)external pure returns(uint){
        require(b > a,"b should be greater than a");
        uint c = b-a;
        return c;
    }
}

contract Calclibrary{
    function add(uint a, uint b)external pure returns(uint){
        return Calclib.add(a,b);
    }

        function sub(uint a, uint b) external pure returns (uint) {
        return Calclib.subtract(a, b);
    }
}