# BambooCrowdfundTest
Front end Engineer Role  Web3 Challenge Test 


##########
BAMBOOHR##
##########

Requirements:
    - Submit to Github  in public repo 
    - Be sure to use truffle, ganache and hardhat to run locally.
    - Record a video of the contract and dapp using loom.
    - explain the code and output.
    - Must have functionality and explanation 


Company Links
    https://academy.metacrafters.io/courses
    academy@metacrafters.io
    https://discord.com/invite/metacraftersio


STEPS:
- Outline Contract (PsuedoCode)
- Create Contract (Solidity)
- Create Automated Test
- Test Contract Functionality 
- Initialize Truffle in our project 
- Install dependecies (@openzeppelin) npm install @openzeppelin/contracts

- Launch Ganache Instance 



Errors:
"Could not find artifacts for" BambooTestCrowdfund
Truffle fails to compile imports
Invalid number of parameters for contract deployment BambooTestCrowdfund


Details:
Truffle implementation was giving me trouble.
I can't deploy my crowdfund contract and am working towards a solution, I'm sure it's something simple that I'm missing.



The reason for "Could not find artifacts for" in truffle?
https://ethereum.stackexchange.com/questions/42711/the-reason-for-could-not-find-artifacts-for-in-truffle
https://github.com/trufflesuite/truffle/issues/4620

Truffle fails to compile imports
https://ethereum.stackexchange.com/questions/135542/truffle-fails-to-compile-imports


How to deploy contracts that take parameters in their initialisers using Truffle? [duplicate]
https://ethereum.stackexchange.com/questions/30764/how-to-deploy-contracts-that-take-parameters-in-their-initialisers-using-truffle
var Contract = artifacts.require("./Contract.sol");

module.exports = function(deployer) {
  deployer.deploy(Contract,constructor_param_1, constructor_param_2, ,constructor_param_3, ,constructor_param_etc);

};


How to Install WSL for Windows 10 - Includes WSL2 Optional Steps
https://forum.openzeppelin.com/t/how-to-install-wsl-for-windows-10-includes-wsl2-optional-steps/2542




############
COMMANDS ###
############

    Setup Truffle 
        mkdir <project name>
        cd <project name>
        truffle init

    Install Dependecies
        npm i -y
        npm i dotenv @truffle/hdwallet-provider
        
        Install Truffle 
        npm install -g truffle ganache-cli live-server


    Compile Contracts
        truffle compile 
