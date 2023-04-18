const { ethers } = require("hardhat");

async function main() {
  // Deploy MyWill contract
  const MyWill = await ethers.getContractFactory("MyWill");
  const myWill = await MyWill.deploy(
    "paton Name", // name of the client/patron
    "Owner's address", // owner's address
    86400, // locking period (in seconds)
    "Beneficiary's address" // beneficiary's address
  );

  // Wait for the contract to be mined
  await myWill.deployed();

  console.log("MyWill deployed to:", myWill.address);
}

// Run the deployment script
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });