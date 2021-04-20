pragma solidity 0.8.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract FAMtoken is ERC20{

    uint public supplyToken;
    
    string private _name;
    string private _symbol;
    
    constructor() ERC20(_name, _symbol){
        supplyToken = 1000;
        
        _name = 'FAMILY';
        _symbol = 'FAM';
        _mint(msg.sender, supplyToken * (1 ** uint256(decimals())));
    }
    
    
    function name() public view virtual override returns (string memory) {
        return _name;
    }
    
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }
    
    function transferToken(address recipient, uint256 amount) external payable{
        _transfer(_msgSender(), recipient, amount);
    }
} 
