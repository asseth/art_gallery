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

contract ArtCertificate is Ownable{
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
    string _ArtistName,
    string _ArtWorkTitle,
    string _Description,
    string _ArtWorkDate,
    address _newOwner){
    ArtistName=_ArtistName;
    ArtWorkTitle=_ArtWorkTitle;
    Description=_Description;
    ArtWorkDate=_ArtWorkDate;
    transferOwnership(_newOwner);
    }
}

