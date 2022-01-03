// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

import "ds-test/test.sol";

import {SmartEscrow} from "../SmartEscrow.sol";

contract SmartEscrowTest is DSTest {
    SmartEscrow smartEscrow;

    function setUp() public {
        address aDai = 0x028171bCA77440897B824Ca71D1c56caC55b68A3;
        address dai = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
        SmartEscrow = new SmartEscrow();
    }

    function testExample() public {
        assertTrue(true);
    }
}
