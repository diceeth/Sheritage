pragma solidity 0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "./TokenWallet.sol";


contract AssetControl is Ownable, TokenWallet{

    uint public periodTime;

    string public hintAnswer;

    
    constructor(uint _periodeTime, string memory _hintAnswer){
        periodTime = _periodeTime;
        hintAnswer = _hintAnswer;
        super;
    }
    
    struct User {
      address userAddress;
      uint getPercent;
      uint addressCounter;
      bool initialized;
    }
    
    
    // 0x75D11987488c7ecE47fFDFa623Bf109b85a1Af33
    // 0x32a672D6A26758e3493b59749c614A08078044E1
    // 0xa1a5628EaEeeE529Cb62f3ef63A7de4B72726bCD
    
    uint totalpercent;
    
    mapping (address => User) public userStructs;
    
    address[] userAddresses;
    
    modifier checkPeriod{
        require(block.timestamp >= periodTime, "Can't be release yet!");
        _;
    }
    
   function addUser(address _userAddress, uint _getPercent) public onlyOwner{
        require(!userStructs[_userAddress].initialized);
        totalpercent += _getPercent;
        require(totalpercent <= 100, '100% over');
    
        userStructs[_userAddress].userAddress = _userAddress;
        userStructs[_userAddress].getPercent = _getPercent;
        userStructs[_userAddress].addressCounter = 0;
        userStructs[_userAddress].initialized = true;
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
            require(userStructs[userAddresses[i]].userAddress == msg.sender, 'Address need to be add fisrt!');
            require(userStructs[userAddresses[i]].addressCounter == 0, 'Only Once!');
            _transfer(owner(), payable(msg.sender), balanceOf(owner())*userStructs[userAddresses[i]].getPercent/(100-alreadyReleasePercent)); 
            userStructs[userAddresses[i]].addressCounter++;
        }
    }
    
    function transferToken(address recipient, uint256 amount) external payable{
        _transfer(_msgSender(), recipient, amount*initialPrice);
    }
    
} 
