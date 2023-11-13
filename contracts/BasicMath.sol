// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";

contract BasicMath {
    function adder(uint _a, uint _b) external pure returns (uint sum, bool error) {
        unchecked { sum = _a + _b; }

        if (sum < _a) {
            return (0, true);
        }

        return (sum, false);

        // 255 + 255 = 255
    }

    function subtractor(uint _a, uint _b) external pure returns (uint difference, bool error) {
        unchecked { difference = _a - _b; }

        if (difference > _a) {
            return (0, true);
        }

        return (difference, false);

        // 255 - 255 = 0
        // 0 - 255 = 0
    }
}
