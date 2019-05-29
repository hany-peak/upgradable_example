pragma solidity ^0.5.3;


contract InterfaceParentComponent {
    
    uint8 public num = 10;
    
}

contract ParentComponent is InterfaceParentComponent {
    
    struct ModuleInfo {
        bytes32 key;
        address moduleAddr;
    }
    
    uint8 public constant PlusOrMinus_KEY = 1;
    uint8 public constant MulOrDiv_KEY = 2;
    mapping(uint => address) public module;
    mapping (uint8 => ModuleInfo[]) public modules;
    
    event LogModuleRemoved(uint8 indexed _type, address _module, uint256 _timestamp);
    
    event LogModuleAdded(
        uint8 indexed _type,
        bytes32 _name,
        address _module,
        uint256 _timestamp
    );
    
    function calNum1() external returns (uint8) {
        num = InterfaceNumModule(module[PlusOrMinus_KEY]).calNum(num);
        return num;
    }
    function calNum2() external returns (uint8) {
        num = InterfaceNumModule(module[PlusOrMinus_KEY]).calNum2();
        return num;
    }
    
    function calNum3() external returns (uint8) {
        num = InterfaceNumModule(module[MulOrDiv_KEY]).calNum(num);
        return num;
    }
    
    function calNum4() external returns (uint8) {
        num = InterfaceNumModule(module[MulOrDiv_KEY]).calNum2();
        return num;
    }
    
    function addModule(address _moduleAddress) external returns (bool) {
        uint8 moduleType = InterfaceModule(_moduleAddress).getType();
        bytes32 moduleName = InterfaceModule(_moduleAddress).getName();
        
        modules[moduleType].push(ModuleInfo(moduleName, _moduleAddress));
        module[moduleType] = _moduleAddress;
        emit LogModuleAdded(moduleType, moduleName, _moduleAddress, block.timestamp);
        
        return true;
    }
    
    function removeModule(uint8 _moduleType, uint8 _moduleIndex) external returns(bool) {
        require(_moduleIndex < modules[_moduleType].length);
        require(module[_moduleType] != address(0));
        require(modules[_moduleType][_moduleIndex].moduleAddr != address(0));
        if(modules[_moduleType][_moduleIndex].moduleAddr == module[_moduleType]) {
            module[_moduleType] = address(0);
        }

        emit LogModuleRemoved(_moduleType, modules[_moduleType][_moduleIndex].moduleAddr, now);
        
        modules[_moduleType][_moduleIndex] = modules[_moduleType][modules[_moduleType].length - 1];
        
        modules[_moduleType].length = modules[_moduleType].length - 1;
        
        return true;
    }
}

contract InterfaceModule {
    function getType() public view returns(uint8);
    function getName() public view returns(bytes32);
}

contract InterfaceNumModule is InterfaceModule {
    
    function calNum(uint8 _num) public returns (uint8);
    function calNum2() public returns (uint8);
    
}
