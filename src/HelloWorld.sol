// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract HelloWorld {
    string public message;
    uint public version = 1;

    constructor(string memory _message) {
        message = _message;
    }

    function updateMessage(string memory _message) public {
        message = _message;
    }

    function updateVersion() public {
        version++;
    }

    function getMessage() public view returns (string memory) {
        return message;
    }

    function getVersion() public view returns (uint) {
        return version;
    }
}
