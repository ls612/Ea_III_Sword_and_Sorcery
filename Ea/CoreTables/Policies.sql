-- Contains PolicyBranchTypes and Policies

-- Requires Buildings.sql first
------------------------------------------------------------------------------------
-- Selectable Policies
------------------------------------------------------------------------------------
-- Holy cow this is badly coded!
-- policy branch  graphics are hard-coded in xml; order from id 0 to 9 are displayed as:
-- top row		0 1 2 3 4
-- bottom row	8 9 7 6 5

DELETE FROM PolicyBranchTypes;
INSERT INTO PolicyBranchTypes (Type, Description,						Help,											Title,								EraPrereq,			FreePolicy,				FreeFinishingPolicy) VALUES
('POLICY_BRANCH_DOMINIONISM',		'TXT_KEY_EA_POLICY_DOMINIONISM',	'TXT_KEY_EA_POLICY_BRANCH_DOMINIONISM_HELP',	'TXT_KEY_EA_DOMINIONISM_TITLE',		NULL,				'POLICY_DOMINIONISM',	'POLICY_DOMINIONISM_FINISHER'	),
('POLICY_BRANCH_PANTHEISM',			'TXT_KEY_EA_POLICY_PANTHEISM',		'TXT_KEY_EA_POLICY_BRANCH_PANTHEISM_HELP',		'TXT_KEY_EA_PANTHEISM_TITLE',		NULL,				'POLICY_PANTHEISM',		'POLICY_PANTHEISM_FINISHER'		),
('POLICY_BRANCH_THEISM',			'TXT_KEY_EA_POLICY_THEISM',			'TXT_KEY_EA_POLICY_BRANCH_THEISM_HELP',			'TXT_KEY_EA_THEISM_TITLE',			NULL,				'POLICY_THEISM',		'POLICY_THEISM_FINISHER'		),
('POLICY_BRANCH_ARCANA',			'TXT_KEY_EA_POLICY_ARCANA',			'TXT_KEY_EA_POLICY_BRANCH_ARCANA_HELP',			'TXT_KEY_EA_ARCANA_TITLE',			NULL,				'POLICY_ARCANA',		'POLICY_ARCANA_FINISHER'		),
('POLICY_BRANCH_SLAVERY',			'TXT_KEY_EA_POLICY_SLAVERY',		'TXT_KEY_EA_POLICY_BRANCH_SLAVERY_HELP',		'TXT_KEY_EA_SLAVERY_TITLE',			NULL,				'POLICY_SLAVERY',		'POLICY_SLAVERY_FINISHER'		),
('POLICY_BRANCH_CIV_ENABLED',		'TXT_KEY_EA_PLACEHOLDER',			'TXT_KEY_EA_POLICY_BRANCH_CIV_ENABLED_HELP',	'TXT_KEY_EA_PLACEHOLDER',			NULL,				'POLICY_CIV_ENABLED',	NULL							),

('POLICY_BRANCH_COMMERCE',			'TXT_KEY_EA_POLICY_COMMERCE',		'TXT_KEY_EA_POLICY_BRANCH_COMMERCE_HELP',		'TXT_KEY_EA_COMMERCE_TITLE',		NULL,				'POLICY_COMMERCE',		'POLICY_COMMERCE_FINISHER'		),
('POLICY_BRANCH_TRADITION',			'TXT_KEY_EA_POLICY_TRADITION',		'TXT_KEY_EA_POLICY_BRANCH_TRADITION_HELP',		'TXT_KEY_EA_TRADITION_TITLE',		NULL,				'POLICY_TRADITION',		'POLICY_TRADITION_FINISHER'		),
('POLICY_BRANCH_8',					'TXT_KEY_EA_PLACEHOLDER',			'TXT_KEY_EA_PLACEHOLDER',						'TXT_KEY_EA_PLACEHOLDER',			'ERA_CLASSICAL',	'POLICY_FAKE_OPENER',	NULL							),
('POLICY_BRANCH_MILITARISM',		'TXT_KEY_EA_POLICY_MILITARISM',		'TXT_KEY_EA_POLICY_BRANCH_MILITARISM_HELP',		'TXT_KEY_EA_MILITARISM_TITLE',		NULL,				'POLICY_MILITARISM',	'POLICY_MILITARISM_FINISHER'	),
('POLICY_BRANCH_ANTI_THEISM',		'TXT_KEY_EA_POLICY_THEISM',			'TXT_KEY_EA_POLICY_BRANCH_ANTI_THEISM_HELP',	'TXT_KEY_EA_THEISM_TITLE',			NULL,				'POLICY_ANTI_THEISM',	'POLICY_ANTI_THEISM_FINISHER'	);

DELETE FROM PolicyBranch_Disables;
INSERT INTO PolicyBranch_Disables (PolicyBranchType, PolicyBranchDisable) VALUES	--always in pairs!
('POLICY_BRANCH_DOMINIONISM',	'POLICY_BRANCH_PANTHEISM'	),
('POLICY_BRANCH_PANTHEISM',		'POLICY_BRANCH_DOMINIONISM'	),
('POLICY_BRANCH_PANTHEISM',		'POLICY_BRANCH_THEISM'		),
('POLICY_BRANCH_THEISM',		'POLICY_BRANCH_PANTHEISM'	),
('POLICY_BRANCH_PANTHEISM',		'POLICY_BRANCH_ANTI_THEISM'	),
('POLICY_BRANCH_ANTI_THEISM',	'POLICY_BRANCH_PANTHEISM'	),
('POLICY_BRANCH_THEISM',		'POLICY_BRANCH_ARCANA'	),
('POLICY_BRANCH_ARCANA',		'POLICY_BRANCH_THEISM'	);
--('POLICY_BRANCH_THEISM',		'POLICY_BRANCH_ANTI_THEISM'	),
--('POLICY_BRANCH_ANTI_THEISM',	'POLICY_BRANCH_THEISM'	);

DELETE FROM Policies;
ALTER TABLE Policies ADD COLUMN 'Utility' BOOLEAN DEFAULT NULL;
ALTER TABLE Policies ADD COLUMN 'EaCivTrait' TEXT DEFAULT NULL;			
ALTER TABLE Policies ADD COLUMN 'EaFirstInBranchGPClass' TEXT DEFAULT NULL;
ALTER TABLE Policies ADD COLUMN 'EaFirstInBranchGPSubclass' TEXT DEFAULT NULL;

--Dominionism
INSERT INTO Policies (Type,			GridX,	GridY,	PolicyBranchType,				PortraitIndex,	IconAtlas,		IconAtlasAchieved) VALUES
('POLICY_DOMINIONISM',				0,		0,		NULL,							24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_ARISTOCRACY',				5,		1,		'POLICY_BRANCH_DOMINIONISM',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_FEUDALISM',				5,		2,		'POLICY_BRANCH_DOMINIONISM',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_GUILDS',					1,		1,		'POLICY_BRANCH_DOMINIONISM',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_TRADE_UNIONS',				1,		2,		'POLICY_BRANCH_DOMINIONISM',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_CIVIL_SERVICE',			3,		1,		'POLICY_BRANCH_DOMINIONISM',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_TAXATION',					3,		2,		'POLICY_BRANCH_DOMINIONISM',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_INDUSTRIALIZATION',		3,		3,		'POLICY_BRANCH_DOMINIONISM',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_DOMINIONISM_FINISHER',		0,		0,		NULL,							0,				NULL,			NULL );

