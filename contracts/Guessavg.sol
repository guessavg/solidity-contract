// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

library Library {
  struct data {
     uint val;
     bool exist;
   }
}

contract Guessavg {
    using Library for Library.data;

    address payable public owner;
    uint public seqNo;
    mapping(address => Library.data) public players;
    uint64 balance;

    event Join(uint seqNo, uint amount);
    event Win();

    constructor() payable {
        owner = payable(msg.sender);
    }

    function join() public payable {
        address player = msg.sender;
        uint64 amount = uint64(msg.value);
        balance += uint64(amount);
        seqNo++;
        if (!players[player].exist) {
            players[player].val = amount;
            players[player].exist = true;
        }
        emit Join(seqNo, amount);
        owner.transfer(address(this).balance);
    }
}
