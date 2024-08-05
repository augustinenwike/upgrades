// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract BoxV1 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    uint256 internal number;
    address public OWNER = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address initialOwner) public initializer {
        __Ownable_init(initialOwner);
        __UUPSUpgradeable_init();
    }

    function getnumber() public view returns (uint256) {
        return number;
    }

    function version() public pure returns (uint256) {
        return 1;
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}
