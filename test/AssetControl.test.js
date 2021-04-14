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

    it('Check BalanceOf Success!', async() => {
        const result = await assetControlContract.balanceOf(account1);
        assert(parseFloat(result/1000000000000000000) === 900);
    });

    it('Relase Asset FirstAddr Success!', async() => {
        await assetControlContract.releaseToken({from: account2});
        const result = await assetControlContract.balanceOf(account2);
        assert(parseFloat(result/1000000000000000000) === 550);
    });

    it('Relase Asset MiddleAddr Success!', async() => {
        await assetControlContract.releaseToken({from: account3});
        const result = await assetControlContract.balanceOf(account3);
        assert(parseFloat(result/1000000000000000000) === 225);
    });

    it('Relase Asset LastAddr Success!', async() => {
        await assetControlContract.releaseToken({from: account4});
        const result = await assetControlContract.balanceOf(account4);
        assert(parseFloat(result/1000000000000000000) === 225);
    });

})