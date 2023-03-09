// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract FuturaGame {
    struct CharacterAttributes {
        uint characterIndex;
        string name;
        string imageURI;
        uint hp;
        uint maxHp;
        uint attackDamage;
        // physical attributes
        string apparel;
        string expression;
        string eyes;
        string gender;
        string hair;
        string helmet;
        string mouth;
        string nose;
        string skin;
        // mental attributes
        uint8 attractiveness;
        uint8 cool;
        uint8 strength;
        uint8 intelligence;
        // asset attributes
        string class;
        string allocation;
        string vehicle;
        string location;
        string pet;
        // additional attributes
        string weapon;
        string race;
        string ability;
    }

    // an array to hold default attributes of our characters.
    CharacterAttributes[] defaultCharacters;

    // Data passed in to the contract when it's first created initializing the characters.
    constructor(
        string[] memory characterNames,
        string[] memory characterImageURIs,
        uint[] memory characterHp,
        uint[] memory characterAttackDmg
    ) {
        // Loop through all the characters, and save their values in our contract so we can use them later when we mint our NFTs.
        for (uint i = 0; i < characterNames.length; i += 1) {
            defaultCharacters.push(
                CharacterAttributes({
                    characterIndex: i,
                    name: characterNames[i],
                    imageURI: characterImageURIs[i],
                    hp: characterHp[i],
                    maxHp: characterHp[i],
                    attackDamage: characterAttackDmg[i],
                    apparel: "",
                    expression: "",
                    eyes: "",
                    gender: "",
                    hair: "",
                    helmet: "",
                    mouth: "",
                    nose: "",
                    skin: "",
                    attractiveness: 0,
                    cool: 0,
                    strength: 0,
                    intelligence: 0,
                    class: "",
                    allocation: "",
                    vehicle: "",
                    location: "",
                    pet: "",
                    weapon: "",
                    race: "",
                    ability: ""
                })
            );

            CharacterAttributes memory c = defaultCharacters[i];
            console.log(
                "Done initializing %s w/ HP %s, img %s",
                c.name,
                c.hp,
                c.imageURI
            );
        }
    }

    function generateRandomAttributes(
        uint seed
    ) internal view returns (CharacterAttributes memory) {
        CharacterAttributes memory attributes = defaultCharacters[
            seed % defaultCharacters.length
        ];

        // Generate random values for hp, attackDamage, and strength
        attributes.hp =
            (uint(keccak256(abi.encodePacked(seed, "hp"))) % 1501) +
            1000;
        attributes.attackDamage =
            (uint(keccak256(abi.encodePacked(seed, "attackDamage"))) % 301) +
            150;
        attributes.strength = uint8(
            (uint(keccak256(abi.encodePacked(seed, "strength"))) % 100) + 1
        );

        attributes.attractiveness = uint8(
            (uint(keccak256(abi.encodePacked(seed, "attractiveness"))) % 100) +
                1
        );

        attributes.cool = uint8(
            (uint(keccak256(abi.encodePacked(seed, "cool"))) % 100) + 1
        );

        attributes.intelligence = uint8(
            (uint(keccak256(abi.encodePacked(seed, "intelligence"))) % 100) + 1
        );

        attributes.attackDamage += attributes.strength;

        // GENERATE RANDOM APPAREL
        uint256 apparelHash = uint256(
            keccak256(abi.encodePacked(seed, block.timestamp, "apparel"))
        );
        uint8 apparelRand = uint8(apparelHash % 100);
        if (apparelRand < 5) {
            attributes.apparel = "Combat-Tailored Biker Coat";
        } else if (apparelRand < 15) {
            attributes.apparel = "Aramid-Weave Jumpsuit";
        } else if (apparelRand < 35) {
            attributes.apparel = "Edgerunner Jacket";
        } else if (apparelRand < 60) {
            attributes.apparel = "Polyamide Rocker Vest";
        } else {
            attributes.apparel = "Tactical Flight Jacket";
        }

        // generate random expression
        uint256 expressionHash = uint256(
            keccak256(abi.encodePacked(seed, block.timestamp, "expression"))
        );
        uint8 expressionRand = uint8(expressionHash % 100);
        if (expressionRand < 33) {
            attributes.expression = "Happy";
        } else if (expressionRand < 66) {
            attributes.expression = "Stoic";
        } else {
            attributes.expression = "Fierce";
        }


        // generate random eyes
        uint256 eyesHash = uint256(
            keccak256(abi.encodePacked(seed, block.timestamp, "eyes"))
        );
        uint8 eyesRand = uint8(eyesHash % 100);
        if (eyesRand < 10) {
            attributes.eyes = "Green";
        } else if (eyesRand < 20) {
            attributes.eyes = "Blue";
        } else if (eyesRand < 40) {
            attributes.eyes = "Brown";
        } else if (eyesRand < 99) {
            attributes.eyes = "Amber";
        } else {
            attributes.eyes = "Piercing";
        }

        // generate random gender
        uint256 genderHash = uint256(
            keccak256(abi.encodePacked(seed, block.timestamp, "gender"))
        );
        uint8 genderRand = uint8(genderHash % 100);
        if (genderRand < 50) {
            attributes.gender = "Male";
        } else {
            attributes.gender = "Female";
        }

        // generate random hair
        uint256 hairHash = uint256(
            keccak256(abi.encodePacked(seed, block.timestamp, "hair"))
        );
        uint8 hairRand = uint8(hairHash % 100);
        if (hairRand < 10) {
            attributes.hair = "Bald";
        } else if (hairRand < 20) {
            attributes.hair = "Buzzcut";
        } else if (hairRand < 30) {
            attributes.hair = "Short";
        } else if (hairRand < 40) {
            attributes.hair = "Medium";
        } else if (hairRand < 50) {
            attributes.hair = "Long";
        } else if (hairRand < 60) {
            attributes.hair = "Braided";
        } else if (hairRand < 70) {
            attributes.hair = "Ponytail";
        } else if (hairRand < 80) {
            attributes.hair = "Dreadlocks";
        } else if (hairRand < 90) {
            attributes.hair = "Afro";
        } else {
            attributes.hair = "Bun";
        }

        // generate random helmet
        uint256 helmetHash = uint256(
            keccak256(abi.encodePacked(seed, block.timestamp, "helmet"))
        );
        uint8 helmetRand = uint8(helmetHash % 100);
        if (helmetRand < 25) {
            attributes.helmet = "None";
        } else if (helmetRand < 50) {
            attributes.helmet = "Motorcycle Helmet";
        } else if (helmetRand < 75) {
            attributes.helmet = "Combat Helmet";
        } else {
            attributes.helmet = "Biker Helmet";
        }

        // generate random mouth
        uint256 mouthHash = uint256(
            keccak256(abi.encodePacked(seed, block.timestamp, "mouth"))
        );
        uint8 mouthRand = uint8(mouthHash % 100);
        if (mouthRand < 10) {
            attributes.mouth = "Smile";
        } else if (mouthRand < 25) {
            attributes.mouth = "Knife";
        } else if (mouthRand < 50) {
            attributes.mouth = "Expressionless";
        } else if (mouthRand < 75) {
            attributes.mouth = "Mischief";
        } else {
            attributes.mouth = "Grimace";
        }

        // generate random nose
        uint256 noseHash = uint256(
            keccak256(abi.encodePacked(seed, block.timestamp, "nose"))
        );
        uint8 noseRand = uint8(noseHash % 100);
        if (noseRand < 10) {
            attributes.nose = "Pointed";
        } else if (noseRand < 20) {
            attributes.nose = "Hooked";
        } else if (noseRand < 40) {
            attributes.nose = "Broad";
        } else if (noseRand < 60) {
            attributes.nose = "Broken";
        } else if (noseRand < 80) {
            attributes.nose = "No nose";
        } else {
            attributes.nose = "Flared";
        }

        // generate random skin
        uint256 skinHash = uint256(
            keccak256(abi.encodePacked(seed, block.timestamp, "skin"))
        );
        uint8 skinRand = uint8(skinHash % 100);
        
        if (skinRand < 99.5) {
            attributes.skin = "Regular";
        } else {
            attributes.skin = "Gold";
        }

        // generate random class
        uint256 classHash = uint256(
            keccak256(abi.encodePacked(seed, block.timestamp, "class"))
        );
        uint8 classRand = uint8(classHash % 100);
        if (classRand < 3) {
            attributes.class = "Cyberware Surgeon";
        } else if (classRand < 9) {
            attributes.class = "Cyberware Dealer";
        } else if (classRand < 17) {
            attributes.class = "S-Tier Hacker";
        } else if (classRand < 27) {
            attributes.class = "OG-Bitcoiner";
        } else if (classRand < 40) {
            attributes.class = "Ultimate Soccer Parent";
        } else if (classRand < 55) {
            attributes.class = "High School Principal";
        } else if (classRand < 72) {
            attributes.class = "Esports SuperStar";
        } else if (classRand < 91) {
            attributes.class = "Crypto Developer";
        } else if (classRand < 99) {
            attributes.class = "Order Keeper";
        } else {
            attributes.class = "Cyber-Psycho";
        }

        // generate random weapon
        uint256 allocationHash = uint256(
            keccak256(abi.encodePacked(seed, block.timestamp, "allocation"))
        );
        uint8 allocationRand = uint8(allocationHash % 100);
        if (allocationRand < 2) {
            attributes.allocation = "Very high";
        } else if (allocationRand < 15) {
            attributes.allocation = "High";
        } else if (allocationRand < 45) {
            attributes.allocation = "Medium";
        } else if (allocationRand < 70) {
            attributes.allocation = "Low";
        } else {
            attributes.allocation = "Very low";
        }

        // generate random vehicle
        uint256 vehicleHash = uint256(
            keccak256(abi.encodePacked(seed, block.timestamp, "vehicle"))
        );
        uint8 vehicleRand = uint8(vehicleHash % 100);
        if (vehicleRand < 2) {
            attributes.vehicle = "Neo Flight capabilites";
        } else if (vehicleRand < 15) {
            attributes.vehicle = "Sports Car";
        } else if (vehicleRand < 45) {
            attributes.vehicle = "Mini Van";
        } else if (vehicleRand < 70) {
            attributes.vehicle = "Golf Cart";
        } else {
            attributes.vehicle = "Roller-skates";
        }

        // generate random location
        uint256 locationHash = uint256(
            keccak256(abi.encodePacked(seed, block.timestamp, "location"))
        );
        uint8 locationRand = uint8(locationHash % 100);
        if (locationRand < 2) {
            attributes.location = "Omniprescent";
        } else if (locationRand < 5) {
            attributes.location = "Cyberpunk City - WaterFront";
        } else if (locationRand < 9) {
            attributes.location = "Cyberpunk City - Towers";
        } else if (locationRand < 30) {
            attributes.location = "Cyberpunk City - Projects";
        } else if (locationRand < 50) {
            attributes.location = "Cyberpunk City - Slums";
        } else if (locationRand < 70) {
            attributes.location = "Cyberpunk City - Suburbs";
        } else if (locationRand < 90) {
            attributes.location = "Countryside";
        } else {
            attributes.location = "Outskirts";
        }

        // generate random pet
        uint256 petHash = uint256(
            keccak256(abi.encodePacked(seed, block.timestamp, "pet"))
        );
        uint8 petRand = uint8(petHash % 100);
        if (petRand < 2) {
            attributes.pet = "Cyberdog";
        } else if (petRand < 5) {
            attributes.pet = "Cybercat";
        } else if (petRand < 9) {
            attributes.pet = "Cyberbird";
        } else {
            attributes.pet = "None";
        }

        // generate random weapon
        uint256 weaponHash = uint256(
            keccak256(abi.encodePacked(seed, block.timestamp, "weapon"))
        );
        uint8 weaponRand = uint8(weaponHash % 100);
        if (weaponRand < 2) {
            attributes.weapon = "Invincible finger-guns";
        } else if (weaponRand < 5) {
            attributes.weapon = "Cybernetic Bruiser-Arm";
        } else if (weaponRand < 12) {
            attributes.weapon = "Golden Gun";
        } else if (weaponRand < 20) {
            attributes.weapon = "Green Lightsaber";
        } else if (weaponRand < 30) {
            attributes.weapon = "Red Lightsaber";
        } else if (weaponRand < 40) {
            attributes.weapon = "Cyber Katana";
        } else if (weaponRand < 50) {
            attributes.weapon = "Bloody Machete";
        } else if (weaponRand < 60) {
            attributes.weapon = "Pickle";
        } else if (weaponRand < 70) {
            attributes.weapon = "Tv Remote";
        } else if (weaponRand < 80) {
            attributes.weapon = "Keyboard";
        } else if (weaponRand < 90) {
            attributes.weapon = "Open hand";
        } else if (weaponRand < 95) {
            attributes.weapon = "Teenagers Sock";
        } else if (weaponRand < 99) {
            attributes.weapon = "Thor's Hammer";
        } else {
            attributes.weapon = "Squirt Gun";
        }

        // generate random vehicle
        uint256 raceHash = uint256(
            keccak256(abi.encodePacked(seed, block.timestamp, "race"))
        );
        uint8 raceRand = uint8(raceHash % 100);
        if (raceRand < 2) {
            attributes.race = "Aeon";
        } else if (raceRand < 10) {
            attributes.race = "Demon";
        } else if (raceRand < 25) {
            attributes.race = "Ape";
        } else if (raceRand < 50) {
            attributes.race = "Mutant";
        } else if (raceRand < 75) {
            attributes.race = "Android";
        } else {
            attributes.race = "Human";
        }

        // generate random ability
        uint256 abilityHash = uint256(
            keccak256(abi.encodePacked(seed, block.timestamp, "ability"))
        );
        uint8 abilityRand = uint8(abilityHash % 100);
        if (abilityRand < 5) {
            attributes.ability = "Superhuman Strength";
        } else if (abilityRand < 15) {
            attributes.ability = "Revive";
        } else if (abilityRand < 30) {
            attributes.ability = "Shield";
        }

        return attributes;
    }
}