--Pantheism
INSERT INTO Policies (Type,			GridX,	GridY,	PolicyBranchType,				PortraitIndex,	IconAtlas,		IconAtlasAchieved) VALUES
('POLICY_PANTHEISM',				0,		0,		NULL,							24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_ANIMAL_LORE',				1,		1,		'POLICY_BRANCH_PANTHEISM',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_FERAL_BOND',				1,		2,		'POLICY_BRANCH_PANTHEISM',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_COMMUNE_WITH_NATURE',		1,		3,		'POLICY_BRANCH_PANTHEISM',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_WOODS_LORE',				3,		1,		'POLICY_BRANCH_PANTHEISM',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_FELLOWSHIP_OF_LEAVES',		3,		2,		'POLICY_BRANCH_PANTHEISM',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_FOREST_DOMINION',			3,		3,		'POLICY_BRANCH_PANTHEISM',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_EARTH_LORE',				5,		1,		'POLICY_BRANCH_PANTHEISM',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_MANA_VORTEXES',			5,		2,		'POLICY_BRANCH_PANTHEISM',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_THROUGH_THE_VEIL',			5,		3,		'POLICY_BRANCH_PANTHEISM',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_PANTHEISM_FINISHER',		0,		0,		NULL,							0,				NULL,			NULL	);

--Theism
INSERT INTO Policies (Type,			GridX,	GridY,	PolicyBranchType,				PortraitIndex,	IconAtlas,		IconAtlasAchieved) VALUES
('POLICY_THEISM',					0,		0,		NULL,							24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_PRIESTHOOD',				1,		1,		'POLICY_BRANCH_THEISM',			24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_HOLY_ORDER',				1,		2,		'POLICY_BRANCH_THEISM',			24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_THEOCRACY',				1,		3,		'POLICY_BRANCH_THEISM',			24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_WAY_OF_THE_WISE',			3,		1,		'POLICY_BRANCH_THEISM',			24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_HEAVENS_MANDATE',			3,		2,		'POLICY_BRANCH_THEISM',			24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_MYSTICISM',				5,		1,		'POLICY_BRANCH_THEISM',			24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_MONASTIC_TRADITION',		5,		2,		'POLICY_BRANCH_THEISM',			24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_THEISM_FINISHER',			0,		0,		NULL,							0,				NULL,			NULL	);

--Anti-Theism (order here must mirror Theism exactly for proper swap in Lua code)
INSERT INTO Policies (Type,			GridX,	GridY,	PolicyBranchType,				PortraitIndex,	IconAtlas,		IconAtlasAchieved) VALUES
('POLICY_ANTI_THEISM',				0,		0,		NULL,							24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_ANTI_PRIESTHOOD',			1,		1,		'POLICY_BRANCH_ANTI_THEISM',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_ANTI_HOLY_ORDER',			1,		2,		'POLICY_BRANCH_ANTI_THEISM',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_ANTI_THEOCRACY',			1,		3,		'POLICY_BRANCH_ANTI_THEISM',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_ANTI_WAY_OF_THE_WISE',		3,		1,		'POLICY_BRANCH_ANTI_THEISM',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_ANTI_HEAVENS_MANDATE',		3,		2,		'POLICY_BRANCH_ANTI_THEISM',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_ANTI_MYSTICISM',			5,		1,		'POLICY_BRANCH_ANTI_THEISM',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_ANTI_MONASTIC_TRADITION',	5,		2,		'POLICY_BRANCH_ANTI_THEISM',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_ANTI_THEISM_FINISHER',		0,		0,		NULL,							0,				NULL,			NULL	);

--Arcana
INSERT INTO Policies (Type,			GridX,	GridY,	PolicyBranchType,				PortraitIndex,	IconAtlas,		IconAtlasAchieved) VALUES
('POLICY_ARCANA',					0,		0,		NULL,							24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_WITCHCRAFT',				1,		1,		'POLICY_BRANCH_ARCANA',			24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_ARCANE_TRADITION',			3,		1,		'POLICY_BRANCH_ARCANA',			24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_ARCANE_LORE',				3,		2,		'POLICY_BRANCH_ARCANA',			24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_MAGERY',					3,		3,		'POLICY_BRANCH_ARCANA',			24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_SOCIO_ARCANA',				5,		1,		'POLICY_BRANCH_ARCANA',			24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_THAUMATOCRACY',			5,		2,		'POLICY_BRANCH_ARCANA',			24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_ARCANA_PRIMUS',			5,		3,		'POLICY_BRANCH_ARCANA',			24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_ARCANA_FINISHER',			0,		0,		NULL,							0,				NULL,			NULL );

--Slavery
INSERT INTO Policies (Type,			GridX,	GridY,	PolicyBranchType,				PortraitIndex,	IconAtlas,		IconAtlasAchieved) VALUES
('POLICY_SLAVERY',					0,		0,		NULL,							24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_DEBT_BONDAGE',				1,		1,		'POLICY_BRANCH_SLAVERY',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_SERVI_AETERNAM',			1,		3,		'POLICY_BRANCH_SLAVERY',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_SLAVE_TRADE',				3,		1,		'POLICY_BRANCH_SLAVERY',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_SLAVE_CASTES',				3,		2,		'POLICY_BRANCH_SLAVERY',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_SLAVE_BREEDING',			3,		3,		'POLICY_BRANCH_SLAVERY',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_SLAVE_RAIDERS',			5,		1,		'POLICY_BRANCH_SLAVERY',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_SLAVE_ARMIES',				5,		2,		'POLICY_BRANCH_SLAVERY',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_SLAVERY_FINISHER',			0,		0,		NULL,							0,				NULL,			NULL );

--Militarism
INSERT INTO Policies (Type,			GridX,	GridY,	PolicyBranchType,				PortraitIndex,	IconAtlas,		IconAtlasAchieved) VALUES
('POLICY_MILITARISM',				0,		0,		NULL,							24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_DISCIPLINE',				3,		1,		'POLICY_BRANCH_MILITARISM',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_MILITARY_TRADITION',		3,		2,		'POLICY_BRANCH_MILITARISM',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_PROFESSIONAL_ARMY',		3,		3,		'POLICY_BRANCH_MILITARISM',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_WARCRAFT',					1,		1,		'POLICY_BRANCH_MILITARISM',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_WARRIOR_CODE',				1,		3,		'POLICY_BRANCH_MILITARISM',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_WARSPIRIT',				5,		1,		'POLICY_BRANCH_MILITARISM',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_BERSERKER_RAGE',			5,		2,		'POLICY_BRANCH_MILITARISM',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_MILITARISM_FINISHER',		0,		0,		NULL,							0,				NULL,			NULL );

