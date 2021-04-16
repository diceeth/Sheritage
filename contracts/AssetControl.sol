pragma solidity 0.8.0;

import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "./TokenWallet.sol";

contract AssetControl is Ownable, TokenWallet{

    uint public periodTime;
    
    constructor(uint setPeriodTime){
        periodTime = setPeriodTime;
        super;
    }
    
    struct User {
      address userAddress;
      uint getPercent;
      uint addressCounter;
    }
    
    
    // 0x75D11987488c7ecE47fFDFa623Bf109b85a1Af33
    // 0x32a672D6A26758e3493b59749c614A08078044E1
    // 0xa1a5628EaEeeE529Cb62f3ef63A7de4B72726bCD
    
    uint totalpercent = 100;
    
    mapping (address => User) public userStructs;
    address[] userAddresses;
    
    modifier checkPeriod{
        require(block.timestamp >= periodTime, 'Date Problem!');
        _;
    }
    
   function addUser(address _userAddress, uint _getPercent) public onlyOwner{
        totalpercent = totalpercent - _getPercent;
        require(totalpercent >= 0, '100% over');

        userStructs[_userAddress].userAddress = _userAddress;
        userStructs[_userAddress].getPercent = _getPercent;
        userStructs[_userAddress].addressCounter = 0;
        userAddresses.push(_userAddress);
      
    }
    
    function getAllUsers() external view returns ( address[] memory) {
        return userAddresses;
    }
    
    function releaseAsset() external payable checkPeriod{
        uint alreadyReleasePercent = 0;
        
        for(uint i = 0; i < userAddresses.length ; i++){
            if(userStructs[userAddresses[i]].addressCounter == 1){
                alreadyReleasePercent += userStructs[userAddresses[i]].getPercent;
            }
        }
            
        for(uint i = 0; i < userAddresses.length ; i++){
            if(msg.sender == userAddresses[i]){
                require(userStructs[userAddresses[i]].addressCounter == 0, 'Only Once!');
                    _transfer(owner(), payable(msg.sender), balanceOf(owner())*userStructs[userAddresses[i]].getPercent/(100-alreadyReleasePercent)); 
                    userStructs[userAddresses[i]].addressCounter++;
                }
            }
        }
    
    function transferToken(address recipient, uint256 amount) external payable{
        _transfer(_msgSender(), recipient, amount*initialPrice);
    }
    
} 
