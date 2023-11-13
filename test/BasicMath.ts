import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";

const MAX_UINT_256 = BigInt(Math.pow(2, 256)) - 1n;

describe("BasicMath", function () {
  async function deployBasicMathFixture() {
    const BasicMath = await ethers.getContractFactory("BasicMath");
    const basicMath = await BasicMath.deploy();

    return {basicMath};
  }

  describe("Functions", function () {
    describe("Adder", function () {
      it("Does not overflow", async function () {
        const { basicMath } = await loadFixture(deployBasicMathFixture);
        const { sum, error } = await basicMath.adder(20, 50);

        expect(sum).to.equal(70);
        expect(error).to.be.false;
      });

      it("Does overflow", async function () {
        const { basicMath } = await loadFixture(deployBasicMathFixture);
        const { sum, error } = await basicMath.adder(MAX_UINT_256, 255);

        expect(sum).to.equal(0);
        expect(error).to.be.true;
      });
    });

    describe("Subtractor", function () {
      it("Does not underflow", async function () {
        const { basicMath } = await loadFixture(deployBasicMathFixture);
        const { difference, error } = await basicMath.subtractor(50, 20);

        expect(difference).to.equal(30);
        expect(error).to.be.false;
      });

      it("Does underflow", async function () {
        const { basicMath } = await loadFixture(deployBasicMathFixture);
        const { difference, error } = await basicMath.subtractor(20, 50);

        expect(difference).to.equal(0);
        expect(error).to.be.true;
      });
    });
  });
});
