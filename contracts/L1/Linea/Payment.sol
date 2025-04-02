// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FeeSystem {
    address public admin;
    address public feeReceiver;
    uint256 public feeAmount;
    mapping(address => bool) public hasPaid;

    event PaymentReceived(address indexed user, uint256 amount);
    event FeeReceiverUpdated(address indexed oldReceiver, address indexed newReceiver);
    event FeeAmountUpdated(uint256 oldFee, uint256 newFee);

    /**
     * @dev Constructor to initialize the contract with the admin, fee receiver, and initial fee amount.
     * @param _feeReceiver The initial address where fees will be sent.
     * @param _initialFee The initial fee amount in wei.
     */
    constructor(address _feeReceiver, uint256 _initialFee) {
        require(_feeReceiver != address(0), "Fee receiver cannot be zero address");
        require(_initialFee > 0, "Fee amount must be greater than zero");

        admin = msg.sender;
        feeReceiver = _feeReceiver;
        feeAmount = _initialFee;
    }

    /**
     * @dev Modifier to restrict access to admin-only functions.
     */
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    /**
     * @dev Allows users to pay the current fee.
     */
    function payFee() external payable {
        require(msg.value == feeAmount, "Must send the exact fee amount");
        require(!hasPaid[msg.sender], "User has already paid");

        hasPaid[msg.sender] = true;
        (bool sent, ) = feeReceiver.call{value: msg.value}("");
        require(sent, "Failed to send ETH to fee receiver");

        emit PaymentReceived(msg.sender, msg.value);
    }

    /**
     * @dev Allows the admin to update the fee receiver address.
     * @param _newReceiver The new address where fees will be sent.
     */
    function updateFeeReceiver(address _newReceiver) external onlyAdmin {
        require(_newReceiver != address(0), "New fee receiver cannot be zero address");
        address oldReceiver = feeReceiver;
        feeReceiver = _newReceiver;
        emit FeeReceiverUpdated(oldReceiver, _newReceiver);
    }

    /**
     * @dev Allows the admin to update the fee amount.
     * @param _newFee The new fee amount in wei.
     */

    function updateFeeAmount(uint256 _newFee) external onlyAdmin {
        require(_newFee > 0, "Fee amount must be greater than zero");
        uint256 oldFee = feeAmount;
        feeAmount = _newFee;
        emit FeeAmountUpdated(oldFee, _newFee);
    }

    /**
     * @dev Allows the admin to transfer ownership to a new admin.
     * @param _newAdmin The new admin address.
     */

    function transferAdmin(address _newAdmin) external onlyAdmin {
        require(_newAdmin != address(0), "New admin cannot be zero address");
        admin = _newAdmin;
    }

    /**
     * @dev Checks if a user has access (i.e., has paid the fee).
     * @param user The address of the user to check.
     * @return True if the user has paid, false otherwise.
     */
    
    function hasAccess(address user) external view returns (bool) {
        return hasPaid[user];
    }
}