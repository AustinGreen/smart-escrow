// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {ERC20} from "@solmate/tokens/ERC20.sol"; // Solmate: ERC20
import {LendingPool} from "./interfaces/LendingPool.sol";

/// @title SmartEscrow
/// @notice Factory for escrow contracts that generate yield on locked assets
/// @author Austin Green
contract SmartEscrow {
    /*///////////////////////////////////////////////////////////////
                                IMMUTABLES
    //////////////////////////////////////////////////////////////*/

    /// @notice The user depositing assets to timelock.
    address public immutable depositor;

    /// @notice The user receiving assets after timelock.
    address public immutable beneficiary;

    /// @notice The timestamp when assets can be withdrawn.
    uint256 public immutable vestingDate;

    /// @notice The amount being escrowed.
    uint256 public immutable amount;

    /// @notice The asset that is being escrowed
    ERC20 public immutable asset;

    // the mainnet AAVE v2 lending pool
    LendingPool pool = LendingPool(0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9);

    // aave interest bearing erc20
    ERC20 public immutable aToken;

    /// @notice Creates a new Escrow that generates yield on locked assets.
    /// @param _beneficiary The user receiving assets after timelock.
    constructor(
        address _beneficiary,
        ERC20 _asset,
        ERC20 _aToken,
        uint256 _amount
    ) {
        depositor = msg.sender;
        beneficiary = _beneficiary;
        vestingDate = block.timestamp + 30 days;
        asset = _asset;
        aToken = _aToken;
        amount = _amount;

        asset.transferFrom(depositor, address(this), _amount);
        uint256 balance = asset.balanceOf(address(this));
        asset.approve(address(pool), balance);
        pool.deposit(address(asset), balance, address(this), 0);
    }

    function withdraw() external {
        require(msg.sender == beneficiary);
        require(block.timestamp > vestingDate);
        pool.withdraw(address(asset), amount, beneficiary);
        pool.withdraw(
            address(asset),
            aToken.balanceOf(address(this)),
            depositor
        );
    }
}
