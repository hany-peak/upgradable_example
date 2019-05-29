pragma solidity ^0.4.24;


contract InterfaceStarBucksCoffee {
    string public coffee_name;
    uint8 public coffee_price;
    string public coffee_size;
    uint8 public syrup_rate;
    address public coffee_holder;
    address public coffee_seller;
}

contract StarBucksCoex {
    
    event Ordedered(address _contract, string _name, uint8 _price, string _szie, uint8 _syrupRate, address _holder, address _seller, uint8 ordercount);
    event ChangedStaff(address _staff, address _from);
    struct coffee {
        address coffeeContract;
        string name;
        uint8 price;
        string size;
        uint8 syrup_rate;
        address _holder;
        address _seller;
    }
    mapping (uint8 => coffee) public orderbook;
    address public starbucks_staff;
    uint8 public ordercount; 
    
    constructor(address _starbucks_staff) public {
        starbucks_staff = _starbucks_staff;
    }
    
    function changeStaff(address _starbucks_staff) public returns(bool) {
        
        starbucks_staff = _starbucks_staff;
        
        emit ChangedStaff(_starbucks_staff, msg.sender);
    }
    
    function order(string memory _coffeeName, uint8 _coffeePrice, string memory _coffeeSize, uint8 _syrupRate) public returns (bool) {
        
        address madedCoffee = InterfaceStarBucksStaff(starbucks_staff).makeCoffee(_coffeeName, _coffeePrice, _coffeeSize, _syrupRate, msg.sender, starbucks_staff);
        
        emit Ordedered(madedCoffee, _coffeeName, _coffeePrice, _coffeeSize, _syrupRate, msg.sender, starbucks_staff, ordercount);
        
        orderbook[ordercount] = coffee(madedCoffee, _coffeeName, _coffeePrice, _coffeeSize, _syrupRate, msg.sender, starbucks_staff);
        
        ordercount++;
        
        return true;
    }
}


contract InterfaceStarBucksStaff {
    
    function makeCoffee(string memory _coffeeName, uint8 _coffeePrice, string memory _coffeeSize, uint8 _syrupRate, address _coffeeHolder, address _coffeeSeller) public returns (address);
}