pragma solidity ^0.5.3;

contract InterfaceModule {
    function getType() public view returns(uint8);
    function getName() public view returns(bytes32);
}

contract InterfaceNumModule is InterfaceModule {
    
    address parentComponent;
    
    constructor(address _parentComponent) public {
        parentComponent = _parentComponent;
    }
    
    function calNum(uint8 _num) public returns (uint8);
    function calNum2() public returns (uint8);
}

contract MinusNumModule is InterfaceNumModule {
    
    constructor(address _parentComponent) 
    public
    InterfaceNumModule(_parentComponent) {
        
    }
    
    modifier onlyParentComponent {
        require(msg.sender == parentComponent);
        _;
    }
    
    function getType() public view returns(uint8) {
        return 1;
    }
    
    function getName() public view returns(bytes32) {
        return "MinusNumModule";
    }
    
    function calNum(uint8 _num) public onlyParentComponent returns (uint8) {
        
        _num--;
        
        return _num;
    }
    
    function calNum2() public onlyParentComponent returns (uint8) {
        
        uint8 getNum = InterfaceParentComponent(parentComponent).num();
        
        getNum--;
        
        return getNum;
    }
    
}

contract InterfaceParentComponent {
    
    uint8 public num = 0;
    
}