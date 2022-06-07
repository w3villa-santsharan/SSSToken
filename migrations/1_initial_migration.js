const SSSToken = artifacts.require("SSSToken");

module.exports = function (deployer) {
  deployer.deploy(SSSToken);
};
