const AssetControl = artifacts.require('AssetControl');

contract('AssetControl', accounts => {

    const account1 = accounts[0];
    const account2 = accounts[1];
    const account3 = accounts[2];
    const account4 = accounts[3];
    const amountToken = 100;

    let assetControlContract;

    before(async()=>{
        assetControlContract = await AssetControl.deployed();
    })


    it("Can deploy AssetControlContract", async ()=>{
        console.log(assetControlContract.address);
        assert.strictEqual(assetControlContract.address!=null && assetControlContract.address!=undefined, true, "The contract is not deployed yet");
    })

    it('Transfer Success!', async() => {
        await assetControlContract.transferToken(account2, amountToken);
        const result = await assetControlContract.balanceOf(account2);
        assert(parseFloat(result/1000000000000000000) === amountToken);
    });

    it('Add User Success!', async() => {
        await assetControlContract.addUser(account2,50);
        await assetControlContract.addUser(account3,25);
        await assetControlContract.addUser(account4,25);
    });

    it('Check BalanceOf Success!', async() => {
        const result = await assetControlContract.balanceOf(account1);
        assert(parseFloat(result/1000000000000000000) === 900);
    });

    it('Relase Asset User1 Success!', async() => {
        await assetControlContract.releaseAsset({from: account2});
        const result = await assetControlContract.balanceOf(account2);
        assert(parseFloat(result/1000000000000000000) === 550);
    });

    it('Relase Asset User2 Success!', async() => {
        await assetControlContract.releaseAsset({from: account3});
        const result = await assetControlContract.balanceOf(account3);
        assert(parseFloat(result/1000000000000000000) === 225);
    });

    it('Relase Asset User3 Success!', async() => {
        await assetControlContract.releaseAsset({from: account4});
        const result = await assetControlContract.balanceOf(account4);
        assert(parseFloat(result/1000000000000000000) === 225);
    });

})