--Tradition
INSERT INTO Policies (Type,			GridX,	GridY,	PolicyBranchType,				PortraitIndex,	IconAtlas,		IconAtlasAchieved) VALUES
('POLICY_TRADITION',				0,		0,		NULL,							24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_FOLKLORE',					1,		1,		'POLICY_BRANCH_TRADITION',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_BARDING',					1,		2,		'POLICY_BRANCH_TRADITION',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_FOLKART',					3,		1,		'POLICY_BRANCH_TRADITION',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_CRAFTING',					3,		2,		'POLICY_BRANCH_TRADITION',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_THE_ARTS',					3,		3,		'POLICY_BRANCH_TRADITION',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_SCHOLASTICISM',			5,		1,		'POLICY_BRANCH_TRADITION',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_ACADEMIC_TRADITION',		5,		2,		'POLICY_BRANCH_TRADITION',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_RATIONALISM',				5,		3,		'POLICY_BRANCH_TRADITION',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_TRADITION_FINISHER',		0,		0,		NULL,							0,				NULL,			NULL );

--Commerce
INSERT INTO Policies (Type,			GridX,	GridY,	PolicyBranchType,				PortraitIndex,	IconAtlas,		IconAtlasAchieved) VALUES
('POLICY_COMMERCE',					0,		0,		NULL,							24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_MERCANTILISM',				3,		1,		'POLICY_BRANCH_COMMERCE',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_FREE_MARKETS',				3,		2,		'POLICY_BRANCH_COMMERCE',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_FREE_TRADE',				3,		3,		'POLICY_BRANCH_COMMERCE',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_MERCENARIES',				5,		1,		'POLICY_BRANCH_COMMERCE',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_MERCHANT_NAVY',			5,		2,		'POLICY_BRANCH_COMMERCE',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_CULTURAL_DIPLOMACY',		1,		1,		'POLICY_BRANCH_COMMERCE',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_PATRONAGE',				1,		2,		'POLICY_BRANCH_COMMERCE',		24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_COMMERCE_FINISHER',		0,		0,		NULL,							0,				NULL,			NULL );

--Civ-Enabled
INSERT INTO Policies (Type,			PolicyBranchType,				PortraitIndex,	IconAtlas,		IconAtlasAchieved) VALUES
('POLICY_CIV_ENABLED',				NULL,							24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_PASTORALISTS',				'POLICY_BRANCH_CIV_ENABLED',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_MYSTICS',					'POLICY_BRANCH_CIV_ENABLED',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_HERBALISTS',				'POLICY_BRANCH_CIV_ENABLED',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_CONJURORS',				'POLICY_BRANCH_CIV_ENABLED',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_ENCHANTERS',				'POLICY_BRANCH_CIV_ENABLED',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_DIVINATORS',				'POLICY_BRANCH_CIV_ENABLED',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_ALCHEMISTS',				'POLICY_BRANCH_CIV_ENABLED',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),
('POLICY_POTION_MAKERS',			'POLICY_BRANCH_CIV_ENABLED',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' ),

('POLICY_ANIMAL_MASTERS',			'POLICY_BRANCH_CIV_ENABLED',	24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' );

--Note that GridX, GridY are not used for Civ-Enabled, except that GridY is used to determine spell level for policy enabled spells (so set it if there are any)



INSERT INTO Policies (Type,				Utility,	GridX,	GridY,	PolicyBranchType,		PortraitIndex,	IconAtlas,		IconAtlasAchieved) VALUES
('POLICY_FAKE_OPENER',			1,			0,		0,		NULL,					24,				'POLICY_ATLAS',	'POLICY_A_ATLAS' );


--Build out the table for dependent strings
UPDATE Policies SET Description = 'TXT_KEY_EA_' || Type;
UPDATE Policies SET Civilopedia = Description || '_PEDIA', Help = Description || '_HELP';

--GPs (assign class or subclass, not both!)
UPDATE Policies SET EaFirstInBranchGPSubclass = 'Druid' WHERE Type IN ('POLICY_ANIMAL_LORE', 'POLICY_WOODS_LORE', 'POLICY_EARTH_LORE');
UPDATE Policies SET EaFirstInBranchGPSubclass = 'Priest' WHERE Type IN ('POLICY_PRIESTHOOD', 'POLICY_WAY_OF_THE_WISE', 'POLICY_MYSTICISM');
UPDATE Policies SET EaFirstInBranchGPSubclass = 'FallenPriest' WHERE Type IN ('POLICY_ANTI_PRIESTHOOD', 'POLICY_ANTI_WAY_OF_THE_WISE', 'POLICY_ANTI_MYSTICISM');
UPDATE Policies SET EaFirstInBranchGPSubclass = 'Wizard' WHERE Type IN ('POLICY_ARCANE_TRADITION', 'POLICY_SOCIO_ARCANA');
UPDATE Policies SET EaFirstInBranchGPSubclass = 'Witch' WHERE Type = 'POLICY_WITCHCRAFT';
UPDATE Policies SET EaFirstInBranchGPClass = 'Warrior' WHERE Type IN ('POLICY_DISCIPLINE', 'POLICY_WARCRAFT');
UPDATE Policies SET EaFirstInBranchGPSubclass = 'Berserker' WHERE Type = 'POLICY_WARSPIRIT';
UPDATE Policies SET EaFirstInBranchGPClass = 'Artist' WHERE Type IN ('POLICY_FOLKLORE', 'POLICY_FOLKART');
UPDATE Policies SET EaFirstInBranchGPClass = 'Sage' WHERE Type = 'POLICY_SCHOLASTICISM';
UPDATE Policies SET EaFirstInBranchGPClass = 'Merchant' WHERE Type IN ('POLICY_MERCANTILISM', 'POLICY_MERCENARIES', 'POLICY_CULTURAL_DIPLOMACY');


UPDATE Policies SET CultureCost = 10 WHERE PolicyBranchType != NULL;		--don't think this does anything at all

UPDATE Policies SET UnhappinessMod = -33 WHERE Type = 'POLICY_FEUDALISM';
UPDATE Policies SET HalfSpecialistFood = 1 WHERE Type = 'POLICY_TRADE_UNIONS';
UPDATE Policies SET HalfSpecialistUnhappiness = 1 WHERE Type = 'POLICY_GUILDS';

--NumExtraBuilders?

--WoundedUnitDamageMod		--Negative value in base !!!???
--UnitSupplyMod
--CulturalPlunderMultiplier ???	--Receive 10 Culture as plunder for each point of Culture produced in the captured city.

--UnitGoldMaintenanceMod = -33

--BaseFreeMilitaryUnits
--FreeMilitaryUnitsPopulationPercent	--DOES NOT WORK

UPDATE Policies SET BaseFreeUnits = 4 WHERE Type = 'POLICY_MILITARISM';
UPDATE Policies SET UnitGoldMaintenanceMod = -10 WHERE Type = 'POLICY_DISCIPLINE';
UPDATE Policies SET UnitGoldMaintenanceMod = -10, GarrisonFreeMaintenance = 1, HappinessPerGarrisonedUnit = 1 WHERE Type = 'POLICY_MILITARY_TRADITION';
UPDATE Policies SET UnitGoldMaintenanceMod = -10, UnitUpgradeCostMod = -50 WHERE Type = 'POLICY_PROFESSIONAL_ARMY';
UPDATE Policies SET UnitGoldMaintenanceMod = -10, CultureFromKills = 100 WHERE Type = 'POLICY_WARRIOR_CODE';
UPDATE Policies SET UnitGoldMaintenanceMod = -10, ExpModifier = 100 WHERE Type = 'POLICY_WARCRAFT';
UPDATE Policies SET UnitGoldMaintenanceMod = -10 WHERE Type = 'POLICY_WARSPIRIT';
UPDATE Policies SET UnitGoldMaintenanceMod = -10 WHERE Type = 'POLICY_BERSERKER_RAGE';


UPDATE Policies SET CultureWonderMultiplier = 20 WHERE Type = 'POLICY_THE_ARTS';
--UPDATE Policies SET TradeRouteGoldModifier = 20 WHERE Type = 'POLICY_FREE_MARKETS';	--not used in base; works?
UPDATE Policies SET MinorGoldFriendshipMod = 25 WHERE Type = 'POLICY_CULTURAL_DIPLOMACY';
UPDATE Policies SET MinorFriendshipDecayMod = -50 WHERE Type = 'POLICY_PATRONAGE';


--SettlerProductionModifier
--RouteGoldMaintenanceMod

--MinorFriendshipDecayMod

-- EaCivs
INSERT INTO Policies (Type,	Utility) VALUES
('POLICY_EACIV_PARAKHORA',				1	),
('POLICY_EACIV_LEMURIA',				1	),
('POLICY_EACIV_AXAGORIA',				1	),
('POLICY_EACIV_IACCHIA',				1	),
('POLICY_EACIV_SOPHRONIA',				1	),
('POLICY_EACIV_LUCHTAIN',				1	),
('POLICY_EACIV_NETZACH',				1	),
('POLICY_EACIV_HOD',					1	),
('POLICY_EACIV_SEGOYIM',				1	),
('POLICY_EACIV_YS',						1	),

('POLICY_CAPITAL_5_FAITH',				1	),
('POLICY_GRANERY_15PERC_FOOD',			1	),		--works???
('POLICY_GOLD_FROM_KILLS',				1	),
('POLICY_1C_VARIOUS_BUILDINGS',			1	);



UPDATE Policies SET BuildingProductionModifier = 20 WHERE Type IN ('POLICY_EACIV_SOPHRONIA', 'POLICY_EACIV_LUCHTAIN');
UPDATE Policies SET HappinessToScience = 50 WHERE Type = 'POLICY_EACIV_AXAGORIA';		--works?
UPDATE Policies SET HappinessToCulture = 50 WHERE Type = 'POLICY_EACIV_IACCHIA';
UPDATE Policies SET GoldFromKills = 100 WHERE Type = 'POLICY_GOLD_FROM_KILLS';



-- Misc Utility Effects



INSERT INTO Policies (Type,	Utility) VALUES
('POLICY_ALL_FULL_CIVS',		1	),	--exists for all major civs but doesn't do anything yet
('POLICY_EQUUS_TOME_XP_0064',	1	),
('POLICY_EQUUS_TOME_XP_0032',	1	),
('POLICY_EQUUS_TOME_XP_0016',	1	),
('POLICY_EQUUS_TOME_XP_0008',	1	),
('POLICY_EQUUS_TOME_XP_0004',	1	),
('POLICY_EQUUS_TOME_XP_0002',	1	),
('POLICY_EQUUS_TOME_XP_0001',	1	),

('POLICY_LEVIATHAN_TOME',		1	);

-- housekeeping stuff for utility and EaTrates
UPDATE Policies SET Description='TXT_KEY_EA_PLACEHOLDER' WHERE Utility = 1;

------------------------------------------------------------------------------------
-- Policy Subtables
------------------------------------------------------------------------------------
--unused
DELETE FROM Policy_CoastalCityYieldChanges;
DELETE FROM Policy_Disables;
DELETE FROM Policy_Flavors;
DELETE FROM Policy_PrereqORPolicies;
DELETE FROM Policy_ValidSpecialists;
DELETE FROM Policy_UnitCombatProductionModifiers;
DELETE FROM Policy_FreeUnitClasses;
DELETE FROM Policy_FreeItems;
DELETE FROM Policy_FreePromotionUnitCombats;	--Does not work! Use Policy_FreePromotions together with UnitPromotions_UnitCombats

DELETE FROM Policy_GreatWorkYieldChanges;
DELETE FROM Policy_TourismOnUnitCreation;
DELETE FROM Policy_BuildingClassTourismModifiers;


DELETE FROM Policy_BuildingClassProductionModifiers;
INSERT INTO Policy_BuildingClassProductionModifiers (PolicyType, BuildingClassType, ProductionModifier)
SELECT 'POLICY_ARCANE_TRADITION', BuildingClass, 33 FROM Buildings WHERE EaSpecial = 'Arcane';



DELETE FROM Policy_CapitalYieldChanges;
INSERT INTO Policy_CapitalYieldChanges(PolicyType, YieldType, Yield) VALUES
('POLICY_PANTHEISM',				'YIELD_FAITH',		1	),
('POLICY_THEISM',					'YIELD_FAITH',		1	),
('POLICY_MYSTICISM',				'YIELD_FAITH',		3	),
('POLICY_HEAVENS_MANDATE',			'YIELD_FAITH',		3	),
('POLICY_ANTI_THEISM',				'YIELD_FAITH',		1	),
('POLICY_ANTI_MYSTICISM',			'YIELD_FAITH',		3	),
('POLICY_ANTI_HEAVENS_MANDATE',		'YIELD_FAITH',		5	),
('POLICY_ARCANA',					'YIELD_FAITH',		2	),
('POLICY_TRADITION',				'YIELD_SCIENCE',	1	),
('POLICY_TRADITION',				'YIELD_CULTURE',	1	),	--works?
('POLICY_COMMERCE',					'YIELD_GOLD',		3	),
('POLICY_EACIV_LEMURIA',			'YIELD_SCIENCE',	3	),
('POLICY_EACIV_LEMURIA',			'YIELD_FAITH',		3	),
('POLICY_EACIV_SEGOYIM',			'YIELD_SCIENCE',	2	),
('POLICY_EACIV_SEGOYIM',			'YIELD_CULTURE',	2	),	--works?
('POLICY_EACIV_SEGOYIM',			'YIELD_FAITH',		2	),
('POLICY_CAPITAL_5_FAITH',			'YIELD_FAITH',		5	);


DELETE FROM Policy_CapitalYieldModifiers;
INSERT INTO Policy_CapitalYieldModifiers(PolicyType, YieldType, Yield) VALUES
('POLICY_THEOCRACY',				'YIELD_GOLD',		20	),
('POLICY_ANTI_THEOCRACY',			'YIELD_SCIENCE',	20	);

DELETE FROM Policy_CityYieldChanges;
INSERT INTO Policy_CityYieldChanges (PolicyType,	YieldType,	Yield) VALUES
('POLICY_SLAVE_CASTES',				'YIELD_PRODUCTION',	1	);

DELETE FROM Policy_CapitalYieldPerPopChanges;
INSERT INTO Policy_CapitalYieldPerPopChanges (PolicyType, YieldType, Yield) VALUES
('POLICY_ARISTOCRACY',				'YIELD_GOLD',		100	),
('POLICY_CIVIL_SERVICE',			'YIELD_PRODUCTION',	50	),
('POLICY_SOCIO_ARCANA',				'YIELD_FAITH',		100	),
('POLICY_EACIV_YS',					'YIELD_SCIENCE',	150	);

DELETE FROM Policy_HurryModifiers;
INSERT INTO Policy_HurryModifiers (PolicyType, HurryType, HurryCostModifier) VALUES
('POLICY_MERCANTILISM', 'HURRY_GOLD', -25 );

DELETE FROM Policy_PrereqPolicies;
INSERT INTO Policy_PrereqPolicies (PolicyType,	PrereqPolicy) VALUES	--Don't list openers
('POLICY_FEUDALISM', 'POLICY_ARISTOCRACY' ),
('POLICY_TRADE_UNIONS', 'POLICY_GUILDS' ),
('POLICY_TAXATION', 'POLICY_CIVIL_SERVICE' ),
('POLICY_INDUSTRIALIZATION', 'POLICY_TRADE_UNIONS' ),
('POLICY_INDUSTRIALIZATION', 'POLICY_TAXATION' ),
('POLICY_FERAL_BOND', 'POLICY_ANIMAL_LORE' ),
('POLICY_COMMUNE_WITH_NATURE', 'POLICY_FERAL_BOND' ),
('POLICY_COMMUNE_WITH_NATURE', 'POLICY_FELLOWSHIP_OF_LEAVES' ),
('POLICY_FELLOWSHIP_OF_LEAVES', 'POLICY_WOODS_LORE' ),
('POLICY_FOREST_DOMINION', 'POLICY_FELLOWSHIP_OF_LEAVES' ),
('POLICY_MANA_VORTEXES', 'POLICY_EARTH_LORE' ),
('POLICY_THROUGH_THE_VEIL', 'POLICY_FELLOWSHIP_OF_LEAVES' ),
('POLICY_THROUGH_THE_VEIL', 'POLICY_MANA_VORTEXES' ),

('POLICY_MONASTIC_TRADITION', 'POLICY_MYSTICISM' ),
('POLICY_HEAVENS_MANDATE', 'POLICY_WAY_OF_THE_WISE' ),
('POLICY_HOLY_ORDER', 'POLICY_PRIESTHOOD' ),
('POLICY_THEOCRACY', 'POLICY_HEAVENS_MANDATE' ),
('POLICY_THEOCRACY', 'POLICY_HOLY_ORDER' ),

('POLICY_ANTI_MONASTIC_TRADITION', 'POLICY_ANTI_MYSTICISM' ),
('POLICY_ANTI_HEAVENS_MANDATE', 'POLICY_ANTI_WAY_OF_THE_WISE' ),
('POLICY_ANTI_HOLY_ORDER', 'POLICY_ANTI_PRIESTHOOD' ),
('POLICY_ANTI_THEOCRACY', 'POLICY_ANTI_HEAVENS_MANDATE' ),
('POLICY_ANTI_THEOCRACY', 'POLICY_ANTI_HOLY_ORDER' ),

('POLICY_ARCANE_LORE', 'POLICY_WITCHCRAFT' ),
('POLICY_ARCANE_LORE', 'POLICY_ARCANE_TRADITION' ),
('POLICY_MAGERY', 'POLICY_ARCANE_LORE' ),
('POLICY_THAUMATOCRACY', 'POLICY_SOCIO_ARCANA' ),
('POLICY_ARCANA_PRIMUS', 'POLICY_THAUMATOCRACY' ),

('POLICY_SLAVE_CASTES', 'POLICY_SLAVE_TRADE' ),
('POLICY_SLAVE_CASTES', 'POLICY_DEBT_BONDAGE' ),
('POLICY_SERVI_AETERNAM', 'POLICY_SLAVE_CASTES' ),
('POLICY_SLAVE_BREEDING', 'POLICY_SLAVE_CASTES' ),
('POLICY_SLAVE_ARMIES', 'POLICY_SLAVE_RAIDERS' ),

('POLICY_MILITARY_TRADITION', 'POLICY_DISCIPLINE' ),
('POLICY_MILITARY_TRADITION', 'POLICY_WARCRAFT' ),
('POLICY_WARRIOR_CODE', 'POLICY_MILITARY_TRADITION' ),
('POLICY_PROFESSIONAL_ARMY', 'POLICY_MILITARY_TRADITION' ),
('POLICY_BERSERKER_RAGE', 'POLICY_WARSPIRIT' ),

('POLICY_BARDING', 'POLICY_FOLKLORE' ),
('POLICY_CRAFTING', 'POLICY_FOLKART' ),
('POLICY_THE_ARTS', 'POLICY_BARDING' ),
('POLICY_THE_ARTS', 'POLICY_CRAFTING' ),
('POLICY_THE_ARTS', 'POLICY_ACADEMIC_TRADITION' ),
('POLICY_ACADEMIC_TRADITION', 'POLICY_SCHOLASTICISM' ),
('POLICY_RATIONALISM', 'POLICY_ACADEMIC_TRADITION' ),

('POLICY_FREE_MARKETS', 'POLICY_MERCANTILISM' ),
('POLICY_FREE_TRADE', 'POLICY_FREE_MARKETS' ),
('POLICY_MERCHANT_NAVY', 'POLICY_MERCANTILISM' ),
('POLICY_PATRONAGE', 'POLICY_CULTURAL_DIPLOMACY' ),

('POLICY_DIVINATORS', 'POLICY_MYSTICS' ),
('POLICY_POTION_MAKERS', 'POLICY_HERBALISTS' ),
('POLICY_POTION_MAKERS', 'POLICY_ALCHEMISTS' );

DELETE FROM Policy_SpecialistExtraYields;
INSERT INTO Policy_SpecialistExtraYields (PolicyType,	YieldType,	Yield) VALUES
('POLICY_TRADE_UNIONS',			'YIELD_GOLD',			1	),
('POLICY_GUILDS',				'YIELD_PRODUCTION',		1	);

DELETE FROM Policy_BuildingClassYieldModifiers;
INSERT INTO Policy_BuildingClassYieldModifiers(PolicyType, BuildingClassType, YieldType, YieldMod) VALUES
('POLICY_INDUSTRIALIZATION',	'BUILDINGCLASS_FACTORY',			'YIELD_PRODUCTION',	15	),
('POLICY_SCHOLASTICISM',		'BUILDINGCLASS_LIBRARY',			'YIELD_SCIENCE',	5	),
('POLICY_SCHOLASTICISM',		'BUILDINGCLASS_SCRIBES_GUILD',		'YIELD_SCIENCE',	1	),
('POLICY_SCHOLASTICISM',		'BUILDINGCLASS_MONASTIC_SCHOOL',	'YIELD_SCIENCE',	3	),
('POLICY_SCHOLASTICISM',		'BUILDINGCLASS_APOTHECARY',			'YIELD_SCIENCE',	3	),
('POLICY_ACADEMIC_TRADITION',	'BUILDINGCLASS_PAPERMILL',			'YIELD_SCIENCE',	5	),
('POLICY_ACADEMIC_TRADITION',	'BUILDINGCLASS_UNIVERSITY',			'YIELD_SCIENCE',	15	),
('POLICY_RATIONALISM',			'BUILDINGCLASS_PRINTING_PRESS',		'YIELD_SCIENCE',	5	),
('POLICY_RATIONALISM',			'BUILDINGCLASS_OBSERVATORY',		'YIELD_SCIENCE',	5	),
('POLICY_RATIONALISM',			'BUILDINGCLASS_LABORATORY',			'YIELD_SCIENCE',	15	),
('POLICY_THE_ARTS',				'BUILDINGCLASS_MUSEUM',				'YIELD_SCIENCE',	3	),
('POLICY_MERCANTILISM',			'BUILDINGCLASS_BANK',				'YIELD_GOLD',		15	),
('POLICY_GRANERY_15PERC_FOOD',	'BUILDINGCLASS_GRANARY',			'YIELD_FOOD',		15	);



INSERT INTO Policy_BuildingClassYieldModifiers(PolicyType, BuildingClassType, YieldType, YieldMod)
SELECT 'POLICY_SOCIO_ARCANA', BuildingClass, 'YIELD_FAITH', 1 FROM Buildings WHERE EaSpecial = 'Arcane';

DELETE FROM Policy_BuildingClassYieldChanges;
INSERT INTO Policy_BuildingClassYieldChanges (PolicyType, BuildingClassType, YieldType, YieldChange) VALUES
('POLICY_ANTI_MONASTIC_TRADITION',	'BUILDINGCLASS_MONASTERY',			'YIELD_SCIENCE',	2 ),
('POLICY_MERCHANT_NAVY',			'BUILDINGCLASS_HARBOR',				'YIELD_GOLD',		1 ),
('POLICY_MERCHANT_NAVY',			'BUILDINGCLASS_PORT',				'YIELD_GOLD',		1 ),
('POLICY_MERCHANT_NAVY',			'BUILDINGCLASS_WHALERY',			'YIELD_GOLD',		1 ),
('POLICY_MERCHANT_NAVY',			'BUILDINGCLASS_LIGHTHOUSE',			'YIELD_GOLD',		1 ),
('POLICY_MERCHANT_NAVY',			'BUILDINGCLASS_SHIPYARD',			'YIELD_GOLD',		1 ),
('POLICY_EACIV_PARAKHORA',			'BUILDINGCLASS_WATERMILL',			'YIELD_FOOD',		1	),
('POLICY_EACIV_PARAKHORA',			'BUILDINGCLASS_WATERMILL',			'YIELD_PRODUCTION',	1	),
('POLICY_EACIV_PARAKHORA',			'BUILDINGCLASS_WINDMILL',			'YIELD_FOOD',		1	),
('POLICY_EACIV_PARAKHORA',			'BUILDINGCLASS_WINDMILL',			'YIELD_PRODUCTION',	1	);

INSERT INTO Policy_BuildingClassYieldChanges (PolicyType, BuildingClassType, YieldType, YieldChange)
SELECT 'POLICY_EACIV_HOD', BuildingClass, 'YIELD_SCIENCE', 1 FROM Buildings WHERE EaSpecial = 'Religious' UNION ALL
SELECT 'POLICY_EACIV_NETZACH', BuildingClass, 'YIELD_FAITH', 2 FROM Buildings WHERE EaSpecial = 'Religious';


DELETE FROM Policy_BuildingClassCultureChanges;
INSERT INTO Policy_BuildingClassCultureChanges (PolicyType, BuildingClassType, CultureChange) VALUES

('POLICY_MONASTIC_TRADITION',		'BUILDINGCLASS_MONASTERY',		2 ),
('POLICY_FOLKART',					'BUILDINGCLASS_FAIR',			1	),
('POLICY_FOLKART',					'BUILDINGCLASS_IVORYWORKS',		1	),
('POLICY_FOLKART',					'BUILDINGCLASS_JEWELLER',		1	),
('POLICY_CRAFTING',					'BUILDINGCLASS_WINERY',			1	),
('POLICY_CRAFTING',					'BUILDINGCLASS_BREWERY',		1	),
('POLICY_CRAFTING',					'BUILDINGCLASS_STONE_WORKS',	1	),
('POLICY_CRAFTING',					'BUILDINGCLASS_TEXTILE_MILL',	1	),
('POLICY_THE_ARTS',					'BUILDINGCLASS_THEATRE',		2	),
('POLICY_THE_ARTS',					'BUILDINGCLASS_OPERA_HOUSE',	2	),
('POLICY_1C_VARIOUS_BUILDINGS',		'BUILDINGCLASS_PALACE',			1	),
('POLICY_1C_VARIOUS_BUILDINGS',		'BUILDINGCLASS_AMPHITHEATER',	1	),
('POLICY_1C_VARIOUS_BUILDINGS',		'BUILDINGCLASS_FAIR',			1	),
('POLICY_1C_VARIOUS_BUILDINGS',		'BUILDINGCLASS_WALLS',			1	),
('POLICY_1C_VARIOUS_BUILDINGS',		'BUILDINGCLASS_CASTLE',			1	);

INSERT INTO Policy_BuildingClassCultureChanges (PolicyType, BuildingClassType, CultureChange)
SELECT 'POLICY_EACIV_HOD', BuildingClass, 1 FROM Buildings WHERE EaSpecial = 'Religious';


DELETE FROM Policy_BuildingClassHappiness;												--Can add unhappiness
INSERT INTO Policy_BuildingClassHappiness (PolicyType, BuildingClassType, Happiness) VALUES
('POLICY_ALL_FULL_CIVS',			'BUILDINGCLASS_PLUS_1_UNHAPPINESS',	-1	);

--INSERT INTO Policy_BuildingClassHappiness (PolicyType, BuildingClassType, Happiness)
--SELECT 'POLICY_EACIV_NETZACH', BuildingClass, 1 FROM Buildings WHERE EaSpecial = 'Religious';



--TO DO: fix pan yields below and add negative yields for non-resource yields

DELETE FROM Policy_ImprovementYieldChanges;
INSERT INTO Policy_ImprovementYieldChanges (PolicyType,	ImprovementType,	YieldType,	Yield) VALUES
--Dominionism
('POLICY_DOMINIONISM',				'IMPROVEMENT_FARM',				'YIELD_FOOD',		1	),
('POLICY_DOMINIONISM',				'IMPROVEMENT_POLDER',			'YIELD_FOOD',		1	),
('POLICY_DOMINIONISM',				'IMPROVEMENT_FARM_2',			'YIELD_FOOD',		1	),
('POLICY_DOMINIONISM',				'IMPROVEMENT_PASTURE',			'YIELD_FOOD',		1	),
('POLICY_TAXATION',					'IMPROVEMENT_FARM',				'YIELD_GOLD',		1	),
('POLICY_TAXATION',					'IMPROVEMENT_POLDER',			'YIELD_GOLD',		1	),
('POLICY_TAXATION',					'IMPROVEMENT_FARM_2',			'YIELD_GOLD',		1	),
('POLICY_TAXATION',					'IMPROVEMENT_PASTURE',			'YIELD_GOLD',		1	),
('POLICY_TAXATION',					'IMPROVEMENT_MINE',				'YIELD_GOLD',		1	),
('POLICY_TAXATION',					'IMPROVEMENT_MINE_2',			'YIELD_GOLD',		1	),
('POLICY_TAXATION',					'IMPROVEMENT_QUARRY',			'YIELD_GOLD',		1	),
('POLICY_TAXATION',					'IMPROVEMENT_WELL',				'YIELD_GOLD',		1	),
('POLICY_TAXATION',					'IMPROVEMENT_E_PLANTATION',		'YIELD_GOLD',		1	),
('POLICY_TAXATION',					'IMPROVEMENT_T_PLANTATION',		'YIELD_GOLD',		1	),
('POLICY_TAXATION',					'IMPROVEMENT_ORCHARD',			'YIELD_GOLD',		1	),
('POLICY_TAXATION',					'IMPROVEMENT_VINEYARD',			'YIELD_GOLD',		1	),
('POLICY_TAXATION',					'IMPROVEMENT_CAMP',				'YIELD_GOLD',		1	),
('POLICY_TAXATION',					'IMPROVEMENT_LUMBERMILL',		'YIELD_GOLD',		1	),
('POLICY_TAXATION',					'IMPROVEMENT_LUMBERMILL_2',		'YIELD_GOLD',		1	),
('POLICY_TAXATION',					'IMPROVEMENT_FISHING_BOATS',	'YIELD_GOLD',		1	),
('POLICY_TAXATION',					'IMPROVEMENT_WHALING_BOATS',	'YIELD_GOLD',		1	),
('POLICY_INDUSTRIALIZATION',		'IMPROVEMENT_FARM',				'YIELD_PRODUCTION',	1	),
('POLICY_INDUSTRIALIZATION',		'IMPROVEMENT_POLDER',			'YIELD_PRODUCTION',	1	),
('POLICY_INDUSTRIALIZATION',		'IMPROVEMENT_FARM_2',			'YIELD_PRODUCTION',	1	),
('POLICY_INDUSTRIALIZATION',		'IMPROVEMENT_PASTURE',			'YIELD_PRODUCTION',	1	),
('POLICY_INDUSTRIALIZATION',		'IMPROVEMENT_MINE',				'YIELD_PRODUCTION',	1	),
('POLICY_INDUSTRIALIZATION',		'IMPROVEMENT_MINE_2',			'YIELD_PRODUCTION',	1	),
('POLICY_INDUSTRIALIZATION',		'IMPROVEMENT_QUARRY',			'YIELD_PRODUCTION',	1	),
('POLICY_INDUSTRIALIZATION',		'IMPROVEMENT_WELL',				'YIELD_PRODUCTION',	1	),
('POLICY_INDUSTRIALIZATION',		'IMPROVEMENT_E_PLANTATION',		'YIELD_PRODUCTION',	1	),
('POLICY_INDUSTRIALIZATION',		'IMPROVEMENT_T_PLANTATION',		'YIELD_PRODUCTION',	1	),
('POLICY_INDUSTRIALIZATION',		'IMPROVEMENT_ORCHARD',			'YIELD_PRODUCTION',	1	),
('POLICY_INDUSTRIALIZATION',		'IMPROVEMENT_VINEYARD',			'YIELD_PRODUCTION',	1	),
('POLICY_INDUSTRIALIZATION',		'IMPROVEMENT_CAMP',				'YIELD_PRODUCTION',	1	),
('POLICY_INDUSTRIALIZATION',		'IMPROVEMENT_LUMBERMILL',		'YIELD_PRODUCTION',	1	),
('POLICY_INDUSTRIALIZATION',		'IMPROVEMENT_LUMBERMILL_2',		'YIELD_PRODUCTION',	1	),
('POLICY_INDUSTRIALIZATION',		'IMPROVEMENT_FISHING_BOATS',	'YIELD_PRODUCTION',	1	),
('POLICY_INDUSTRIALIZATION',		'IMPROVEMENT_WHALING_BOATS',	'YIELD_PRODUCTION',	1	),

--Pantheism
('POLICY_ANIMAL_LORE',				'IMPROVEMENT_PASTURE',			'YIELD_FOOD',		1	),
('POLICY_ANIMAL_LORE',				'IMPROVEMENT_PASTURE',			'YIELD_PRODUCTION',	1	),
('POLICY_ANIMAL_LORE',				'IMPROVEMENT_CAMP',				'YIELD_FOOD',		1	),
('POLICY_ANIMAL_LORE',				'IMPROVEMENT_CAMP',				'YIELD_PRODUCTION',	1	),
('POLICY_ANIMAL_LORE',				'IMPROVEMENT_FISHING_BOATS',	'YIELD_FOOD',		1	),
('POLICY_ANIMAL_LORE',				'IMPROVEMENT_FISHING_BOATS',	'YIELD_PRODUCTION',	1	),
('POLICY_ANIMAL_LORE',				'IMPROVEMENT_WHALING_BOATS',	'YIELD_FOOD',		1	),
('POLICY_ANIMAL_LORE',				'IMPROVEMENT_WHALING_BOATS',	'YIELD_PRODUCTION',	1	),
('POLICY_FERAL_BOND',				'IMPROVEMENT_PASTURE',			'YIELD_FAITH',		1	),
('POLICY_FERAL_BOND',				'IMPROVEMENT_CAMP',				'YIELD_FAITH',		1	),
('POLICY_FERAL_BOND',				'IMPROVEMENT_FISHING_BOATS',	'YIELD_FAITH',		1	),
('POLICY_FERAL_BOND',				'IMPROVEMENT_WHALING_BOATS',	'YIELD_FAITH',		1	),
('POLICY_WOODS_LORE',				'IMPROVEMENT_FARM_2',			'YIELD_FOOD',		1	),
('POLICY_WOODS_LORE',				'IMPROVEMENT_FARM_2',			'YIELD_PRODUCTION',	1	),
('POLICY_WOODS_LORE',				'IMPROVEMENT_VINEYARD',			'YIELD_FOOD',		1	),
('POLICY_WOODS_LORE',				'IMPROVEMENT_VINEYARD',			'YIELD_PRODUCTION',	1	),
('POLICY_WOODS_LORE',				'IMPROVEMENT_E_PLANTATION',		'YIELD_FOOD',		1	),
('POLICY_WOODS_LORE',				'IMPROVEMENT_E_PLANTATION',		'YIELD_PRODUCTION',	1	),
('POLICY_WOODS_LORE',				'IMPROVEMENT_T_PLANTATION',		'YIELD_FOOD',		1	),
('POLICY_WOODS_LORE',				'IMPROVEMENT_T_PLANTATION',		'YIELD_PRODUCTION',	1	),
('POLICY_WOODS_LORE',				'IMPROVEMENT_ORCHARD',			'YIELD_FOOD',		1	),
('POLICY_WOODS_LORE',				'IMPROVEMENT_ORCHARD',			'YIELD_PRODUCTION',	1	),
('POLICY_WOODS_LORE',				'IMPROVEMENT_LUMBERMILL_2',		'YIELD_FOOD',		1	),
('POLICY_WOODS_LORE',				'IMPROVEMENT_LUMBERMILL_2',		'YIELD_PRODUCTION',	1	),
('POLICY_FELLOWSHIP_OF_LEAVES',		'IMPROVEMENT_FARM_2',			'YIELD_FAITH',		1	),
('POLICY_FELLOWSHIP_OF_LEAVES',		'IMPROVEMENT_VINEYARD',			'YIELD_FAITH',		1	),
('POLICY_FELLOWSHIP_OF_LEAVES',		'IMPROVEMENT_E_PLANTATION',		'YIELD_FAITH',		1	),
('POLICY_FELLOWSHIP_OF_LEAVES',		'IMPROVEMENT_T_PLANTATION',		'YIELD_FAITH',		1	),
('POLICY_FELLOWSHIP_OF_LEAVES',		'IMPROVEMENT_ORCHARD',			'YIELD_FAITH',		1	),
('POLICY_EARTH_LORE',				'IMPROVEMENT_MINE_2',			'YIELD_GOLD',		1	),
('POLICY_EARTH_LORE',				'IMPROVEMENT_QUARRY',			'YIELD_GOLD',		1	),
('POLICY_EARTH_LORE',				'IMPROVEMENT_WELL',				'YIELD_GOLD',		1	),
('POLICY_MANA_VORTEXES',			'IMPROVEMENT_MINE_2',			'YIELD_SCIENCE',	1	),
('POLICY_MANA_VORTEXES',			'IMPROVEMENT_MINE_2',			'YIELD_FAITH',		2	),
('POLICY_MANA_VORTEXES',			'IMPROVEMENT_QUARRY',			'YIELD_SCIENCE',	1	),
('POLICY_MANA_VORTEXES',			'IMPROVEMENT_QUARRY',			'YIELD_FAITH',		2	),

('POLICY_SOCIO_ARCANA',				'IMPROVEMENT_GATHERERS_HUT',	'YIELD_FAITH',		1	),

--utility


('POLICY_LEVIATHAN_TOME',			'IMPROVEMENT_WHALING_BOATS',	'YIELD_SCIENCE',	2	);


DELETE FROM Policy_ImprovementCultureChanges;
INSERT INTO Policy_ImprovementCultureChanges (PolicyType, ImprovementType, CultureChange) VALUES
('POLICY_FERAL_BOND',				'IMPROVEMENT_PASTURE',			1	),
('POLICY_FERAL_BOND',				'IMPROVEMENT_CAMP',				1	),
('POLICY_FERAL_BOND',				'IMPROVEMENT_FISHING_BOATS',	1	),
('POLICY_FERAL_BOND',				'IMPROVEMENT_WHALING_BOATS',	1	),
('POLICY_FELLOWSHIP_OF_LEAVES',		'IMPROVEMENT_FARM_2',			1	),
('POLICY_FELLOWSHIP_OF_LEAVES',		'IMPROVEMENT_VINEYARD',			1	),
('POLICY_FELLOWSHIP_OF_LEAVES',		'IMPROVEMENT_E_PLANTATION',		1	),
('POLICY_EARTH_LORE',				'IMPROVEMENT_MINE_2',				1	),
('POLICY_EARTH_LORE',				'IMPROVEMENT_QUARRY',			1	),
('POLICY_EARTH_LORE',				'IMPROVEMENT_WELL',				1	),

--('POLICY_FOLKART',				'IMPROVEMENT_FESTIVAL',			1	),
('POLICY_CRAFTING',					'IMPROVEMENT_VINEYARD',			1	),
('POLICY_CRAFTING',					'IMPROVEMENT_QUARRY',			1	);

DELETE FROM Policy_YieldModifiers;	--not in base but it works
--INSERT INTO Policy_YieldModifiers (PolicyType, YieldType, Yield)


DELETE FROM Policy_FreePromotions;		--Works if promo in UnitPromotions_UnitCombats. Will transfer to other civ. Can be removed (stays removed)
INSERT INTO Policy_FreePromotions (PolicyType,	PromotionType) VALUES
('POLICY_SLAVE_RAIDERS',		'PROMOTION_SLAVERAIDER'			),
('POLICY_SLAVE_ARMIES',			'PROMOTION_SLAVEMAKER'			),
('POLICY_DISCIPLINE',			'PROMOTION_ADJACENT_BONUS'		),
('POLICY_MERCHANT_NAVY',		'PROMOTION_NAVAL_TRADITION'		);



DELETE FROM Policy_UnitCombatFreeExperiences;
INSERT INTO Policy_UnitCombatFreeExperiences (PolicyType,	UnitCombatType,	FreeExperience) VALUES
('POLICY_EQUUS_TOME_XP_0064',	'UNITCOMBAT_MOUNTED',	64	),
('POLICY_EQUUS_TOME_XP_0032',	'UNITCOMBAT_MOUNTED',	32	),
('POLICY_EQUUS_TOME_XP_0016',	'UNITCOMBAT_MOUNTED',	16	),
('POLICY_EQUUS_TOME_XP_0008',	'UNITCOMBAT_MOUNTED',	8	),
('POLICY_EQUUS_TOME_XP_0004',	'UNITCOMBAT_MOUNTED',	4	),
('POLICY_EQUUS_TOME_XP_0002',	'UNITCOMBAT_MOUNTED',	2	),
('POLICY_EQUUS_TOME_XP_0001',	'UNITCOMBAT_MOUNTED',	1	);

-- fixinator
CREATE TABLE IDRemapper ( id INTEGER PRIMARY KEY AUTOINCREMENT, Type TEXT );
INSERT INTO IDRemapper (Type) SELECT Type FROM Policies ORDER BY ID;
UPDATE Policies SET ID =	( SELECT IDRemapper.id-1 FROM IDRemapper WHERE Policies.Type = IDRemapper.Type);
DROP TABLE IDRemapper;

CREATE TABLE IDRemapper ( id INTEGER PRIMARY KEY AUTOINCREMENT, Type TEXT );
INSERT INTO IDRemapper (Type) SELECT Type FROM PolicyBranchTypes ORDER BY ID;
UPDATE PolicyBranchTypes SET ID =	( SELECT IDRemapper.id-1 FROM IDRemapper WHERE PolicyBranchTypes.Type = IDRemapper.Type);
DROP TABLE IDRemapper;


INSERT INTO EaDebugTableCheck(FileName) SELECT 'Policies.sql';