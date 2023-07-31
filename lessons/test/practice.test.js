const {expect} = require("chai")
const {ethers} =require("hardhat")

describe("AucEngine",function(){
    let owner
    let buyer
    let auct

    beforeEach(async function(){
        [owner,seller,buyer] = await ethers.getSigners()
        const AucEngine =await ethers.getContractFactory("AucEngine",owner)
        auct =await AucEngine.deploy()
        await auct.waitForDeployment()
    })  

    it("sets owner",async function(){
        const currentOwner = await  auct.owner()
        console.log(currentOwner)
        expect(currentOwner).to.eq(owner.address)
    })
})