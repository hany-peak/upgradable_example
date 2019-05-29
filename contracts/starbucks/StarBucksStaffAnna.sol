pragma solidity ^0.4.24;

contract InterfaceStarBucksStaff {
    
    function makeCoffee(string memory _coffeeName, uint8 _coffeePrice, string memory _coffeeSize, uint8 _syrupRate, address _coffeeHolder, address _coffeeSeller) public returns (address);
}


contract StarBucksStaffAnna is InterfaceStarBucksStaff {
    
    function makeCoffee(
        string memory _coffeeName, 
        uint8 _coffeePrice, 
        string memory _coffeeSize, 
        uint8 _syrupRate, 
        address _coffeeHolder, 
        address _coffeeSeller
    ) public returns (address) {
        address coffeeContract = new StarBucksCoffee(_coffeeName,_coffeePrice,_coffeeSize,_syrupRate,_coffeeHolder, _coffeeSeller); 
        
        StarBucksCoffee(coffeeContract).transferOwnership(_coffeeHolder);
        
        return coffeeContract;
    }
    
}


contract Ownable {
  address public owner;

  event OwnershipRenounced(address indexed previousOwner);
  
  event OwnershipTransferred(
    address indexed previousOwner,
    address indexed newOwner
  );


  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  constructor() public {
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Allows the current owner to relinquish control of the contract.
   */
  function renounceOwnership() public onlyOwner {
    emit OwnershipRenounced(owner);
    owner = address(0);
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param _newOwner The address to transfer ownership to.
   */
  function transferOwnership(address _newOwner) public onlyOwner {
    _transferOwnership(_newOwner);
  }

  /**
   * @dev Transfers control of the contract to a newOwner.
   * @param _newOwner The address to transfer ownership to.
   */
  function _transferOwnership(address _newOwner) internal {
    require(_newOwner != address(0));
    emit OwnershipTransferred(owner, _newOwner);
    owner = _newOwner;
  }
}
contract InterfaceStarBucksCoffee is Ownable {
    string public coffee_name;
    uint8 public coffee_price;
    string public coffee_size;
    uint8 public syrup_rate;
    address public coffee_holder;
    address public coffee_seller;
}

contract StarBucksCoffee is InterfaceStarBucksCoffee {
    
    constructor(string memory _name, uint8 _price, string memory _size, uint8 _rate, address _holder, address _seller) public {
        coffee_size = _size;
        coffee_name = _name;
        syrup_rate = _rate;
        coffee_price = _price;
        coffee_holder = _holder;
        coffee_seller = _seller;
    }
    string public content = "Hi, It is maded From Anna";
    
}