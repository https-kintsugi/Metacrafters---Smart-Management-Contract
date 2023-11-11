// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//import "hardhat/console.sol";

contract Assessment {
    address payable public owner;
    uint256 public balance;

    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);

    constructor(uint256 initBalance) payable {
        owner = payable(msg.sender);
        balance = initBalance;
    }

    function getBalance() public view returns(uint256){
        return balance;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner of this account");
        _;
    }

    function deposit(uint256 _amount) public payable onlyOwner {
        require(_amount > 0, "Deposit amount must be greater than 0");

        uint256 _previousBalance = balance;

        // perform transaction
        balance += _amount;

        // assert transaction completed successfully
        require(balance == _previousBalance + _amount, "Deposit failed");

        // emit the event
        emit Deposit(_amount);
    }

    // custom error
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function withdraw(uint256 _withdrawAmount) public payable onlyOwner {
        require(_withdrawAmount > 0, "Withdraw amount must be greater than 0");
        require(_withdrawAmount <= balance, "Insufficient balance");

        uint256 _previousBalance = balance;

        // withdraw the given amount
        balance -= _withdrawAmount;

        // assert the balance is correct
        require(balance == (_previousBalance - _withdrawAmount), "Withdraw failed");

        // emit the event
        emit Withdraw(_withdrawAmount);
    }
}
