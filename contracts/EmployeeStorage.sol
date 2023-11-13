// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract EmployeeStorage {
    uint16 shares;
    uint24 salary;
    uint256 public idNumber;
    string public name;

    error TooManyShares(uint16);

    uint16 constant private MAX_SHARES = 5000; 

    constructor(uint16 _shares, string memory _name, uint24 _salary, uint256 _idNumber) {
        shares = _shares;
        salary = _salary;
        name = _name;
        idNumber = _idNumber;
    }

    function viewSalary() external view returns (uint24) {
        return salary;
    }

    function viewShares() external view returns (uint16) {
        return shares;
    }

    function grantShares(uint16 _newShares) external {
        if (_newShares > MAX_SHARES) {
            revert("Too many shares");
        }

        if (shares + _newShares > MAX_SHARES) {
            revert TooManyShares(shares + _newShares);
        }

        shares += _newShares;
    }

    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload (_slot)
        }
    }

    function debugResetShares() public {
        shares = 1000;
    }
}
