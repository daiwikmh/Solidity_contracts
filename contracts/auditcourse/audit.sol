// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Trata1 is ERC20 {
    constructor(uint256 initialSupply) ERC20("Trata1", "SHI") {
        _mint(msg.sender, initialSupply);
    }
}