// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {IERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract LockUSDT {
    address private usdtAddress;
    mapping(address => uint256) public pendingBalances;

modifier checkAllowanceAndBalance(uint256 _amount) {
    require(IERC20(usdtAddress).allowance(msg.sender, address(this)) >= _amount, "Insufficient allowance");
    require(IERC20(usdtAddress).balanceOf(msg.sender) >= _amount, "Insufficient balance");
    _;
}

    constructor(address _usdtAddress){
        usdtAddress = _usdtAddress;
    }

    function deposit(uint256 _amount) public checkAllowanceAndBalance(_amount) {

        IERC20(usdtAddress).transferFrom(msg.sender, address(this), _amount);
        pendingBalances[msg.sender] += _amount;
    }

    function withdraw(uint256 amount) public {
        uint256 remainingAmount = pendingBalances[msg.sender];
        require(remainingAmount > 0, "No balance to withdraw");

        IERC20(usdtAddress).transfer(msg.sender, remainingAmount);

        pendingBalances[msg.sender] = 0;
    }

}
