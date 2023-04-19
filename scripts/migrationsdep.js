const { ethers } = require("hardhat");
require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-ethers");
require("@nomicfoundation/hardhat-chai-matchers");
require("dotenv").config();

async function main() {
  // Deploy Migrations contract
  const Migrations = await ethers.getContractFactory("Migrations");
  const migrations = await Migrations.deploy();

  console.log("Migrations deployed to:", migrations.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});