// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Demo {
    uint8 public myValue =254;
    function inc() public{
        unchecked{
            myValue++;
        }
    }
//     uint public minimum; 
//     function demo() public{
//     minimum= type(uint8).min;
// }
//     uint public myUint =42;

//     function deom(uint _inputUint)public{
//         uint localUint =42;
//     }
//signed integers
    // int public myInt =-42;
//     bool public myBool = true; //state

//     function myFunc(bool _inputBool) public{
//         bool localBool =false; //local 
//         localBool && _inputBool
//         localBool || _inputBool
//         localBool == _inputBool
//         localBool != _inputBool
//         !localBool 
//     }
// 
} 