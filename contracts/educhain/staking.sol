// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract StakingContract is ReentrancyGuard {
    IERC20 public stakingToken;
    uint256 public rewardRate = 100; // Rewards per block (adjust as needed)
    uint256 public constant REWARD_PRECISION = 1e12; // For precision in calculations
    
    struct StakeInfo {
        uint256 amount;
        uint256 lastUpdateBlock;
        uint256 accumulatedRewards;
    }
    
    mapping(address => StakeInfo) public stakes;
    uint256 public totalStaked;
    
    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event RewardsClaimed(address indexed user, uint256 amount);
    
    constructor(address _stakingToken) {
        stakingToken = IERC20(_stakingToken);
    }
    
    // Calculate pending rewards for a user
    function calculateRewards(address user) public view returns (uint256) {
        StakeInfo memory stake = stakes[user];
        if (stake.amount == 0) return stake.accumulatedRewards;
        
        uint256 blocksElapsed = block.number - stake.lastUpdateBlock;
        uint256 newRewards = (stake.amount * rewardRate * blocksElapsed) / REWARD_PRECISION;
        return stake.accumulatedRewards + newRewards;
    }
    
    // Update user's reward calculation
    function updateRewards(address user) internal {
        stakes[user].accumulatedRewards = calculateRewards(user);
        stakes[user].lastUpdateBlock = block.number;
    }
    
    // Stake tokens
    function stake(uint256 amount) external nonReentrant {
        require(amount > 0, "Amount must be greater than 0");
        
        updateRewards(msg.sender);
        
        require(stakingToken.transferFrom(msg.sender, address(this), amount), 
            "Token transfer failed");
            
        stakes[msg.sender].amount += amount;
        totalStaked += amount;
        
        emit Staked(msg.sender, amount);
    }
    
    // Withdraw staked tokens
    function withdraw(uint256 amount) external nonReentrant {
        require(amount > 0, "Amount must be greater than 0");
        require(stakes[msg.sender].amount >= amount, "Insufficient stake");
        
        updateRewards(msg.sender);
        
        stakes[msg.sender].amount -= amount;
        totalStaked -= amount;
        
        require(stakingToken.transfer(msg.sender, amount), 
            "Token transfer failed");
            
        emit Withdrawn(msg.sender, amount);
    }
    
    // Claim accumulated rewards
    function claimRewards() external nonReentrant {
        updateRewards(msg.sender);
        
        uint256 rewards = stakes[msg.sender].accumulatedRewards;
        require(rewards > 0, "No rewards available");
        
        stakes[msg.sender].accumulatedRewards = 0;
        
        // In a real implementation, you'd transfer reward tokens here
        // For this example, we'll just emit an event
        emit RewardsClaimed(msg.sender, rewards);
    }
    
    // Get user's stake info
    function getStakeInfo(address user) 
        external 
        view 
        returns (uint256 amount, uint256 pendingRewards) 
    {
        return (stakes[user].amount, calculateRewards(user));
    }
}