// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DAOVoting {
    struct Proposal {
        string description;
        uint voteCount;
    }

    address public owner;
    mapping(address => bool) public voters;
    Proposal[] public proposals;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function addProposal(string memory _description) public onlyOwner {
        proposals.push(Proposal(_description, 0));
    }

    function vote(uint proposalIndex) public {
        require(!voters[msg.sender], "Already voted");
        require(proposalIndex < proposals.length, "Invalid proposal");

        voters[msg.sender] = true;
        proposals[proposalIndex].voteCount += 1;
    }

    function getProposal(uint index) public view returns (string memory, uint) {
        require(index < proposals.length, "Invalid index");
        Proposal storage proposal = proposals[index];
        return (proposal.description, proposal.voteCount);
    }
}

