pragma solidity 0.8.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract TokenWallet is ERC20{

    uint public initialPrice;
    uint public supplyToken;
    
    string private _name;
    string private _symbol;
    
    constructor() ERC20(_name, _symbol){
        initialPrice = 1 ether;
        supplyToken = 1000;
        
        _name = 'FAMILY';
        _symbol = 'FAM';
        _mint(msg.sender, supplyToken * (10 ** uint256(decimals())));
    }
    
    function name() public view virtual override returns (string memory) {
        return _name;
    }
    
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }
    
} 