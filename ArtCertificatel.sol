pragma solidity ^0.4.10;
/*
 * Ownable
    /\__/\
   /`    '\
 === 0  0 ===
   \  --  /
  /        \
 /          \
|            |
 \  ||  ||  /
  \_oo__oo_/#######o
 */
contract Ownable {
/*Public variables*/
    address public owner;
    uint public LastChangeOfOwnership;
/*events for log*/
    event ChangeOfOwnership(address newOwner); 
/*construtor*/
  function Ownable() {
    owner = msg.sender;
  }
/* modifiers*/
  modifier onlyOwner() {
    if (msg.sender != owner) {
      throw;
    }
    _;
  }
/*methods*/

  function transferOwnership(address _newOwner) onlyOwner {
    if (_newOwner != address(0)) {
      owner = _newOwner;
      ChangeOfOwnership(owner);
      LastChangeOfOwnership = block.timestamp;
    }
  }

}

/*
 * Artgallery
    /\__/\
   /`    '\
 === 0  0 ===
   \  --  /
  /        \
 /          \
|            |
 \  ||  ||  /
  \_oo__oo_/#######o
 */

contract ArtGallery is Ownable {

/*Public variables*/
    address public Gallery = this;

    mapping ( bytes32 => address) public ArtList;

/* the mapping maps an identifier (bytes32) to an address. 
Use sha3 for identifier ex:
"numéro de série: 0001; date de fabrication: 09082016;Lieu de fabrication: 75017PARIS"
sha3(00010908201675017PARIS)=
15905d14d04be568d5e263a664721065a484ffe9c94b474947d601468b2ea744
We then deploy a contract ArtCertificate for that identifier and log the address*/

/*events for log*/

event ArtAdded(bytes32 identifier, address ArtCertificateAddress, string description);
event ArtChanged(bytes32 identifier, address ArtCertificateAddress, string description);


/*methods*/

function addArt(   
                    bytes32 _identifier,
                    string _ArtistName,
                    string _ArtWorkTitle,
                    string _Description,
                    string _ArtWorkDate,
                    address _newOwner
                    )  
                        onlyOwner() {
/* verify if the identifier is not already mapped */
if (ArtList[_identifier] != 0x0){throw;}
    address _newArtCertificate = new ArtCertificate(
                                                     Gallery,
                                                    _identifier,
                                                    _ArtistName,
                                                    _ArtWorkTitle,
                                                    _Description,
                                                    _ArtWorkDate,
                                                    _newOwner
                                                    );
           ArtList[_identifier] = _newArtCertificate;
           ArtAdded(_identifier, _newArtCertificate, _Description);
                                    }

function changeArt(   
                    bytes32 _identifier,
                    string _ArtistName,
                    string _ArtWorkTitle,
                    string _Description,
                    string _ArtWorkDate,
                    address _newOwner
                    )  
                        onlyOwner() {
/* verify if the identifier is not already mapped */
if (ArtList[_identifier] == 0x0){throw;}
    address _newArtCertificate = new ArtCertificate(
                                                     Gallery,
                                                    _identifier,
                                                    _ArtistName,
                                                    _ArtWorkTitle,
                                                    _Description,
                                                    _ArtWorkDate,
                                                    _newOwner
                                                    );
           ArtList[_identifier] = _newArtCertificate;
           ArtChanged(_identifier, _newArtCertificate, _Description);
                                    }
    
    
}


contract ArtCertificate is Ownable{
    address public ArtGallery;
    bytes32 public identifier;
    string public ArtistName;
    string public ArtWorkTitle;
    string public Description;
    string public ArtWorkDate;
    // CertificateNumber is the address of the contract i.e 
    // address public CertificateNumber = this;
    
    // string public number of copy;
    // string public serial number;

    /*
    Methods
    */
    function ArtCertificate(
    address _ArtGallery,
    bytes32 _identifier,
    string _ArtistName,
    string _ArtWorkTitle,
    string _Description,
    string _ArtWorkDate,
    address _newOwner){
    ArtGallery = _ArtGallery;
    identifier=_identifier;
    ArtistName=_ArtistName;
    ArtWorkTitle=_ArtWorkTitle;
    Description=_Description;
    ArtWorkDate=_ArtWorkDate;
    transferOwnership(_newOwner);
    }
}
