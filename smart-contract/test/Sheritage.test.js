const Sheritage = artifacts.require('Sheritage');

contract('Sheritage', accounts => {

    const account1 = accounts[0];
    const account2 = accounts[1];
    const account3 = accounts[2];
    const account4 = accounts[3];
    const amountToken = 1000;

    let sheritageContract;

    before(async()=>{
        sheritageContract = await Sheritage.deployed();
    });


    it("Can deploy Sheritage Contract", async ()=>{
        console.log(sheritageContract.address);
        assert.strictEqual(sheritageContract.address!=null && sheritageContract.address!=undefined, true, "The contract is not deployed yet");
    });

    it('Transfer Success!', async() => {
        await sheritageContract.transferToken(sheritageContract.address, amountToken);
        const result = await sheritageContract.balanceOf(sheritageContract.address);
        assert.strictEqual(parseFloat(result) === 1000, true);
    });

    it('Check Balance Success!', async() => {
        const result = await sheritageContract.balanceOf(account1);
        assert.strictEqual(parseFloat(result) === 0, true);
    });

    it('Add User Success!', async() => {
        await sheritageContract.addUser(account2,50);
        await sheritageContract.addUser(account3,25);
        await sheritageContract.addUser(account4,25);
    });

    it('Relase Asset User1 Success!', async() => {
        await sheritageContract.releaseAsset({from: account2});
        const result = await sheritageContract.balanceOf(account2);
        assert.strictEqual(parseFloat(result) === 500, true);
    });

    it('Relase Asset User2 Success!', async() => {
        await sheritageContract.releaseAsset({from: account3});
        const result = await sheritageContract.balanceOf(account3);
        assert.strictEqual(parseFloat(result) === 250, true);
    });

    it('Relase Asset User3 Success!', async() => {
        await sheritageContract.releaseAsset({from: account4});
        const result = await sheritageContract.balanceOf(account4);
        assert.strictEqual(parseFloat(result) === 250, true);
    });

})
