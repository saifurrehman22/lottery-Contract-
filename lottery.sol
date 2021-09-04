// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract lottery 
{
    address manager;
    address payable[] public participents;
    
    constructor ()
    {
     manager=msg.sender;   
    }
    
    receive() external payable
    {
        require(msg.value > 1 ether);
        participents.push(payable(msg.sender));
    }
    function getbalance() public view returns(uint)
    {
        require(msg.sender == manager);
        return address(this).balance;
    }
    function random() public view returns(uint)
    {
       return uint (keccak256(abi.encodePacked(block.timestamp,block.difficulty,participents.length)));
    }
    function Selectwinner() public 
    {
        require(msg.sender==manager);
        require(participents.length > 3);
        address payable winner;
        uint r = random();
        uint index = r % participents.length;
        winner = participents[index];
        winner.transfer(getbalance());
        participents =new address payable[](0);
    }
    
}

