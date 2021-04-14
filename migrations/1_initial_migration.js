const Migrations = artifacts.require("AssetControl.sol");

module.exports = function (deployer) {
  deployer.deploy(Migrations, 1618030769, '0x22edbbee6D8DC5EdB22023aC6F8DF32b454e48c1', '0x23F242a08e3510f6BA1F7218E42cffFE62560D96', '0x11f1295ef4E4c220Ef04A95639d96927cE51b469', 50, 25, 25);
};

// 1618030769 = 10 April
