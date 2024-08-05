// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract UpgradeBox is Script {
    address public OWNER = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    // function run() external returns (address) {
    //     address mostRecentlyDeployedProxy = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);
    //     vm.startBroadcast(OWNER);
    //     BoxV2 newBox = new BoxV2();
    //     vm.stopBroadcast();
    //     address proxy = upgradeBox(mostRecentlyDeployedProxy, address(newBox));
    //     return proxy;
    // }

    // function upgradeBox( address proxyAddress, address newBox) public returns (address) {
    //     vm.startBroadcast(OWNER);
    //     BoxV1 proxy = BoxV1(proxyAddress);
    //     proxy.upgradeToAndCall(address(newBox), new bytes(0));
    //     vm.stopBroadcast();
    //     return address(proxy);
    // }

    function run() external returns (address) {
        address mostRecentlyDeployedProxy = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);

        vm.startBroadcast();
        BoxV2 newBox = new BoxV2();
        vm.stopBroadcast();
        address proxy = upgradeBox(mostRecentlyDeployedProxy, address(newBox));
        return proxy;
    }

    function upgradeBox(address proxyAddress, address newBox) public returns (address) {
        vm.startBroadcast();
        BoxV1 proxy = BoxV1(payable(proxyAddress));
        proxy.upgradeToAndCall(address(newBox), new bytes(0));
        vm.stopBroadcast();
        return address(proxy);
    }
}