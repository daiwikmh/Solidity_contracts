// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract YellowToken is ERC20{

    constructor (uint initialSupply) ERC20("Yellow","YLW"){
        _mint(msg.sender,initialSupply);
    }
}