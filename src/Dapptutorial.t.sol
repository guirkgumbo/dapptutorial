// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";
import "./Dapptutorial.sol";

contract DapptutorialTest is DSTest {
    Dapptutorial dapptutorial;

    function setUp() public {
        dapptutorial = new Dapptutorial();
    }

    function test_withdraw_property(uint96 amount) public {
        payable(address(dapptutorial)).transfer(amount);
        uint preBalance = address(this).balance;
        dapptutorial.withdraw(42);
        uint postBalance = address(this).balance;
        assertEq(preBalance + amount, postBalance);    
    }

    function test_withdraw_symbolically(uint guess) public {
        payable(address(dapptutorial)).transfer(1 ether);
        uint preBalance = address(this).balance;
        dapptutorial.withdraw(guess);
        uint postBalance = address(this).balance;
        assertEq(preBalance + 1 ether, postBalance);
    }

    function test_withdraw() public {
        payable(address(dapptutorial)).transfer(1 ether);
        uint preBalance = address(this).balance;
        dapptutorial.withdraw(42);
        uint postBalance = address(this).balance;
        assertEq(preBalance + 1 ether, postBalance);
    }

    function testFail_withdraw_wrong_pass() public {
        payable(address(dapptutorial)).transfer(1 ether);
        uint preBalance = address(this).balance;
        dapptutorial.withdraw(1);
        uint postBalance = address(this).balance;
        assertEq(preBalance + 1 ether, postBalance);
    }

    receive() external payable {
        
    }
}
