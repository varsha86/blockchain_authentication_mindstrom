// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Authentication {
    struct User {
        string username;
        bool isRegistered;
    }

    mapping(address => User) public users;

    event UserRegistered(string username, address userAddress);
    event UserLoggedIn(address userAddress);

    // Register a new user
    function register(string memory _username) public {
        require(!users[msg.sender].isRegistered, "User already registered.");
        users[msg.sender] = User(_username, true);
        emit UserRegistered(_username, msg.sender);
    }

    // Log in the user
    function login() public returns (bool) {  // Remove 'view' here
        require(users[msg.sender].isRegistered, "User not registered.");
        emit UserLoggedIn(msg.sender);
        return true;
    }
}
