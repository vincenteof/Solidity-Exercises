// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract BasicBankV2 {
    /// used to store the balance of users
    ///     USER    =>  BALANCE
    mapping(address => uint256) public balances;

    /// @notice deposit ether into the contract
    /// @dev it should work properly when called multiple times
    function addEther() external payable {
        require(msg.value > 0, "must send ether");
        balances[msg.sender] += msg.value;
    }

    /// @notice used to withdraw ether from the contract
    /// @param amount of ether to remove. Cannot execeed balance i.e users cannot withdraw more than they deposited
    function removeEther(uint256 amount) external payable {
        uint256 userBalance = balances[msg.sender];
        require(amount <= userBalance, "remove too much ether");
        balances[msg.sender] -= amount;
        (bool success,) = msg.sender.call{value: amount}("");
        require(success, "failed to send ether");
    }
}
