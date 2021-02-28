pragma solidity ^0.7.0;

contract ArtFactory {

    struct Content{
        string videoUrl;
        string thumbnailUrl;
        string title;
        string description;
        uint128 price;
        mapping(address => bool) viewingAllowed;
    }

    struct Artist{
        string nickname;
        string email;
        address artistAddress;
        // Content[] contents;
    }

    address public owner;
    address[] public artists;
    mapping(address => Artist) public artistMapping;
    mapping(address => bool) public signedUp;
    mapping(address => Content[]) public contentsMapping;
    mapping(address => uint) public balances;

    modifier notSignedUp {
        require(!signedUp[msg.sender]);
        _;
    }

    constructor () public {
        owner = msg.sender;
    }

  
    function createArtist(string memory _nickname, string memory _email) public notSignedUp returns (bool){
        // Content[] memory emptyContents;
        Artist memory artist = Artist(_nickname, _email, msg.sender);

        artists.push(msg.sender);

        // Set the address as signed up
        signedUp[msg.sender] = true;
        artistMapping[msg.sender] = artist;

        return true;
    }

    
    function createContent(
        string memory _videoUrl,
        string memory _thumbnailUrl,
        string memory _title,
        string memory _description,
        uint128 _price)
        public returns (bool) {
            Content memory content = Content(_videoUrl, _thumbnailUrl, _title, _description, _price);

            

            contentsMapping[msg.sender].push(content);
          
            return true;
    }
  
}
