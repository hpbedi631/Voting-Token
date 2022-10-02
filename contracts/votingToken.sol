// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./ERC20.sol";

contract Voting is ERC20 {

    address public owner;
    uint public  endTime;
    uint public endpoint;

    enum State { Open, Close, Expired}

    modifier Owner() {
        require(msg.sender == owner);
        _;
    }


    // Constructor

    uint token;
    constructor() ERC20("HarshdeepToken", "HIO") {

        owner = msg.sender;
        _mint(owner, token); //1000 * 10 ** 18);
    }

    State public state = State.Open; // 0

    modifier AtExpire() {
        require (((state == State.Expired || state == State.Close) && endTime + 24 hours < block.timestamp));
        _;
    }
    
    uint vote;
    mapping (address => uint) ownerToken;
    // Holders assigns tokens to the voters if state is open otherwise timeout message is provided
    function Holders(address _owner) public payable {
        if(state == State.Open) {
            ownerToken[_owner] += 1;
        } else {
            string memory timeout;
            timeout = "You are being timeout of this session because either your state has expired or closed by government provider (owner).";
        }
    }
    // checks how many tokens a owner has in his account
    function checkOwnerToken() public view returns (uint) {
        return ownerToken[msg.sender];
    }
    // Displays the amount of votes given by user
    function getVote() public view returns (uint) {
        return vote;
    }
    // registers the vote given by user
    function setVote(uint _vote) public {
        vote = _vote;
    }
    // checks and changes the state based on these on these conditions
    function checkVotingComplete() Owner  public {
        if (vote >= 5) {
            state = State.Close;
    }  else if (vote < 5) {
        state = State.Open;
    }
      else if (block.timestamp > endpoint) {
            state = State.Expired;
    }
    endTime = block.timestamp;
    }

    
 
    // To check if the owner has suffcient amount of token 
    function checkToken(uint _token) public returns (bool) {
        token = _token;
        if(ownerToken[msg.sender] > token || ownerToken[msg.sender] > 0) {
            return true; 
        } else {
            return false;
        }
    }
    // Party No 1:
    function Liberal(uint _token) public returns (uint) {
        checkToken(_token);
        ownerToken[msg.sender] -= 1;
        return vote++;

    }
    // Party No 2:
    function Conservatives(uint _token) public returns (uint) {
        checkToken(_token);
        ownerToken[msg.sender] -= 1;
        return vote++;
    }
    // Party No 3:
    function GreenParty(uint _token) public returns (uint) {
        checkToken(_token);
        ownerToken[msg.sender] -= 1;
        return vote++;

    }
    // Party No 4:
    function NDP(uint _token) public returns (uint) {
        checkToken(_token);
        ownerToken[msg.sender] -= 1;
        return vote++;
    }
    // Party No 5:
    function NewBlue(uint _token) public returns (uint) {
        checkToken(_token);
        ownerToken[msg.sender] -= 1;
        return vote++;
    }
    // checks the state is altered by Owner Or Time
    function CheckStateByOwner() public view Owner returns (bool) {

        if(state == State.Open || state == State.Close) {
        return true;
        }
        return false;       
    }

    


    // Adds token value to account
    function mint(address to, uint amount) public  {
        _mint(to,amount);         
    }
 
    // Removes token value from account
    function burn(address from, uint amount) public {
        _burn(from,amount);         
    }
 
      
}