// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Simple ERC-20 Token Contract
contract UserToken is ERC20 {
    constructor(string memory name, string memory symbol, uint256 initialSupply, address creator) 
        ERC20(name, symbol) 
    {
        _mint(creator, initialSupply);
    }
}

// Main Contract for Token Creation and Liquidity
abstract contract TokenFactoryAndLiquidity is Ownable {
    // Constants
    address public constant ADMIN_ADDRESS = 0x1029BBd9B780f449EBD6C74A615Fe0c04B61679c;
    uint256 public constant ACCESS_FEE = 0.001 ether;
    uint256 public constant TOKEN_CREATION_FEE = 0.001 ether;

    // Mapping to track access
    mapping(address => bool) public hasPaid;

    // Mapping to store user-created tokens
    mapping(address => address) public userTokens;

    // Liquidity Pool struct
    struct LiquidityPool {
        address token;
        uint256 tokenAmount;
        uint256 ethAmount;
        mapping(address => uint256) userLiquidity;
    }

    // Mapping to store liquidity pools for each token
    mapping(address => LiquidityPool) public liquidityPools;

    // Events
    event PaymentReceived(address indexed user, uint256 amount);
    event TokenCreated(address indexed creator, address tokenAddress, string name, string symbol);
    event LiquidityAdded(address indexed user, address token, uint256 tokenAmount, uint256 ethAmount);
    event LiquidityRemoved(address indexed user, address token, uint256 tokenAmount, uint256 ethAmount);

    constructor() {}

    // Pay to gain access
    function payFee() external payable {
        require(msg.value == ACCESS_FEE, "Must send exactly 0.1 ETH");
        require(!hasPaid[msg.sender], "User has already paid");

        hasPaid[msg.sender] = true;
        (bool sent, ) = ADMIN_ADDRESS.call{value: msg.value}("");
        require(sent, "Failed to send ETH to admin");

        emit PaymentReceived(msg.sender, msg.value);
    }

    // Check if a user has access
    function hasAccess(address user) external view returns (bool) {
        return hasPaid[user];
    }

    // Create a new token
    function createToken(string memory name, string memory symbol, uint256 initialSupply) external payable {
        require(hasPaid[msg.sender], "Must pay access fee first");
        require(msg.value == TOKEN_CREATION_FEE, "Must send exactly 0.1 ETH for token creation");
        require(userTokens[msg.sender] == address(0), "User already created a token");

        // Deploy new token
        UserToken newToken = new UserToken(name, symbol, initialSupply, msg.sender);
        userTokens[msg.sender] = address(newToken);

        // Send fee to admin
        (bool sent, ) = ADMIN_ADDRESS.call{value: msg.value}("");
        require(sent, "Failed to send ETH to admin");

        emit TokenCreated(msg.sender, address(newToken), name, symbol);
    }

    // Add liquidity to a token pool
    function addLiquidity(address token, uint256 tokenAmount) external payable {
        require(hasPaid[msg.sender], "Must pay access fee first");
        require(userTokens[msg.sender] == token, "You can only add liquidity to your token");
        require(msg.value > 0, "Must send ETH for liquidity");
        require(tokenAmount > 0, "Must send tokens for liquidity");

        LiquidityPool storage pool = liquidityPools[token];
        if (pool.token == address(0)) {
            pool.token = token; // Initialize pool if it doesn't exist
        }

        // Transfer tokens from user to contract
        IERC20(token).transferFrom(msg.sender, address(this), tokenAmount);

        // Update pool balances
        pool.tokenAmount += tokenAmount;
        pool.ethAmount += msg.value;
        pool.userLiquidity[msg.sender] += msg.value; // Track user's share based on ETH contribution

        emit LiquidityAdded(msg.sender, token, tokenAmount, msg.value);
    }

    // Remove liquidity from a token pool
    function removeLiquidity(address token, uint256 ethAmount) external {
        require(hasPaid[msg.sender], "Must pay access fee first");
        require(userTokens[msg.sender] == token, "You can only remove liquidity from your token");
        LiquidityPool storage pool = liquidityPools[token];
        require(pool.ethAmount > 0, "No liquidity in pool");
        require(pool.userLiquidity[msg.sender] >= ethAmount, "Insufficient liquidity balance");

        // Calculate proportional token amount
        uint256 totalEth = pool.ethAmount;
        uint256 totalTokens = pool.tokenAmount;
        uint256 tokenAmount = (ethAmount * totalTokens) / totalEth;

        // Update pool balances
        pool.ethAmount -= ethAmount;
        pool.tokenAmount -= tokenAmount;
        pool.userLiquidity[msg.sender] -= ethAmount;

        // Transfer ETH and tokens back to user
        (bool ethSent, ) = msg.sender.call{value: ethAmount}("");
        require(ethSent, "Failed to send ETH");
        IERC20(token).transfer(msg.sender, tokenAmount);

        emit LiquidityRemoved(msg.sender, token, tokenAmount, ethAmount);
    }

    // Get user's liquidity balance
    function getLiquidityBalance(address user, address token) external view returns (uint256) {
        return liquidityPools[token].userLiquidity[user];
    }

    // Get pool info
    function getPoolInfo(address token) external view returns (uint256 tokenAmount, uint256 ethAmount) {
        LiquidityPool storage pool = liquidityPools[token];
        return (pool.tokenAmount, pool.ethAmount);
    }
}