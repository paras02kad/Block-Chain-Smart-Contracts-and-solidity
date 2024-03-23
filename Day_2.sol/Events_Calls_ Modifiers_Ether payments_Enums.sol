//SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

// contract HotelRoom
// {
    //Ether Payments
    //Modifiers
    //Visibility
    //Events
    //Enums



    /*
    Sure, let's break down the line `address payable public owner;` in a Solidity smart contract:

- `address`: This is a data type in Solidity used to 
store Ethereum addresses. 
Addresses are used to identify accounts on the Ethereum blockchain.

- `payable`: This is a modifier in Solidity that can be applied to addresses. 
It allows the address to receive and handle incoming Ether (the cryptocurrency of the Ethereum network). When an address is marked as `payable`, it can receive Ether through functions or by direct transfer.

- `public`: This is an access modifier in Solidity that specifies the visibility of
 the variable. When a variable is declared as `public`, Solidity automatically 
 generates a getter function for it, 
allowing other contracts or external users to read its value.

- `owner`: This is the name of the variable. 
In this case, it likely represents the owner or administrator of the smart contract.

- `address payable public owner;`: Putting it all together, this line declares a public 
variable named `owner` of type `address payable`.
 This variable is used to store the Ethereum address of the owner of the smart contract, 
 and it can receive Ether. Additionally, 
 Solidity generates a public getter function for accessing the value of the `owner` variable.
    */


    

    /*
This code snippet appears to be from a Solidity smart contract. Let's break down what each part does:

1. `constructor()`: This is a constructor function, which is executed only once when the contract is deployed. In this case, it doesn't take any arguments. 

2. `owner = msg.sender;`: In the constructor, this line assigns the address of the account that deployed the contract (`msg.sender`) to the `owner` variable. 
This effectively sets the owner of the contract to be the account that deployed it.

3. `function book() public`: This is a function named `book`, 
which is declared as `public`, meaning it can be called from outside the contract.

4. `owner.transfer(msg.value)`: Inside the `book` function, this line transfers Ether (`msg.value`) from the caller of the function (the sender) to the `owner` of the contract. 
   - `owner`: Refers to the address of the contract owner.
   - `transfer`: is a function available for addresses in Solidity used to send 
   Ether to another address.
   - `msg.value`: Represents the amount of Ether sent to this function call.

So, the `book` function allows anyone to send Ether to the owner of the contract. 
When someone calls the `book` function and sends Ether along with it, 
that Ether is transferred from the sender to the owner of the contract.

    */


    // function book()payable 
    // {
    //  owner.transfer(msg.value);

    // }


//  function book()public
//     {
// owner.transfer(msg.value);
//     }

/*
The difference between these two functions lies in their function modifiers:

1. `function book() payable`: This function declaration includes the `payable` modifier. 
When a function is marked as `payable`, it means that it can receive Ether along with the function call. Users can send Ether along with the invocation of this function.

2. `function book() public`: This function declaration does not include the `payable` modifier. Without this modifier, the function cannot directly receive Ether. If Ether is sent along with the function call, 
it will cause a runtime error, as the function is not designed to handle incoming Ether.

Both functions perform the same operation, which is transferring any Ether 
sent with the function call to the `owner`. However, 
the first function allows users to send Ether directly with the function call, 
while the second function does not permit sending Ether with the call.
*/


/*
Now after doing the payment we want to change the sataus of the room 
from default to occupies that is occupied from vacant.
So,we will declare enums for it in our smart contract.
*/




//Making some more functions for our booking system

//  function book()payable public
//     {
//         //Check price
//         require(msg.value >= 2 ether, "Not enough Ether provided");
//         //check availibility
//         require(currentStatus == statuses.Vacant,"Already booked");
        
// owner.transfer(msg.value);

// CurrentStatus = Statuses.Occupied;
   

/*
This line of Solidity code is a `require` statement commonly used in smart 
contracts to enforce conditions that must be met for a function to execute successfully. 
Let's break it down:

- `require`: This is a keyword in Solidity used for validating conditions. 
If the condition provided evaluates to false, it will revert the transaction 
and revert any state changes made during the execution of the function.

- `msg.value`: This is a global variable in Solidity representing the amount of 
Ether (in Wei) sent with the function call.

- `>= 2 ether`: This is the condition being checked. It ensures 
that the amount of Ether sent with the function call is greater than or equal to 2 ether.

- `"Not enough Ether provided"`: This is the error 
message that will be shown if the condition evaluates to false and the transaction is reverted. It provides feedback to the user about why the transaction failed.

Putting it all together, this line of code ensures that when this function is called, the sender must provide at least 2 ether (in Wei) along with the transaction. If the sender does not provide enough Ether, the transaction will be reverted with the specified error message. This condition is commonly used in scenarios like booking functions to ensure that users meet a minimum 
payment requirement before proceeding with the booking.
*/

 //}



 //Making the above function with the use of modifier.
 //And with the use of Events



contract HotelRoom
{

enum Statuses
 {
    Vacant,
    Occupied
    }
Statuses public CurrentStatus;


    address payable public owner;

    constructor()
    {
        owner = payable(msg.sender);
        CurrentStatus = Statuses.Vacant;
    }


 event Occupy(address _Occupant,uint _value);

modifier onlyWhileVacant()
{
 //check availibility
        require(CurrentStatus == Statuses.Vacant,"Already booked");
        _;
}

modifier costs(uint _amount)
{
     //Check price
    require(msg.value >= _amount, "Not enough Ether provided");
     _;
}

 function book()public payable onlyWhileVacant costs(2 ether)
    {
        CurrentStatus = Statuses.Occupied;
          //owner.transfer(msg.value);
          (bool sent, bytes memory data) = owner.call{value: msg.value}("");
          require(true);
          emit Occupy(msg.sender, msg.value);

          /*The two lines of Solidity code you provided are both used for transferring Ether to the `owner`, but they use different methods to do so. Let's break down each and discuss why the second one is often considered better:

1. `owner.transfer(msg.value);`:

   - `transfer`: This is a built-in function in Solidity used to transfer Ether from the contract to the specified address (`owner` in this case). It automatically reverts the transaction if the transfer fails, preventing any further execution of the current transaction.

   - Pros:
     - Straightforward and easy to use.
     - Automatically handles exceptions by reverting the transaction if the transfer fails.

   - Cons:
     - Limited gas stipend: The `transfer` function imposes a gas stipend of 2,300 gas (as of Solidity version 0.8.0), which may not be sufficient for some use cases, particularly if the receiving contract has complex logic or makes additional external calls.

2. `(bool sent, bytes memory data) = owner.call{value: msg.value}("");`:

   - `call`: This is a low-level function in Solidity used to invoke external contract functions and send Ether. It returns a boolean value indicating whether the call was successful and any data returned by the external contract.

   - `{value: msg.value}`: This is a part of the function call specifying the amount of Ether (in Wei) to send along with the call.

   - `("", "")`: These empty parameters represent the function selector and function arguments of the external contract function to be called. In this case, an empty string is used for both, indicating that no specific function is being called.

   - Pros:
     - Allows more control and flexibility over the transaction, including specifying gas limits and handling return data.
     - Can provide more detailed error handling and recovery mechanisms.

   - Cons:
     - Requires more careful error handling to prevent potential vulnerabilities such as reentrancy attacks.
     - May require additional gas for more complex operations or error handling.

Why the second one is often considered better:

- The second method using `call` provides more flexibility and control over the transaction, including gas stipends, error handling, and return data processing.
- It allows for more robust error handling, making it safer in certain scenarios where the `transfer` function's gas stipend might not be sufficient.
- It's particularly useful in cases where the receiving contract might have complex logic or requires specific gas limits.
  
In summary, while `transfer` is simpler and safer in many cases, `call` offers more control and flexibility, making it preferred for certain scenarios where more advanced transaction handling is needed. However, it also requires more careful implementation to 
ensure security and prevent potential vulnerabilities.
*/
    }


}