// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import { MyNFT } from "../src/ERC721.sol";

contract ERC721Test is Test  {
    MyNFT mynft;
    address A = address(0x1);
    address B = address(0x2);

    function setUp() public {
        mynft = new MyNFT();
    }

    function testMintToken() public {
        mynft.mint(A, 1);
        assertEq(mynft.balanceOf(A), 1);
        assertEq(mynft.ownerOf(1), A);
    }

    function testTransferToken() public {
        mynft.mint(A, 100);
        emit log_uint(mynft.balanceOf(A));
        emit log_uint(mynft.balanceOf(B));
        assertEq(mynft.balanceOf(B), 0);

        vm.startPrank(A);
        mynft.safeTransferFrom(A, B, 100);
        emit log_address(mynft.ownerOf(100));

        assertEq(mynft.ownerOf(100), B);
        assertEq(mynft.balanceOf(A), 0);
        assertEq(mynft.balanceOf(B), 1);
    }

    function testBalance() public {
        mynft.mint(A, 1);
        mynft.mint(A, 2);
        mynft.mint(A, 3);
        assertEq(mynft.balanceOf(A), 3);
    }

    function testOnlyOwnerCanBurn() public {
        mynft.mint(A, 1);
        vm.startPrank(A);
        mynft.burn(1);
        assertEq(mynft.balanceOf(A), 0);
    }

    function testOnlyOwnerCanBurnRevert() public {
        mynft.mint(A, 1);
        vm.startPrank(B);
        vm.expectRevert("not owner");
        mynft.burn(1);
    }
}