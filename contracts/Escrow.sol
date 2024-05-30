// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    event Approved(uint);

    constructor(address _beneficiary, address _arbiter) payable {
        depositor = msg.sender;
        beneficiary = _beneficiary;
        arbiter = _arbiter;
    }

    function approve() external {
        require(msg.sender == arbiter);
        uint balance = address(this).balance;
        (bool s, ) = beneficiary.call { value: balance }("");
        require(s);
        emit Approved((balance));
    }
}