// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";

contract ArraysExercise {
    uint[] public numbers = [1,2,3,4,5,6,7,8,9,10];

    address[] public senders;
    uint[] public timestamps;

    uint private _timestampsAfter2KCount;

    uint constant private JAN_2K_TIMESTAMP = 946702800;

    function getNumbers() external view returns (uint[] memory) {
        return numbers;
    }

    function resetNumbers() external {
        numbers = new uint[](10);
        for (uint i = 0; i < numbers.length; i++) {
            numbers[i] = i + 1; 
        }
    }

    function appendToNumbers(uint[] calldata _toAppend) external {
        for (uint i = 0; i < _toAppend.length; i++) {
            numbers.push(_toAppend[i]);
        }
    }

    function saveTimestamp(uint _unixTimestamp) external {
        timestamps.push(_unixTimestamp);
        senders.push(msg.sender);

        if (_unixTimestamp > JAN_2K_TIMESTAMP) {
            _timestampsAfter2KCount++;
        }
    }

    function afterY2K() external view returns (uint[] memory, address[] memory) {
        uint[] memory timestampsResult = new uint[](_timestampsAfter2KCount);
        address[] memory sendersResult = new address[](_timestampsAfter2KCount);

        uint resultIndex = 0;
        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > JAN_2K_TIMESTAMP) {
                timestampsResult[resultIndex] = timestamps[i];
                sendersResult[resultIndex] = senders[i];

                resultIndex++;
            }
        }

        return (timestampsResult, sendersResult);
    }

    function resetSenders() external {
        delete senders;
    }

    function resetTimestamps() external {
        delete timestamps;
    }
}
