// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract EventTicket {
    // Struct to define an Event
    struct Event {
        uint256 eventId;
        string name;            
        string description;     
        uint256 date;           
        string location;       
        string imageURI;        
    }

    
    mapping(uint256 => Event) private eventdata;

  
    uint256 private nextEventId;

   
    event EventCreated(
        uint256 indexed eventId,
        string name,
        string description,
        uint256 date,
        string location,
        string imageURI
    );

  
    function createEvent(
        string memory _name,
        string memory _description,
        uint256 _date,
        string memory _location,
        string memory _imageURI
    ) public returns (uint256) {
        require(bytes(_name).length > 0, "Event name cannot be empty");
        require(bytes(_description).length > 0, "Event description cannot be empty");
        require(_date > block.timestamp, "Event date must be in the future");
        require(bytes(_location).length > 0, "Event location cannot be empty");
        require(bytes(_imageURI).length > 0, "Event image URI cannot be empty");

        uint256 eventId = nextEventId;
        eventdata[eventId] = Event({
            eventId: eventId,
            name: _name,
            description: _description,
            date: _date,
            location: _location,
            imageURI: _imageURI
        });

        nextEventId++;

        emit EventCreated(eventId, _name, _description, _date, _location, _imageURI);

        return eventId;
    }

    // Function to get event details by ID
    function getEvent(uint256 _eventId) public view returns (
        string memory name,
        string memory description,
        uint256 date,
        string memory location,
        string memory imageURI
    ) {
        Event memory e = eventdata[_eventId];
        require(bytes(e.name).length > 0, "Event does not exist");
        return (e.name, e.description, e.date, e.location, e.imageURI);
    }
}
