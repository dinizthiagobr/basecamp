// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

contract AddressBook is Ownable {
    error ContactNotFound(uint);

    struct Contact {
        uint id;
        string firstName;
        string lastName;
        uint[] phoneNumbers;
    }

    mapping (uint => bool) private idExists;
    mapping (uint => uint) private idToIndex;
    Contact[] private contacts;
    uint private contactsCount;

    constructor(address _owner) Ownable(_owner) {}

    function addContact(
        uint _id,
        string calldata _firstName,
        string calldata _lastName,
        uint[] calldata _phoneNumbers
    ) public onlyOwner {
        Contact memory newContact = Contact(
            _id,
            _firstName,
            _lastName,
            _phoneNumbers
        );

        contactsCount++;
        contacts.push(newContact);
        idExists[_id] = true;
        idToIndex[_id] = contacts.length - 1;
    }

    function deleteContact(uint _id) public onlyOwner {
        if (!idExists[_id]) {
            revert ContactNotFound(_id);
        }

        contactsCount--;
        idExists[_id] = false;
        delete idToIndex[_id];
    }

    function getContact(uint _id) public view returns (Contact memory) {
        if (!idExists[_id]) {
            revert ContactNotFound(_id);
        }

        return contacts[idToIndex[_id]];
    }

    function getAllContacts() public view returns (Contact[] memory) {
        Contact[] memory result = new Contact[](contactsCount);
        uint resultIndex = 0;

        for (uint i = 0; i < contacts.length; i++) {
            if (!idExists[contacts[i].id]) {
                continue;
            }

            result[resultIndex] = contacts[i];
            resultIndex++;
        }

        return result;
    }
}

contract AddressBookFactory {
    function deploy() public returns (address) {
        return address(new AddressBook(msg.sender));
    }
}