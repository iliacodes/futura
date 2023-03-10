const main = async () => {
  const gameContractFactory = await hre.ethers.getContractFactory('FuturaGame');
  const gameContract = await gameContractFactory.deploy(
    ["Nomad,", "StreetKid", "Corpo"],     // different factions
    ["https://i.imgur.com/EfVZ3Zf.jpg", "https://i.imgur.com/eqVA5Kz.png", "https://i.imgur.com/bT0xS02.jpg"], // images
    [100, 150, 200],                    // HP values
    [100, 75, 50]                       // Attack damage values
  );
  await gameContract.deployed();
  console.log("Contract deployed to:", gameContract.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();