const Migrations = artifacts.require("Sheritage.sol");

module.exports = function (deployer) {
  deployer.deploy(Migrations, 1618030769);
};

// 1618030769 = 10 April
