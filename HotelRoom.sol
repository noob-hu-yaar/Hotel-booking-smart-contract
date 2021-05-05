pragma solidity ^0.6.0;

contract HotelRoom {
    
    enum Statuses {Vacant, Occupied}
    Statuses currentStatus;
    event Occupy(address _occupant, uint _value);
    
    address payable public owner; //pay to this person
    
    constructor() public {
        owner = msg.sender; //referring to user calling this function
        currentStatus = Statuses.Vacant;
    }
    
    modifier onlyWhileVacant {
        require(currentStatus == Statuses.Vacant, "Currently occupied"); 
        _;
    }
    
    modifier costs (uint _amount) {
       require(msg.value >= _amount, "Not enough ether provided"); 
       _;
    }
    
    receive() external payable onlyWhileVacant costs (2 ether) { //book a room and pay
        
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);  
        emit Occupy(msg.sender, msg.value);
    }
    
}