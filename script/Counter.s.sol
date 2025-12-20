// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {LockUSDT} from "../src/Counter.sol";

contract CounterScript is Script {
    LockUSDT public lockUSDT;

    function setUp() public {}

    function run(address usdtAddress) public {
        vm.startBroadcast();

        lockUSDT = new LockUSDT(usdtAddress);

        vm.stopBroadcast();
    }
}
