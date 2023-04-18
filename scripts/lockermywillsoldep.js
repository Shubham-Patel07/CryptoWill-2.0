const { ethers } = require("hardhat");

async function main() {
  // Deploy the lockerMyWill contract
  const LockerMyWill = await ethers.getContractFactory("lockerMyWill");
  const lockerMyWill = await LockerMyWill.deploy();

  // Wait for the contract to be mined
  await lockerMyWill.deployed();

  // Call the newLocker function to create a new locker
  const name = "MyLocker";
  const owner = "<owner-address>";
  const lockingTime = 123456;
  const beneficiary = "<beneficiary-address>";

  await lockerMyWill.newLocker(name, owner, lockingTime, beneficiary);

  console.log("Locker created!");

  // Get all the lockers associated with the owner address
  const lockers = await lockerMyWill.getLocker(owner);

  console.log("Lockers: ", lockers);
}
// Call the main function
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });