const { expect } = require("chai")
const { ethers } = require("hardhat")

describe("Payments", function () {
    let acc1 
    let acc2
    let demo

  beforeEach(async function () {
    [acc1,acc2]= await ethers.getSigners()
    const Factory = await ethers.getContractFactory("Payments")
    demo = await Factory.deploy()
    await demo.waitForDeployment()
  })
  
  it("should be deployed", async function(){
    expect(demo.target).to.be.properAddress
  })
  it("should have 0 ether by default",async function(){
    const balance = await demo.currentBalance()
    expect(balance).to.eq(0)
  })
  it("should be possible to send funds",async function(){
    const sum =100
    const msg ="hello from hardhat"
    const tx= await demo.connect(acc2).pay(msg,{ value:sum})
    
    await expect(() => tx)
        .to.changeEtherBalances([acc2,demo],[-sum,sum]);
    await tx.wait()

    const newPayment = await demo.getPayment(acc2.address,0)
    expect(newPayment.message).to.eq(msg)
    expect(newPayment.amount).to.eq(sum)
    expect(newPayment.from).to.eq(acc2.address)
    // console.log(newPayment)
    // const balance = await demo.currentBalance()
    // console.log(balance)
  })
})
 