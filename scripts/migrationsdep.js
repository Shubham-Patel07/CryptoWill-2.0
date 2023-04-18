const { ethers } = require("hardhat");

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