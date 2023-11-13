import { ethers } from "hardhat";

async function main() {
  const addressBookFactory = await ethers.deployContract("AddressBookFactory");
  await addressBookFactory.waitForDeployment();
  console.log(`AddressBookFactory deployed to ${addressBookFactory.target}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
