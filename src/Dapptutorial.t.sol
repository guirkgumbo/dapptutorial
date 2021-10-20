// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";
import "./Dapptutorial.sol";

contract DapptutorialTest is DSTest {
    Dapptutorial dapptutorial;

    function setUp() public {
        dapptutorial = new Dapptutorial();
    }

    // Property based testing
    function test_withdraw_property(uint96 amount) public {
        payable(address(dapptutorial)).transfer(amount);
        uint preBalance = address(this).balance;
        dapptutorial.withdraw(42);
        uint postBalance = address(this).balance;
        assertEq(preBalance + amount, postBalance);    
    }

    // Symbolically executed tests
    // The symbolic execution engine is backed by an SMT solver. 
    // When symbolically executing more complex tests you may encounter test failures with an SMT Query Timeout message. 
    // In this case, consider increasing the smt timeout using the --smttimeout flag or DAPP_TEST_SMTTIMEOUT environment variable (the default timeout is 60000 ms). 
    // Note that this timeout is per smt query not per test, and that each test may execute multiple queries (at least one query for each potential path through the test method).
    function test_withdraw_symbolically(uint guess) public {
        payable(address(dapptutorial)).transfer(1 ether);
        uint preBalance = address(this).balance;
        dapptutorial.withdraw(guess);
        uint postBalance = address(this).balance;
        assertEq(preBalance + 1 ether, postBalance);
    }

    // Invariant tests
    // See github readme for invariant tests explanation
    // https://github.com/dapphub/dapptools/tree/master/src/dapp#invariant-testing
    function invariant_totalSupply() public {
        assertEq(token.totalSupply(), initialTotalSupply);
    }

    // Testing against RPC state
    // See github readme for RPC state
    // https://github.com/dapphub/dapptools/tree/master/src/dapp#testing-against-rpc-state

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
