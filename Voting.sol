// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract VotingContract {
    
    event RegesteringCandidate(uint256 candidate_id,  string name, uint256 total_vote);
    event Voted(uint256 id);
    
    struct Candidate {
        string name;
        uint256 id;
        uint256 voteCount;
        string image;
    }
    
    
    mapping(address => bool) public voters;
    mapping(uint => Candidate) public candidates;
    
    uint256 public candidatesCount;
    
    modifier alreadyVoted(){
        require(voters[msg.sender] ==  false, 'The vote has already been casted');
        _;
    }
    
     function addCandidate(string memory _name, string memory _image) public {
        require(bytes(_name).length > 0, "Empty Name");
        candidates[candidatesCount] = Candidate(_name, candidatesCount, 0, _image);
        candidatesCount++;
        emit RegesteringCandidate(candidatesCount, _name, candidates[candidatesCount - 1].voteCount );
    }
    
    function addVote(uint256 _id) public alreadyVoted(){
        require(_id >= 0 && _id < candidatesCount, "Invalid option");
        voters[msg.sender] = true;
        candidates[_id].voteCount++;
        emit Voted(_id);
        // ,Candidates[_id].vote_count
    }    
    
}   