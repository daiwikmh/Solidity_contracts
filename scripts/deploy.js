const hre = require("hardhat");

async function main() {
  const EduStaking = await hre.ethers.getContractFactory("MyFirstPythContract");
  
  const staking = await EduStaking.deploy();
  
  await staking.deploymentTransaction().wait();
  
  console.log("Contract deployed to:", staking.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });