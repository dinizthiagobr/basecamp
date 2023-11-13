// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";

contract FavoriteRecords {
    mapping(string => bool) public approvedRecords;
    string[] private _approvedRecordsList;

    string[9] private INITIAL_APPROVED_RECORDS = [
        "Thriller",
        "Back in Black",
        "The Bodyguard",
        "The Dark Side of the Moon",
        "Their Greatest Hits (1971-1975)",
        "Hotel California",
        "Come On Over",
        "Rumours",
        "Saturday Night Fever"
    ];

    mapping(address => string[]) public userFavorites;

    error NotApproved(string);

    constructor() {
        for (uint8 i = 0; i < INITIAL_APPROVED_RECORDS.length; i++) {
            approvedRecords[INITIAL_APPROVED_RECORDS[i]] = true;
            _approvedRecordsList.push(INITIAL_APPROVED_RECORDS[i]);
        }
    }

    function getApprovedRecords() external view returns (string[] memory) {
        return _approvedRecordsList;
    }

    function addRecord(string calldata _albumName) external {
        if (approvedRecords[_albumName] == true) {
            userFavorites[msg.sender].push(_albumName);
            return;
        }

        revert NotApproved(_albumName);
    }

    function getUserFavorites(address _address) external view returns (string[] memory) {
        return userFavorites[_address];
    }

    function resetUserFavorites() external {
        delete userFavorites[msg.sender];
    }
}
