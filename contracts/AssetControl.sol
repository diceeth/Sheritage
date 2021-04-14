pragma solidity 0.8.0;

import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "./TokenWallet.sol";

contract AssetControl is Ownable, TokenWallet{

    uint public periodTime;
    
    address public firstAddr; 
    address public middleAddr;
    address public lastAddr;
    
    uint public percentFirstAddr;    // 0x75D11987488c7ecE47fFDFa623Bf109b85a1Af33
    uint public percentMiddleAddr;   // 0x32a672D6A26758e3493b59749c614A08078044E1
    uint public percentLastAddr;     // 0xa1a5628EaEeeE529Cb62f3ef63A7de4B72726bCD
    
    uint public counterFirstAddr = 0;
    uint public counterMiddleAddr = 0;
    uint public counterLastAddr = 0;
    
    constructor(uint setPeriodTime, address setFirstAddr, address setMiddleAddr, address setLastCAddr, uint setPercentFirstAddr, uint setPercentMiddleAddr, uint setPercentLastAddr){
        require(setPercentFirstAddr+setPercentMiddleAddr+setPercentLastAddr == 100, '100 is all we got');

        periodTime = setPeriodTime;
        
        firstAddr = setFirstAddr;
        middleAddr = setMiddleAddr;
        lastAddr = setLastCAddr;
        
        percentFirstAddr = setPercentFirstAddr;
        percentMiddleAddr = setPercentMiddleAddr;
        percentLastAddr = setPercentLastAddr;
        
        super;
    }
    
    modifier checkPeriod{
        require(block.timestamp >= periodTime, 'Date Problem!');
        _;
    }
    
    function transferToken(address recipient, uint256 amount) external payable{
        supplyToken = supplyToken-amount;
        _transfer(_msgSender(), recipient, amount*initialPrice);
    }
    
    function releaseToken() external payable checkPeriod{
        if(msg.sender == firstAddr){
            require(counterFirstAddr < 1, 'Only Once!');
            if(counterMiddleAddr == 1 && counterLastAddr == 0){
                _transfer(owner(), payable(msg.sender), balanceOf(owner())*percentFirstAddr/(100-percentMiddleAddr));
                counterFirstAddr++;
            }else if(counterLastAddr == 1 && counterMiddleAddr == 0){
                _transfer(owner(), payable(msg.sender), balanceOf(owner())*percentFirstAddr/(100-percentLastAddr));
                counterFirstAddr++;
            }else if(counterMiddleAddr == 1 && counterLastAddr == 1){
                _transfer(owner(), payable(msg.sender), balanceOf(owner())*percentFirstAddr/(100-percentMiddleAddr-percentLastAddr));
                counterFirstAddr++;
            }else{
                _transfer(owner(), payable(msg.sender), balanceOf(owner())*percentFirstAddr/100);
                counterFirstAddr++;
            }
        }else if(msg.sender == middleAddr){
            require(counterMiddleAddr < 1, 'Only Once!');
            if(counterFirstAddr == 1 && counterLastAddr == 0){
                _transfer(owner(), payable(msg.sender), balanceOf(owner())*percentMiddleAddr/(100-percentFirstAddr));
                counterMiddleAddr++;
            }else if(counterLastAddr == 1 && counterFirstAddr == 0){
                _transfer(owner(), payable(msg.sender), balanceOf(owner())*percentMiddleAddr/(100-percentLastAddr));
                counterMiddleAddr++;
            }else if(counterFirstAddr == 1 && counterLastAddr == 1){
                _transfer(owner(), payable(msg.sender), balanceOf(owner())*percentMiddleAddr/(100-percentFirstAddr-percentLastAddr));
                counterMiddleAddr++;
            }else{
                _transfer(owner(), payable(msg.sender), balanceOf(owner())*percentMiddleAddr/100);
                counterMiddleAddr++;
            }
        }else if(msg.sender == lastAddr){
            require(counterLastAddr < 1, 'Only Once!');
            if(counterFirstAddr == 1 && counterMiddleAddr == 0){
                _transfer(owner(), payable(msg.sender), balanceOf(owner())*percentLastAddr/(100-percentFirstAddr));
                counterLastAddr++;
            }else if(counterMiddleAddr == 1 && counterFirstAddr == 0){
                _transfer(owner(), payable(msg.sender), balanceOf(owner())*percentLastAddr/(100-percentMiddleAddr));
                counterLastAddr++;
            }else if(counterFirstAddr == 1 && counterMiddleAddr == 1){
                _transfer(owner(), payable(msg.sender), balanceOf(owner())*percentLastAddr/(100-percentFirstAddr-percentMiddleAddr));
                counterLastAddr++;
            }else{
                _transfer(owner(), payable(msg.sender), balanceOf(owner())*percentLastAddr/100);
                counterLastAddr++;
            }
        }
    }
    
} 