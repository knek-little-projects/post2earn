// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../src/Hook.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

contract TestIspScript is Script {
    address public impl;
    ProxyAdmin public proxyAdmin;
    TransparentUpgradeableProxy public proxy;

    function setUp() public {}

    function run() public {
        address initialOwner = vm.envAddress("OWNER");
        require(initialOwner != address(0));

        vm.startBroadcast();

        // Deploy the logic contract (Counter)
        impl = address(new Hook());

        // Deploy the ProxyAdmin
        proxyAdmin = new ProxyAdmin(initialOwner);

        // Encode the initialization call
        bytes memory data = abi.encodeWithSelector(Hook.initialize.selector, initialOwner);

        // Deploy the TransparentUpgradeableProxy
        proxy = new TransparentUpgradeableProxy(
            address(impl),
            address(proxyAdmin),
            data
        );

        vm.stopBroadcast();
    }
}
