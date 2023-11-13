import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";

const MAX_UINT_256 = BigInt(Math.pow(2, 256)) - 1n;

describe("BasicMath", function () {
  async function deployBasicControlStructuresFixture() {
    const ControlStructures = await ethers.getContractFactory("ControlStructures");
    const controlStructures = await ControlStructures.deploy();

    return {controlStructures};
  }

  describe("Functions", function () {
    describe("FizzBuzz", function () {
      it("Returns expected strings", async function () {
        const { controlStructures } = await loadFixture(deployBasicControlStructuresFixture);
        
        let response = await controlStructures.fizzBuzz(15);
        expect(response).to.equal("FizzBuzz");

        response = await controlStructures.fizzBuzz(5);
        expect(response).to.equal("Buzz");

        response = await controlStructures.fizzBuzz(3);
        expect(response).to.equal("Fizz");

        response = await controlStructures.fizzBuzz(23);
        expect(response).to.equal("Splat");
      });
    });

    describe("DoNotDisturb", function () {
      it("Returns expected strings", async function () {
        const { controlStructures } = await loadFixture(deployBasicControlStructuresFixture);
        
        let response = await controlStructures.doNotDisturb(1900);
        expect(response).to.equal("Evening!");

        response = await controlStructures.doNotDisturb(1799);
        expect(response).to.equal("Afternoon!");

        response = await controlStructures.doNotDisturb(800);
        expect(response).to.equal("Morning!");

        await expect(controlStructures.doNotDisturb(1205)).to.be.revertedWith("At lunch!");

        await expect(controlStructures.doNotDisturb(600))
          .to.be.revertedWithCustomError(controlStructures, "AfterHours")
          .withArgs(600);

        await expect(controlStructures.doNotDisturb(2300))
          .to.be.revertedWithCustomError(controlStructures, "AfterHours")
          .withArgs(2300);

        await expect(controlStructures.doNotDisturb(2400)).to.be.revertedWithPanic();
      });
    });
  });
});
