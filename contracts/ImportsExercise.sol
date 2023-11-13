// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";
import "./SillyStringUtils.sol";

contract ImportsExercise {
    SillyStringUtils.Haiku public haiku;

    function saveHaiku(
        string calldata _line1,
        string calldata _line2,
        string calldata _line3
    ) public {
        haiku.line1 = _line1;
        haiku.line2 = _line2;
        haiku.line3 = _line3;
    }

    function getHaiku() public view returns (SillyStringUtils.Haiku memory) {
        return haiku;
    }

    function shruggieHaiku() public view returns (SillyStringUtils.Haiku memory) {
        return SillyStringUtils.Haiku(
            haiku.line1,
            haiku.line2,
            SillyStringUtils.shruggie(haiku.line3)
        );
    }
}
