// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {Test, console} from "forge-std/Test.sol";
// import {StdCheats} from "forge-std/StdCheats.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract DeployAndUpgradeTest is Test {
    DeployBox public deployBox;
    UpgradeBox public upgradeBox;
    // address public OWNER = makeAddr("owner");
    address public OWNER = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    // address public proxy;

    // function setUp() public {
    //     deployer = new DeployBox();
    //     upgrader = new UpgradeBox();
    //     proxy = deployer.run();
    //     console.log("deployer : ", address(deployer));
    //     console.log("proxy : ", address(proxy));
    //     console.log("upgrader : ", address(upgrader));
    //     console.log("DEY PLAY : ", BoxV1(proxy).owner());
    // }
    function setUp() public {
        deployBox = new DeployBox();
        upgradeBox = new UpgradeBox();
        console.log("deployer : ", address(deployBox));
        console.log("upgrader : ", address(upgradeBox));
    }

    // function testBoxWorks() public {
    //     // address proxyAddress = deployBox.deployBox();
    //     uint256 expectedValue = 1;
    //     assertEq(expectedValue, BoxV1(proxy).version());
    // }

    // function testDeploymentIsV1() public {
    //     // address proxyAddress = deployBox.deployBox();
    //     uint256 expectedValue = 7;
    //     vm.expectRevert();
    //     BoxV2(proxy).setNumber(expectedValue);
    // }

    // function testUpgradeWorks() public {
    //     // address proxyAddress = deployBox.deployBox();

    //     BoxV2 box2 = new BoxV2();

    //     // vm.prank(BoxV1(proxy).owner());
    //     // BoxV1(proxyAddress).transferOwnership(msg.sender);
    //     console.log("ownerT : ", address(BoxV1(proxy).owner()));

    //     upgrader.upgradeBox(proxy, address(box2));

    //     uint256 expectedValue = 2;
    //     assertEq(expectedValue, BoxV2(proxy).version());

    //     // BoxV2(proxy).setNumber(7);
    //     // assertEq(7, BoxV2(proxy).getNumber());
    // }
    function testUpgradeWorks() public {
        address proxyAddress = deployBox.deployBox();
        console.log("proxy : ", proxyAddress);
        console.log("DEY PLAY : ", BoxV1(proxyAddress).owner());

        BoxV2 box2 = new BoxV2();

        vm.prank(OWNER);
        BoxV1(proxyAddress).transferOwnership(msg.sender);

        address proxy = upgradeBox.upgradeBox(proxyAddress, address(box2));

        uint256 expectedValue = 2;
        assertEq(expectedValue, BoxV2(proxy).version());

        BoxV2(proxy).setNumber(expectedValue);
        assertEq(expectedValue, BoxV2(proxy).getNumber());
    }
}
