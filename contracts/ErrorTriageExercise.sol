// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract ErrorTriageExercise {
    /**
     * Finds the difference between each uint with it's neighbor (a to b, b to c, etc.)
     * and returns a uint array with the absolute integer difference of each pairing.
     */
    function diffWithNeighbor(
        uint _a,
        uint _b,
        uint _c,
        uint _d
    ) public pure returns (uint[] memory) {
        uint[] memory results = new uint[](3);

        results[0] = absDifference(_a, _b);
        results[1] = absDifference(_b, _c);
        results[2] = absDifference(_c, _d);

        return results;
    }

    /**
     * Changes the _base by the value of _modifier. Base is always > 1000.  Modifiers can be
     * between positive and negative 100;
     */
    function applyModifier(
        uint _base,
        int _modifier
    ) public pure returns (uint) {
        if (_modifier >= 0) {
            return _base + uint(_modifier);
        }
        else {
            return _base - uint(-_modifier);
        }
    }

    /**
     * Pop the last element from the supplied array, and return the modified array and the popped
     * value (unlike the built-in function)
     */
    uint[] arr;

    function popWithReturn() public returns (uint) {
        uint deletedNumber = arr[arr.length - 1];

        uint[] memory arrCopy = new uint[](arr.length - 1);
        for (uint i = 0; i < arrCopy.length; i++) {
            arrCopy[i] = arr[i];
        }

        resetArr();
        arr = arrCopy;

        return deletedNumber;
    }

    // The utility functions below are working as expected
    function addToArr(uint _num) public {
        arr.push(_num);
    }

    function getArr() public view returns (uint[] memory) {
        return arr;
    }

    function resetArr() public {
        delete arr;
    }

    function absDifference(uint x, uint y) private pure returns (uint) {
        return x > y ? x - y : y - x;
    }
}