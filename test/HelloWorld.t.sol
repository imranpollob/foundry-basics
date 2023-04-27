// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "../src/HelloWorld.sol";

contract HelloWorldTest is Test {
    HelloWorld public helloWorld;

    function setUp() public {
        helloWorld = new HelloWorld("Hello, World!");
    }

    function testMessage() public {
        assertEq(helloWorld.getMessage(), "Hello, World!");
    }

    function testVersion() public {
        assertEq(helloWorld.getVersion(), 1);
    }

    function testUpdateMessage() public {
        helloWorld.updateMessage("Hello, World! 2");
        emit log(helloWorld.getMessage());
        assertEq(helloWorld.getMessage(), "Hello, World! 2");
    }

    function testUpdateVersion() public {
        helloWorld.updateVersion();
        assertEq(helloWorld.getVersion(), 2);
    }

    function testUpdateMessageFuzz(string memory _message) public {
        helloWorld.updateMessage(_message);
        assertEq(helloWorld.getMessage(), _message);
    }
}
