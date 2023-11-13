import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("EmployeeStorage", function () {
  async function deployEmployeeStorageFixture() {
    const EmployeeStorage = await ethers.getContractFactory("EmployeeStorage");
    const employeeStorage = await EmployeeStorage.deploy(
      10,
      "Name",
      100000,
      1010,
    );

    return {employeeStorage};
  }

  describe("Constructor and Getters", function () {
    it("Return expected values", async function () {
      const { employeeStorage } = await loadFixture(deployEmployeeStorageFixture);

      expect(await employeeStorage.name()).to.equal("Name");
      expect(await employeeStorage.idNumber()).to.equal(1010);

      expect(await employeeStorage.viewSalary()).to.equal(100000);
      expect(await employeeStorage.viewShares()).to.equal(10);
    });
  });

  describe("Shares granting", function () {
    it("Returns expected values", async function () {
      const { employeeStorage } = await loadFixture(deployEmployeeStorageFixture);
      
      await expect(employeeStorage.grantShares(6000)).to.be.revertedWith("Too many shares");

      let response = await employeeStorage.grantShares(4990);
      expect(await employeeStorage.viewShares()).to.equal(5000);

      await expect(employeeStorage.grantShares(100)).to.be.revertedWithCustomError(employeeStorage, "TooManyShares").withArgs(5100);
    });
  });
});
