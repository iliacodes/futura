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

  let txn;

  txn = await gameContract.mintCharacterNFT(2);
  await txn.wait();

  let returnedTokenUri = await gameContract.tokenURI(1);
  console.log("Token URI:", returnedTokenUri);
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