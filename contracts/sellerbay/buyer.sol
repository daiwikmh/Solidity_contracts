// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EventTicket is ERC1155, Ownable {
    // Struct to define an Event
    struct Event {
        uint256 eventId;        // Unique event ID
        string name;            // Event name
        string description;     // Short description of the event
        uint256 date;           // Event date and time (UNIX timestamp)
        string location;        // Event location
        string imageURI;        // Arweave/IPFS URI for the event image
    }

    // Mapping to store events
    mapping(uint256 => Event) private events;

    // Counter for unique event IDs
    uint256 private nextEventId;
   

    // Event emitted when a new event is created
    event EventCreated(
        uint256 indexed eventId,
        string name,
        string description,
        uint256 date,
        string location,
        string imageURI
    );

    // Event emitted when a ticket is purchased
    event TicketPurchased(
        uint256 indexed eventId,
        address indexed buyer,
        uint256 indexed tokenId,
        uint256 quantity
    );

    constructor() ERC1155("") {
    }

    // Function to create a new event
    function createEvent(
        string memory _name,
        string memory _description,
        uint256 _date,
        string memory _location,
        string memory _imageURI
    ) public onlyOwner returns (uint256) {
        require(bytes(_name).length > 0, "Event name cannot be empty");
        require(bytes(_description).length > 0, "Event description cannot be empty");
        require(_date > block.timestamp, "Event date must be in the future");
        require(bytes(_location).length > 0, "Event location cannot be empty");
        require(bytes(_imageURI).length > 0, "Event image URI cannot be empty");

        uint256 eventId = nextEventId;
        events[eventId] = Event({
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

    // Function to purchase a ticket
    function purchaseTicket(uint256 _eventId, uint256 _quantity) public {
        Event memory e = events[_eventId];
        require(bytes(e.name).length > 0, "Event does not exist");
        require(_quantity > 0, "Must purchase at least one ticket");
        require(block.timestamp < e.date, "Event has already occurred");

        uint256 tokenId = _eventId; // Use event ID as the token ID

        // Mint the tickets (ERC1155 supports batch minting, but here it's per purchase)
        _mint(msg.sender, tokenId, _quantity, "");

        emit TicketPurchased(_eventId, msg.sender, tokenId, _quantity);
    }

    // Function to get the total tickets minted for an event
    function getTotalTicketsMinted(uint256 _eventId) public view returns (uint256) {
        return totalSupply(_eventId);
    }

    // Function to get event details by ID
    function getEvent(uint256 _eventId) public view returns (
        string memory name,
        string memory description,
        uint256 date,
        string memory location,
        string memory imageURI
    ) {
        Event memory e = events[_eventId];
        require(bytes(e.name).length > 0, "Event does not exist");
        return (e.name, e.description, e.date, e.location, e.imageURI);
    }
}
