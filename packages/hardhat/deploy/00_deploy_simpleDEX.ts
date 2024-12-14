import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { Contract } from "ethers";

const deployYourContract: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  
  const { deployer } = await hre.getNamedAccounts();
  const { deploy } = hre.deployments;

  const tokenA = await deploy("TokenA", {from: deployer, log:true}) // Primero despliego el TOKEN A
  const tokenB = await deploy("TokenB", {from: deployer, log:true}) // Luego el TOKEN B

  await deploy("SimpleDEX", {
    from: deployer,
    args: [tokenA.address, tokenB.address], // Le paso como argumentos las direcciones de los dos contratos
    log: true,
  });
};

export default deployYourContract;

// Tags are useful if you have multiple deploy files and only want to run one of them.
// e.g. yarn deploy --tags YourContract
deployYourContract.tags = ["SimpleDEX"];
