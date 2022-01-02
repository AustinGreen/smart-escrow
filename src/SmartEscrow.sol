// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

import {ERC20} from "@solmate/tokens/ERC20.sol"; // Solmate: ERC20

contract SmartEscrow {
    address public immutable depositor;
    address public immutable beneficiary;
    uint256 public immutable vestingDate;

    constructor(address _beneficiary) {
        depositor = msg.sender;
        beneficiary = _beneficiary;
        vestingDate = block.timestamp + 30 days;
        // Assuming approval, transfer ERC20 from depositor to contract
        // Approve yield pool to transfer balance
        // Call yield pool deposit function
    }

    function withdraw() external {
        require(msg.sender == beneficiary);
        // Withdraw asset from pool
        // Send principal to beneficiary
        // Send interest to depositor
    }
}
