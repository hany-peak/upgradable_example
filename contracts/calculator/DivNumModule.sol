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

contract DivNumModule is InterfaceNumModule {
    
    constructor(address _parentComponent) 
    public
    InterfaceNumModule(_parentComponent) {
        
    }
    
    modifier onlyParentComponent {
        require(msg.sender == parentComponent);
        _;
    }
    
    function getType() public view returns(uint8) {
        return 2;
    }
    
    function getName() public view returns(bytes32) {
        return "DivNumModule";
    }
    
    function calNum(uint8 _num) public onlyParentComponent returns (uint8) {
        require(_num < 100);
        
        uint8 num;
        
        num = _num / 2;
        
        return num;
    }
    
    function calNum2() public onlyParentComponent returns (uint8) {
        
        
        uint8 getNum = InterfaceParentComponent(parentComponent).num();
        
        require(getNum < 100);
        
        getNum = getNum / 2;
        
        return getNum;
    }
    
}

contract InterfaceParentComponent {
    
    uint8 public num = 0;
    
}