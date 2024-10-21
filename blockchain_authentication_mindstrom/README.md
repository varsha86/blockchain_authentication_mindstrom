Blockchain-Based Authentication System

#Overview
This project is a simple blockchain-based authentication system built using **Solidity**, **Truffle**, and **Ganache**. The system allows users to register and log in securely, leveraging blockchain technology to ensure decentralized, tamper-proof data management.

Features
- User registration and login via blockchain
- Decentralized and secure authentication
- Smart contract implementation using Solidity
- Deployment and interaction using Truffle and Ganache

Prerequisites

To run this project, you will need:

- [Node.js](https://nodejs.org/) (v16 or above recommended)
- [Truffle Suite](https://www.trufflesuite.com/)
- [Ganache](https://www.trufflesuite.com/ganache)
- A code editor (e.g., [VS Code](https://code.visualstudio.com/))

Getting Started

1. Clone the Repository
```bash
git clone https://github.com/yourusername/blockchain-auth-system.git
cd blockchain-auth-system
```

2. Install Dependencies
Ensure you have all required dependencies installed.

```bash
npm install
```

3. Compile the Smart Contract
Use Truffle to compile the Solidity smart contract.
```bash
truffle compile
```

4. Run Ganache
Start the Ganache blockchain locally, either by using the Ganache GUI or CLI.
```bash
ganache
```
Make sure the RPC URL in `truffle-config.js` matches the RPC URL from Ganache, which is usually `http://127.0.0.1:7545`.

5. Deploy the Smart Contract
Deploy the contract to the local blockchain provided by Ganache.

```bash
truffle migrate --reset
```

6. Interact with the Contract via Truffle Console
Open the Truffle console to interact with the deployed contract.

```bash
truffle console --network development
```

You can register a new user and log in using the following commands:

```javascript
let authInstance = await Authentication.deployed();

// Registering a new user
await authInstance.register({ from: "0xYourNewAddressHere" });

// Logging in a user
let isRegistered = await authInstance.login.call({ from: "0xYourNewAddressHere" });
console.log(isRegistered);
```

Smart Contract

Authentication.sol
This contract contains two main functions:

- register: Allows a new user to register on the blockchain. It ensures that the user is not already registered.
- login: Checks if a user is already registered.

Contract Code (Authentication.sol):
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Authentication {
    mapping(address => bool) public registeredUsers;

    event UserRegistered(address user);

    function register() public {
        require(!registeredUsers[msg.sender], "User already registered.");
        registeredUsers[msg.sender] = true;
        emit UserRegistered(msg.sender);
    }

    function login() public view returns (bool) {
        return registeredUsers[msg.sender];
    }
}
```

Project Structure
```
blockchain-auth-system/
├── build/                  # Truffle build artifacts
├── contracts/              # Solidity contracts
│   └── Authentication.sol  # Authentication smart contract
├── migrations/             # Deployment scripts
│   └── 2_deploy_contracts.js
├── test/                   # Truffle tests (optional)
├── truffle-config.js        # Truffle configuration file
└── README.md               # Project readme file
```

Configuration

In the `truffle-config.js` file, ensure that the `development` network is correctly set up to point to Ganache's local blockchain:

```javascript
module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*", // Match any network id
    },
  },
  compilers: {
    solc: {
      version: "0.8.0", // Specify the compiler version
    },
  },
};
```

Testing
You can add unit tests to ensure the contract works as expected using Truffle’s testing framework.

Example of a basic test in `test/authentication.test.js`:

```javascript
const Authentication = artifacts.require("Authentication");

contract("Authentication", accounts => {
  it("should register a user", async () => {
    const instance = await Authentication.deployed();
    await instance.register({ from: accounts[0] });
    const isRegistered = await instance.login.call({ from: accounts[0] });
    assert.equal(isRegistered, true, "User should be registered");
  });
});
```

To run tests:
```bash
truffle test
```

License
This project is licensed under the MIT License.
