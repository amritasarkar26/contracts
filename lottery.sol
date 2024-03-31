// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract lottery{
    address public manager;
    address[] public players;
     
    constructor() {
        manager = msg.sender;
    }
    function enter() public payable{
        require(msg.value > 0, "Minimum contribution is 0.01 ether");
        players.push(msg.sender);

    }

    function random() private view returns (uint) {
    // Using block.difficulty, block.timestamp, and players' addresses as a source of randomness
    uint rand = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
    return rand % players.length;
}

   
modifier restricted(){
    require(msg.sender== manager, "Only the manager can call this function");
    _;

}
function getPlayers() public view returns (address[] memory) {
    return players;
}
} 

