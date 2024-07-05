// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChain {

    // Define the product structure
    struct Product {
        uint productId;
        string productName;
        string currentLocation;
        uint quantity;
        address currentOwner;
    }

    // Define the shipment structure
    struct Shipment {
        uint transferId;
        string origin;
        string destination;
        uint dateOfDeparture;
        uint expectedArrivalDate;
        string status; // For example, "In Transit", "Delivered", etc.
    }

    // Define the role enum
    enum Role { Administrator, Supplier, LogisticEmployee, Auditor }

    // Define the user structure
    struct User {
        address userAddress;
        Role role;
    }

    // Mappings to store products, shipments, and users
    mapping(uint => Product) public products;
    mapping(uint => Shipment) public shipments;
    mapping(address => User) public users;

    // Event declarations for logging
    event ProductAdded(uint productId, string productName, string currentLocation, uint quantity, address currentOwner);
    event ProductRemoved(uint productId);
    event ShipmentAdded(uint transferId, string origin, string destination, uint dateOfDeparture, uint expectedArrivalDate, string status);
    event ShipmentUpdated(uint transferId, string status);
    event UserAdded(address userAddress, Role role);
    event UserRemoved(address userAddress);

    // Modifier to restrict access based on role
    modifier onlyRole(Role _role) {
        require(users[msg.sender].role == _role, "Access denied: Insufficient permissions");
        _;
    }

    // Function to add a new user
    function addUser(address _userAddress, Role _role) public onlyRole(Role.Administrator) {
        users[_userAddress] = User(_userAddress, _role);
        emit UserAdded(_userAddress, _role);
    }

    // Function to remove a user
    function removeUser(address _userAddress) public onlyRole(Role.Administrator) {
        delete users[_userAddress];
        emit UserRemoved(_userAddress);
    }

    // Function to add a new product
    function addProduct(uint _productId, string memory _productName, string memory _currentLocation, uint _quantity) public onlyRole(Role.Supplier) {
        products[_productId] = Product(_productId, _productName, _currentLocation, _quantity, msg.sender);
        emit ProductAdded(_productId, _productName, _currentLocation, _quantity, msg.sender);
    }

    // Function to remove a product
    function removeProduct(uint _productId) public onlyRole(Role.Administrator) {
        delete products[_productId];
        emit ProductRemoved(_productId);
    }

    // Function to add a new shipment
    function addShipment(uint _transferId, string memory _origin, string memory _destination, uint _dateOfDeparture, uint _expectedArrivalDate, string memory _status) public onlyRole(Role.LogisticEmployee) {
        shipments[_transferId] = Shipment(_transferId, _origin, _destination, _dateOfDeparture, _expectedArrivalDate, _status);
        emit ShipmentAdded(_transferId, _origin, _destination, _dateOfDeparture, _expectedArrivalDate, _status);
    }

    // Function to update shipment status
    function updateShipment(uint _transferId, string memory _status) public onlyRole(Role.LogisticEmployee) {
        require(bytes(shipments[_transferId].status).length != 0, "Shipment does not exist");
        shipments[_transferId].status = _status;
        emit ShipmentUpdated(_transferId, _status);
    }

    // Function to get product details
    function getProduct(uint _productId) public view returns (Product memory) {
        require(users[msg.sender].role == Role.Supplier || users[msg.sender].role == Role.LogisticEmployee || users[msg.sender].role == Role.Auditor, "Access denied: Insufficient permissions");
        return products[_productId];
    }

    // Function to get shipment details
    function getShipment(uint _transferId) public view returns (Shipment memory) {
        require(users[msg.sender].role == Role.LogisticEmployee || users[msg.sender].role == Role.Auditor, "Access denied: Insufficient permissions");
        return shipments[_transferId];
    }
}
