var HelloWorld = artifacts.require("HelloWorld");
var BambooTestCrowdfund = artifacts.require("BambooCrowdfund")
var ERC20 = artifacts.require("MyToken")
module.exports = function(deployer) {
  
  deployer.deploy(BambooTestCrowdfund)
};