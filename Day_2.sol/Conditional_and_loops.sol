//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyContract
{
//Conditionals 
//loops




// function isEvenNumber(uint number) public view returns(bool)
// {
//     if(number % 2==0)return true;
//     else return false; 
// }

//More better way of writing above function
function isEvenNumber(uint number) public view returns(bool)
{
    return(number% 2==0);
}


uint[] numbers = [1,2,3,4,5,6,7,8,9,10];

function countEvenNumber()public view returns(uint)
{
    uint counter = 0;
 for(uint i = 0;i<numbers.length; i++)
 {
if(isEvenNumber(numbers[i]))counter++;
 }
 return counter;
}
}
