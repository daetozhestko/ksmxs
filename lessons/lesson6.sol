// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Demo{
    // public
    // external
    // internal
    // private

    //view
    //pure  
    string message ="hello"; //state
    uint public balance;
    
    fallback() external payable{

    }
    receive() external payable{
        balance +=msg.value;
    }

    function pay()external payable{
        balance +=msg.value;
    }

    //transaction
    function setMessage(string memory newMessage) external returns (string memory){
        message=newMessage;
        return message;
    }
    //call 
    function getBalance() public view returns(uint balanceNew){
        balanceNew =address(this).balance;
    }
    function getMessage() external view returns(string memory){
        return message;
    }

    function rate(uint amount) public pure returns(uint){
        return amount*3;
    }
} 