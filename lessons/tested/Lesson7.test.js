const { expect } = require("chai")
const { ethers } = require("hardhat")

describe("lesson7", function () {
    let owner
    let other_addr
    let demo

  beforeEach(async function () {
    [owner,other_addr]= await ethers.getSigners()

    const DemoContract = await ethers.getContractFactory("lesson7",owner)
    demo = await DemoContract.deploy()
    await demo.waitForDeployment()
  })

  async function snedMoney(sender){
    const amount =100
    const txData ={
        to:demo.target,
        value:amount,   
    }

    const tx = await sender.sendTransaction(txData);
    await tx.wait();
    return [tx,amount]
  }
    it("should allow to send money", async function() {
        const[sendMoneyTx, amount] =await sendMoneyTx(other_addr)
        console.log(sendMoneyTx)

        // const timestamp =(
        //  await ethers.provider.getBlock(sendMoneyTx.blocknumber
        //).timestamp
        //)
    })  
  
})
 