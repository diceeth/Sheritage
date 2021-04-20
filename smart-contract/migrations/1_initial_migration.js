const Migrations = artifacts.require("AssetControl.sol");

module.exports = function (deployer) {
  deployer.deploy(Migrations, 1618030769, 'tango');
};

// 1618030769 = 10 April
