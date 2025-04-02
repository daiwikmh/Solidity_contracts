import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const ACCOUNT_PRIVATE_KEY = "a73f439105df962fa7af1a273c400e562f1065977926c423762d1c48c7432aac";

const config: HardhatUserConfig = {
  solidity: "0.8.28",
  paths: {
    sources: "./contracts/pyth", // Set the source folder
  },
  networks: {
    "educhain": {
      // Testnet configuration
      url: `https://rpc.open-campus-codex.gelato.digital`,
      accounts: [ACCOUNT_PRIVATE_KEY],
    },
    "sonic": {
      url: "https://rpc.blaze.soniclabs.com",
      accounts: [ACCOUNT_PRIVATE_KEY]
    },
    "coretestnet": {
      url: 'https://rpc.test2.btcs.network',
      accounts: [ACCOUNT_PRIVATE_KEY],
      chainId: 1114,
   },
   "linea_sepolia": {
    url: `https://rpc.sepolia.linea.build/`,
    accounts: [ACCOUNT_PRIVATE_KEY],
  },
  'base-sepolia': {
      url: 'https://sepolia.base.org',
      accounts: [ACCOUNT_PRIVATE_KEY],
    },
  }
};

export default config;
