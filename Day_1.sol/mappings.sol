//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyContract
{
//Mappings
//mapping(key=>value)map_name  -->format;
mapping(uint=>string)public names;

constructor ()
{
names[1] = "Adam";
names[2] = "Bruce";
names[3] = "Carl";
}

//We can do the same thing with our custom datatype struct also

struct Book
{
    string title;
    string author;
}

mapping(uint=>Book)public books;

function addBook
(
    uint id,
    string memory _title,
    string memory _author
    ) 
    public
    {
books[id] = Book(_title,_author);
    }
    

//The following mapping is completely differnt from above mapping books;
mapping(address=>mapping(uint=>Book))public myBooks;

//Creating function to add value to "MyBooks"

function addMyBook
(uint id,
string memory _title,
string memory _author
)public 
{
myBooks[msg.sender][id] = Book(_title,_author);
// here msg.sender acts like global variable which will be 
//taken from user basicalyy his crypto address to be used.

}



}
