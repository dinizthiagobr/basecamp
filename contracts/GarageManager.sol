// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";

contract GarageManager {
    struct Car {
        string make;
        string model;
        string color;
        uint numberOfDoors;
    }

    mapping(address => Car[]) public garage;

    error BadCarIndex(uint);

    function addCar(
        string calldata _make,
        string calldata _model,
        string calldata _color,
        uint _numberOfDoors)
    external {
        Car memory newCar = Car(_make, _model, _color, _numberOfDoors);
        garage[msg.sender].push(newCar);
    }

    function getMyCars() external view returns (Car[] memory) {
        return garage[msg.sender];
    }

    function getUserCars(address _address) external view returns (Car[] memory) {
        return garage[_address];
    }

    function updateCar(
        uint _carIndex,
        string calldata _make,
        string calldata _model,
        string calldata _color,
        uint _numberOfDoors)
    external {
        if (garage[msg.sender].length < _carIndex || garage[msg.sender][_carIndex].numberOfDoors == 0) {
            revert BadCarIndex(_carIndex);
        }

        Car storage existingCar = garage[msg.sender][_carIndex];
        existingCar.make = _make;
        existingCar.model = _model;
        existingCar.color = _color;
        existingCar.numberOfDoors = _numberOfDoors;
    }

    function resetMyGarage() external {
        delete garage[msg.sender];
    }
}
