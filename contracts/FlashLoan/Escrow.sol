// SPDX-License-identifier: MIT
pragma solidity 0.8.26;


interface IERC721{
    function transferFrom(address _from, address _to,uint256 _id)external; 
}


contract Escrow {
    address public nftAddress;
    uint256 public nftID;
    uint256 public purchasePrice;
    uint256 public escrowAmount;
    address payable public buyer;
     address payable public seller;
     address public inspector;
     address public lender;

    constructor(address _nftAddress,
     uint256 _nftID,
     uint256 _purchasePrice,
     uint256 _escrowAmount,
      address payable _seller,
       address payable _buyer,
       address _inspector,
       address _lender){
        nftAddress = _nftAddress;
        nftID = _nftID;
        purchasePrice = _purchasePrice;
        escrowAmount = _escrowAmount;
        seller = _seller;
        buyer = _buyer;
        inspector = _inspector;
        lender = _lender;
         
    }

    function depositEarnest() public payable {
        
    }

    function finalizeSale() external {
        IERC721(nftAddress).transferFrom(seller, buyer, nftID);
    }

}