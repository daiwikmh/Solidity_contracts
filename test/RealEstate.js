const { expect } = require("chai");
const { ethers } = require("hardhat");

const tokens = (n) => {
  return ethers.parseUnits(n.toString(), "ether");
};

const ether = tokens;

describe("RealEstate", () => {
  let realEstate, escrow
  let deployer, seller
  let nftID = 1
  let purchasePrice = ether(100);
  let escrowAmount = ether(10);

  beforeEach(async () => {
    accounts = await ethers.getSigners();
    deployer = accounts[0];
    seller = deployer;
    // buyer = accounts[1];
    // inspector = accounts[2];
    // lender = accounts[3];

    const RealEstate = await ethers.getContractFactory("RealEstate");

    const Escrow = await ethers.getContractFactory("Escrow");

    //deploy contracts
    realEstate = await RealEstate.deploy();
    // escrow = await Escrow.deploy();
    // await realEstate.deployed();
    escrow = await Escrow.deploy()
    //   realEstate.address,
    //   nftID,
    //   purchasePrice,
    //   escrowAmount,
    //   seller.address,
    //   buyer.address,
    //   inspector.address,
    //   lender.address
    // );
    // await escrow.deployed();

    // let transaction = await realEstate.connect(seller).mint(seller.address);
    // await transaction.wait();

    // // Approve Escrow contract to transfer NFT on behalf of seller
    // transaction = await realEstate
    //   .connect(seller)
    //   .approve(escrow.address, nftID);
    // await transaction.wait();
  });

  describe("Deployment", async () => {
    it("sends an nft to seller", async () => {
      expect(await realEstate.ownerOf(nftID)).to.equal(seller.address);
    });
});
  });

//   describe("selling real estate", async () => {
//     let balance, transaction;
//     it("executes a succesfull transaction", async () => {
//       expect(await realEstate.ownerOf(nftID)).to.equal(seller.address);

//       transaction = await escrow
//         .connect(buyer)
//         .depositEarnest({ value: escrowAmount });

//       transaction = await escrow.connect(buyer).finalizeSale();
//       await transaction.wait();
//       console.log("sale is finalised");

//       expect(await realEstate.ownerOf(nftID)).to.equal(buyer.address);
//     });
//   });
// });
