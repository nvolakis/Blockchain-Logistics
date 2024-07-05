# Created by Nestor Volakis - May - June 2024 
# CDS211 Advanced Cryptographic and Security Technologies Assignment 2024

Advanced Cryptographic and Security Technologies
# SupplyChain Smart Contract

This project is a Supply Chain management system implemented as a smart contract on the Ethereum blockchain using Solidity. It allows tracking of pharmaceutical products from manufacturing to delivery using role-based access control.

## Features

- Add and manage products.
- Track shipments and their status.
- Role-based access control with different roles such as Administrator, Supplier, LogisticEmployee, and Auditor.
- Events for logging important actions.

## Smart Contract Details

### Product Structure

```solidity
struct Product {
    uint productId;
    string productName;
    string currentLocation;
    uint quantity;
    address currentOwner;
}
```

### Shipment Structure

```solidity
struct Shipment {
    uint transferId;
    string origin;
    string destination;
    uint dateOfDeparture;
    uint expectedArrivalDate;
    string status; // For example, "In Transit", "Delivered", etc.
}
```

### User Roles

```solidity
enum Role { Administrator, Supplier, LogisticEmployee, Auditor }
```

### Functions

- `addUser(address _userAddress, Role _role)`: Adds a new user with a specified role.
- `removeUser(address _userAddress)`: Removes an existing user.
- `addProduct(uint _productId, string memory _productName, string memory _currentLocation, uint _quantity)`: Adds a new product (Supplier role required).
- `removeProduct(uint _productId)`: Removes an existing product (Administrator role required).
- `addShipment(uint _transferId, string memory _origin, string memory _destination, uint _dateOfDeparture, uint _expectedArrivalDate, string memory _status)`: Adds a new shipment (LogisticEmployee role required).
- `updateShipment(uint _transferId, string memory _status)`: Updates the status of an existing shipment (LogisticEmployee role required).
- `getProduct(uint _productId)`: Retrieves product details (access controlled).
- `getShipment(uint _transferId)`: Retrieves shipment details (access controlled).

## Deployment

### Using Remix IDE

1. Open [Remix IDE](https://remix.ethereum.org/).
2. Create a new file and name it `SupplyChain.sol`.
3. Paste the smart contract code into the file.
4. In the "Solidity Compiler" tab, select the compiler version `0.8.0` or higher.
5. Click "Compile SupplyChain.sol".
6. In the "Deploy & Run Transactions" tab, ensure the environment is set to `Remix VM (Cancun)`.
7. Deploy the contract.

### Using Truffle

1. Install Truffle: `npm install -g truffle`.
2. Create a new Truffle project: `truffle init`.
3. Add `SupplyChain.sol` to the `contracts` directory.
4. Create a migration script in the `migrations` directory.
5. Compile the contracts: `truffle compile`.
6. Deploy the contracts: `truffle migrate`.

### Using Hardhat

1. Install Hardhat: `npm install --save-dev hardhat`.
2. Initialize a new Hardhat project: `npx hardhat`.
3. Add `SupplyChain.sol` to the `contracts` directory.
4. Create a deployment script in the `scripts` directory.
5. Compile the contracts: `npx hardhat compile`.
6. Deploy the contracts: `npx hardhat run scripts/deploy.js`.

## Interacting with the Contract

### Using Remix

1. After deploying the contract, interact with it using the "Deployed Contracts" section in Remix.
2. Use the functions provided to add users, products, and shipments.

### Using Web3.js

1. Install Web3.js: `npm install web3`.
2. Connect to your contract using Web3.js and interact with it using the contract's ABI and address.

```javascript
const Web3 = require('web3');
const web3 = new Web3('http://localhost:8545'); // Change to your Ethereum node

const contractABI = []; // Paste ABI here
const contractAddress = '0x...'; // Contract address

const supplyChainContract = new web3.eth.Contract(contractABI, contractAddress);
```

## Contributing

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a new Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```

