// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Demo {

    mapping(address => uint) public payments; //storage

    address public myAddr = 0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C;

    function recieveFunds() public payable{
        payments[msg.sender] = msg.value; 
    }

    function transferTo(address targetAddr,uint amount) public{
        address payable _to =payable(targetAddr);
        _to.transfer(amount);
    }
    
    function getbalance(address targetAddr) public view  returns (uint) {
        return targetAddr.balance;
    }

    string public myStr ="test"; //storage

    function demo(string memory newValueStr ) public {
        string memory myTempStr ="temp";
        myStr=newValueStr;
    }
}