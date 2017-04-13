pragma solidity ^0.4.10;
/*
 * Ownable
 */
contract Ownable {
    address public owner;
    uint public LastChangeOfOwnership;


    event ChangeOfOwnership(address newOwner); 

  function Ownable() {
    owner = msg.sender;
  }
  modifier onlyOwner() {
    if (msg.sender != owner) {
      throw;
    }
    _;
  }
  function transferOwnership(address _newOwner) onlyOwner {
    if (_newOwner != address(0)) {
      owner = _newOwner;
      ChangeOfOwnership(owner);
      LastChangeOfOwnership = block.timestamp;
    }
  }

}


contract ArtGallery is Ownable {
               /* stuff and mapping  */
    mapping ( bytes32 => address) public ArtList;
/* the mapping map an identifier (bytes32) to an address. 
Use sha3 for identifier ex:
"numéro de série: 0001; date de fabrication: 09082016;Lieu de fabrication: 75017PARIS"
sha3(00010908201675017PARIS)=
15905d14d04be568d5e263a664721065a484ffe9c94b474947d601468b2ea744
We then deploy a contract ArtCertificate for that identifier and log the address*/



/*  //if(!_MechsList.isMech.gas(1000)(msg.sender)) throw; */
    
            /*event for the logs*/

event ArtAdded(bytes32 identifier, address ArtCertificateAddress, string description);
event ArtChanged(bytes32 identifier, address ArtCertificateAddress, string description);


            /* ADMIN METHODS */

function addArt(   
    bytes32 _identifier,
    string _ArtistName,
    string _ArtWorkTitle,
    string _Description,
    string _ArtWorkDate,
    address _newOwner)  
                        onlyOwner() {
/* verify if the identifier is not already mapped */
if (ArtList[_identifier] != 0x0){throw;}
    address _newArtCertificate = new ArtCertificate(
    _identifier,
    _ArtistName,
    _ArtWorkTitle,
    _Description,
    _ArtWorkDate,
    _newOwner
    );
           ArtList[_identifier] = _newArtCertificate;
           ArtAdded(_identifier, _newArtCertificate, _Description);}
}

contract ArtCertificate is Ownable{
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
    bytes32 _identifier,
    string _ArtistName,
    string _ArtWorkTitle,
    string _Description,
    string _ArtWorkDate,
    address _newOwner){
    identifier=_identifier;
    ArtistName=_ArtistName;
    ArtWorkTitle=_ArtWorkTitle;
    Description=_Description;
    ArtWorkDate=_ArtWorkDate;
    transferOwnership(_newOwner);
    }
}
