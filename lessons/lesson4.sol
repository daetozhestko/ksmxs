// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Demo{
    // Struct
    struct Payment{
        uint amount;
        uint timeStamp;
        address from;
        string message;
    }
    struct Balance{
        uint totalPayments;
        mapping(uint => Payment) payments;
    }
    mapping(address=> Balance) public balances;
    
    function getPayment(address _addr,uint _index) public view returns(Payment memory){
        return balances[_addr].payments[_index];
    }

    function pay(string memory message) public payable{
        uint paymentNum=balances[msg.sender].totalPayments;
        balances[msg.sender].totalPayments++;
        Payment memory newPayment = Payment(
            msg.value,
            block.timestamp,
            msg.sender,
            message
        );
    
    balances[msg.sender].payments[paymentNum]=newPayment;
    }

    //Byte
    // bytes32 public myVar ="ZHARA ZHARA";
    // bytes public myDynVar ="BAM BOOM";

    // function demo() public view returns(bytes1){
    //     return myDynVar[0];
    // }
    //  dynamic Array
    // uint[] public items; 
    // uint public len;
    // function demo() public { 
    //     items.push(4);
    //     items.push(5);
    //     len =items.length;
    // }

    // function sampleMemory() public view returns(uint [] memory) {
    //     uint[] memory tempArray = new uint [](10); 
    //     tempArray[0]=1;
    //     return tempArray;
    // }
   // 2-Dimensional Arrays
    //    uint[3][2] public numbers;

    //    function demo() public{
    //     numbers= [
    //         [3,4,5],
    //         [6,7,8]
    //     ];
    //    }
    //Array
    // uint[10] public items;
    
    // function demo() public{
    //     items[0] =100;
    //     items[1]=200;
    //     items[3]=300;
    // }
    //Enum
    // enum Status {Paid,Delivered,Received  }
    // Status public currentStatus;

    // function pay() public{
    //     currentStatus=Status.Paid;
    // }
    // function delivered() public{
    //     currentStatus =Status.Delivered;
    // }
}   