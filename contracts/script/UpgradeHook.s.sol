// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../src/Hook.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

contract TestIspScript is Script {
    function run() public {
        address proxyAdminAddress = vm.envAddress("PROXY_ADMIN_CONTRACT");
        require(proxyAdminAddress != address(0));

        address proxy = vm.envAddress("PROXY_CONTRACT");
        require(proxy != address(0));

        // uint64 schemaId = uint64(vm.envUint("SCHEMA_ID"));
        // require(schemaId != 0);

        address impl = vm.envAddress("HOOK_CONTRACT");
        require(impl != address(0));

        vm.startBroadcast();
        ProxyAdmin(proxyAdminAddress).upgradeAndCall(ITransparentUpgradeableProxy(proxy), impl, "");
        vm.stopBroadcast();
    }
}
