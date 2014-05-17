-- Contains UnitClasses, Units, and all Units subtables; tables defined in base

-- Notes: Racial versions are given their own unitclasses. This is so that units maintain race regardless of owner.
-- The UnitClasses table is constructed entirely from the Units table

DELETE FROM Units WHERE Type NOT IN ('UNIT_MISSIONARY', 'UNIT_CARAVAN', 'UNIT_CARGO_SHIP');					--Missionary needed to prevent CTD after religion enhancement
UPDATE Units SET ID = 0, FaithCost = 999999 WHERE Type = 'UNIT_MISSIONARY';			--we also use it to detect errors in unit initing, since you get the id=0 unit if unitTypeID is nil

ALTER TABLE Units ADD COLUMN 'IsWorker' BOOLEAN DEFAULT NULL;
ALTER TABLE Units ADD COLUMN 'EaRace' TEXT DEFAULT NULL;
ALTER TABLE Units ADD COLUMN 'EaCityTrainRace' TEXT DEFAULT NULL;
ALTER TABLE Units ADD COLUMN 'EaSpecialWorker' TEXT DEFAULT NULL;
ALTER TABLE Units ADD COLUMN 'EaLiving' BOOLEAN DEFAULT NULL;
ALTER TABLE Units ADD COLUMN 'EaNoTrain' BOOLEAN DEFAULT NULL;
ALTER TABLE Units ADD COLUMN 'EaGPTempRole' TEXT DEFAULT NULL;
ALTER TABLE Units ADD COLUMN 'EaSpecial' TEXT DEFAULT NULL;			--Animal, Beast, Undead, Demon, Angel, Utility

----------------------------------------------------------------------------------------
-- Normal units (UnitClasses & Units)
----------------------------------------------------------------------------------------

--UNITCOMBAT_GUN for mounted ranged?


-- Non-race & currently generic
INSERT INTO Units (Type,		PrereqTech,					Cost,	Combat,	RangedCombat,	Range,	Moves,	CombatClass,				Domain,			DefaultUnitAI,			Pillage,	MilitarySupport,	MilitaryProduction,	ObsoleteTech,		Mechanized,	UnitArtInfo,							IconAtlas,					PortraitIndex,	UnitFlagAtlas,					UnitFlagIconOffset,	MoveRate		) VALUES
('UNIT_FISHING_BOATS',			'TECH_FISHING',				80,		0,		0,				0,		0,		NULL,						'DOMAIN_AIR',	'UNITAI_WORKER_SEA',	0,			0,					0,					NULL,				1,			'ART_DEF_UNIT_WORKBOAT',				'UNIT_ATLAS_1',				2,				'UNIT_FLAG_ATLAS',				2,					'WOODEN_BOAT'	),
('UNIT_WHALING_BOATS',			'TECH_HARPOONS',			80,		0,		0,				0,		0,		NULL,						'DOMAIN_AIR',	'UNITAI_WORKER_SEA',	0,			0,					0,					NULL,				1,			'ART_DEF_UNIT_WORKBOAT',				'UNIT_ATLAS_1',				2,				'UNIT_FLAG_ATLAS',				2,					'WOODEN_BOAT'	),
('UNIT_HUNTERS',				'TECH_HUNTING',				80,		0,		0,				0,		0,		NULL,						'DOMAIN_AIR',	'UNITAI_WORKER',		0,			0,					0,					NULL,				0,			'ART_DEF_UNIT_SCOUT',					'UNIT_ATLAS_1',				5,				'UNIT_FLAG_ATLAS',				5,					'BIPED'			),
('UNIT_SETTLERS_MINOR',			'TECH_NEVER',				0,		0,		0,				0,		2,		NULL,						'DOMAIN_LAND',	'UNITAI_SETTLE',		0,			0,					0,					NULL,				0,			'ART_DEF_UNIT__SETTLER',				'UNIT_ATLAS_1',				0,				'UNIT_FLAG_ATLAS',				0,					'BIPED'			),

--('UNIT_CARAVAN',				'TECH_CURRENCY',			100,	0,		0,				0,		1,		NULL,						'DOMAIN_LAND',	'UNITAI_WORKER',		0,			0,					0,					NULL,				0,			'ART_DEF_UNIT_CARAVAN',					'EXPANSION2_UNIT_ATLAS',	3,				'EXPANSION2_UNIT_FLAG_ATLAS',	3,					'BIPED'			),
--('UNIT_CARGO_SHIP',				'TECH_SAILING',				100,	0,		0,				0,		1,		NULL,						'DOMAIN_SEA',	'UNITAI_WORKER',		0,			0,					0,					NULL,				1,			'ART_DEF_UNIT_CARGO_SHIP',				'EXPANSION2_UNIT_ATLAS',	4,				'EXPANSION2_UNIT_FLAG_ATLAS',	4,					'BIPED'			),

('UNIT_BIREMES',				'TECH_SAILING',				180,	9,		0,				0,		3,		'UNITCOMBAT_NAVALMELEE',	'DOMAIN_SEA',	'UNITAI_ATTACK_SEA',	1,			1,					1,					NULL,				1,			'ART_DEF_UNIT_TRIREME',					'UNIT_ATLAS_1',				24,				'UNIT_FLAG_ATLAS',				24,					'WOODEN_BOAT'	),
('UNIT_TRIREMES',				'TECH_SHIP_BUILDING',		240,	12,		0,				0,		3,		'UNITCOMBAT_NAVALMELEE',	'DOMAIN_SEA',	'UNITAI_ATTACK_SEA',	1,			1,					1,					NULL,				1,			'ART_DEF_UNIT_TRIREME',					'UNIT_ATLAS_1',				24,				'UNIT_FLAG_ATLAS',				24,					'WOODEN_BOAT'	),
('UNIT_QUINQUEREMES',			'TECH_SHIP_BUILDING',		300,	15,		0,				0,		3,		'UNITCOMBAT_NAVALMELEE',	'DOMAIN_SEA',	'UNITAI_ATTACK_SEA',	1,			1,					1,					NULL,				1,			'ART_DEF_UNIT_U_CARTHAGE_QUINQUEREME',	'EXPANSION_UNIT_ATLAS_1',	11,				'EXPANSION_UNIT_FLAG_ATLAS',	11,					'WOODEN_BOAT'	),
('UNIT_CARAVELS',				'TECH_ASTRONOMY',			200,	10,		0,				0,		5,		'UNITCOMBAT_NAVALMELEE',	'DOMAIN_SEA',	'UNITAI_ATTACK_SEA',	1,			1,					1,					NULL,				1,			'ART_DEF_UNIT_CARAVEL',					'UNIT_ATLAS_1',				43,				'UNIT_FLAG_ATLAS',				42,					'BOAT'			),

('UNIT_DROMONS',				'TECH_NAVIGATION',			240,	12,		12,				2,		4,		'UNITCOMBAT_NAVALRANGED',	'DOMAIN_SEA',	'UNITAI_ATTACK_SEA',	1,			1,					1,					NULL,				1,			'ART_DEF_UNIT_U_BYZANTIUM_DROMON',		'EXPANSION_UNIT_ATLAS_1',	5,				'EXPANSION_UNIT_FLAG_ATLAS',	5,					'WOODEN_BOAT'	),
('UNIT_CARRACKS',				'TECH_NAVAL_ENGINEERING',	300,	15,		15,				2,		4,		'UNITCOMBAT_NAVALRANGED',	'DOMAIN_SEA',	'UNITAI_ATTACK_SEA',	1,			1,					1,					NULL,				1,			'ART_DEF_UNIT_TRIREME',					'UNIT_ATLAS_1',				24,				'UNIT_FLAG_ATLAS',				24,					'WOODEN_BOAT'	),
('UNIT_GALLEONS',				'TECH_ADV_NAVAL_ENGINEERING',360,	18,		18,				2,		4,		'UNITCOMBAT_NAVALRANGED',	'DOMAIN_SEA',	'UNITAI_ATTACK_SEA',	1,			1,					1,					NULL,				1,			'ART_DEF_UNIT_FRIGATE',					'UNIT_ATLAS_2',				8,				'UNIT_FLAG_ATLAS',				51,					'WOODEN_BOAT'	),
('UNIT_IRONCLADS',				'TECH_STEAM_POWER',			360,	18,		18,				2,		2,		'UNITCOMBAT_NAVALRANGED',	'DOMAIN_SEA',	'UNITAI_ATTACK_SEA',	1,			1,					1,					NULL,				1,			'ART_DEF_UNIT_IRONCLAD',				'UNIT_ATLAS_2',				10,				'UNIT_FLAG_ATLAS',				53,					'BOAT'			),

('UNIT_BALLISTAE',				'TECH_ARCHERY',				200,	8,		10,				2,		2,		'UNITCOMBAT_SIEGE',			'DOMAIN_LAND',	'UNITAI_CITY_BOMBARD',	1,			1,					1,					NULL,				1,			'ART_DEF_UNIT_U_ROMAN_BALLISTA',		'UNIT_ATLAS_2',				22,				'UNIT_FLAG_ATLAS',				22,					'ARTILLERY'		),
('UNIT_CATAPULTS',				'TECH_MATHEMATICS',			180,	6,		9,				2,		2,		'UNITCOMBAT_SIEGE',			'DOMAIN_LAND',	'UNITAI_CITY_BOMBARD',	1,			1,					1,					NULL,				1,			'ART_DEF_UNIT_CATAPULT',				'UNIT_ATLAS_1',				21,				'UNIT_FLAG_ATLAS',				21,					'ARTILLERY'		),
('UNIT_TREBUCHETS',				'TECH_MECHANICS',			240,	9,		12,				2,		2,		'UNITCOMBAT_SIEGE',			'DOMAIN_LAND',	'UNITAI_CITY_BOMBARD',	1,			1,					1,					NULL,				1,			'ART_DEF_UNIT_TREBUCHET',				'UNIT_ATLAS_1',				42,				'UNIT_FLAG_ATLAS',				41,					'ARTILLERY'		),
('UNIT_FIRE_CATAPULTS',			'TECH_MATHEMATICS',			220,	8,		11,				2,		2,		'UNITCOMBAT_SIEGE',			'DOMAIN_LAND',	'UNITAI_CITY_BOMBARD',	1,			1,					1,					NULL,				1,			'ART_DEF_UNIT_CATAPULT',				'UNIT_ATLAS_1',				21,				'UNIT_FLAG_ATLAS',				21,					'ARTILLERY'		),
('UNIT_FIRE_TREBUCHETS',		'TECH_MECHANICS',			280,	11,		14,				2,		2,		'UNITCOMBAT_SIEGE',			'DOMAIN_LAND',	'UNITAI_CITY_BOMBARD',	1,			1,					1,					NULL,				1,			'ART_DEF_UNIT_TREBUCHET',				'UNIT_ATLAS_1',				42,				'UNIT_FLAG_ATLAS',				41,					'ARTILLERY'		),
('UNIT_BOMBARDS',				'TECH_IRON_WORKING',		300,	12,		15,				2,		2,		'UNITCOMBAT_SIEGE',			'DOMAIN_LAND',	'UNITAI_CITY_BOMBARD',	1,			1,					1,					NULL,				1,			'ART_DEF_UNIT_CANNON',					'UNIT_ATLAS_2',				0,				'UNIT_FLAG_ATLAS',				43,					'ARTILLERY'		),
('UNIT_GREAT_BOMBARDE',			'TECH_METAL_CASTING',		300,	9,		15,				2,		1,		'UNITCOMBAT_SIEGE',			'DOMAIN_LAND',	'UNITAI_CITY_BOMBARD',	1,			1,					1,					NULL,				1,			'ART_DEF_UNIT_CANNON',					'UNIT_ATLAS_2',				0,				'UNIT_FLAG_ATLAS',				43,					'ARTILLERY'		),

('UNIT_MOUNTED_ELEPHANTS',		'TECH_ELEPHANT_TRAINING',	320,	15,		15,				1,		2,		'UNITCOMBAT_ARMOR',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_U_SIAMESE_WARELEPHANT',	'UNIT_ATLAS_1',				29,				'UNIT_FLAG_ATLAS',				28,					'PHANT'			),
('UNIT_WAR_ELEPHANTS',			'TECH_WAR_ELEPHANTS',		380,	18,		18,				1,		2,		'UNITCOMBAT_ARMOR',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_U_SIAMESE_WARELEPHANT',	'UNIT_ATLAS_1',				29,				'UNIT_FLAG_ATLAS',				28,					'PHANT'			),
('UNIT_MUMAKIL',				'TECH_MUMAKIL_RIDING',		500,	24,		24,				1,		2,		'UNITCOMBAT_ARMOR',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_U_SIAMESE_WARELEPHANT',	'UNIT_ATLAS_1',				29,				'UNIT_FLAG_ATLAS',				28,					'PHANT'			),

-- Man
('UNIT_SETTLERS_MAN',			NULL,						0,		0,		0,				0,		2,		NULL,						'DOMAIN_LAND',	'UNITAI_SETTLE',		0,			0,					0,					NULL,				0,			'ART_DEF_UNIT__SETTLER',				'UNIT_ATLAS_1',				0,				'UNIT_FLAG_ATLAS',				0,					'BIPED'			),
('UNIT_WORKERS_MAN',			NULL,						100,	0,		0,				0,		2,		NULL,						'DOMAIN_LAND',	'UNITAI_WORKER',		0,			0,					0,					NULL,				0,			'ART_DEF_UNIT__WORKER',					'UNIT_ATLAS_1',				1,				'UNIT_FLAG_ATLAS',				1,					'BIPED'			),
('UNIT_SLAVES_MAN',				NULL,						70,		0,		0,				0,		2,		NULL,						'DOMAIN_LAND',	'UNITAI_WORKER',		0,			0,					0,					NULL,				0,			'ART_DEF_UNIT__WORKER',					'UNIT_ATLAS_1',				1,				'UNIT_FLAG_ATLAS',				1,					'BIPED'			),

('UNIT_SCOUTS_MAN',				'TECH_HUNTING',				80,		4,		0,				0,		2,		'UNITCOMBAT_RECON',			'DOMAIN_LAND',	'UNITAI_EXPLORE',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_SCOUT',					'UNIT_ATLAS_1',				5,				'UNIT_FLAG_ATLAS',				5,					'BIPED'			),
('UNIT_TRACKERS_MAN',			'TECH_TRACKING_TRAPPING',	160,	8,		0,				0,		2,		'UNITCOMBAT_RECON',			'DOMAIN_LAND',	'UNITAI_EXPLORE',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_SCOUT',					'UNIT_ATLAS_1',				5,				'UNIT_FLAG_ATLAS',				5,					'BIPED'			),
('UNIT_RANGERS_MAN',			'TECH_ANIMAL_MASTERY',		240,	12,		0,				0,		2,		'UNITCOMBAT_RECON',			'DOMAIN_LAND',	'UNITAI_EXPLORE',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_SCOUT',					'UNIT_ATLAS_1',				5,				'UNIT_FLAG_ATLAS',				5,					'BIPED'			),

('UNIT_WARRIORS_MAN',			NULL,						120,	6,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT__WARRIOR',				'UNIT_ATLAS_1',				3,				'UNIT_FLAG_ATLAS',				3,					'BIPED'			),
('UNIT_LIGHT_INFANTRY_MAN',		'TECH_BRONZE_WORKING',		180,	9,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_SPEARMAN',				'UNIT_ATLAS_1',				9,				'UNIT_FLAG_ATLAS',				9,					'BIPED'			),
('UNIT_MEDIUM_INFANTRY_MAN',	'TECH_IRON_WORKING',		240,	12,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_SWORDSMAN',				'UNIT_ATLAS_1',				14,				'UNIT_FLAG_ATLAS',				14,					'HEAVY_BIPED'	),
('UNIT_HEAVY_INFANTRY_MAN',		'TECH_METAL_CASTING',		300,	15,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_U_ROMAN_LEGION',			'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'HEAVY_BIPED'	),
('UNIT_IMMORTALS_MAN',			'TECH_MITHRIL_WORKING',		420,	21,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_LONGSWORDSMAN',			'UNIT_ATLAS_1',				36,				'UNIT_FLAG_ATLAS',				35,					'BIPED'			),

('UNIT_CHARIOTS_MAN',			NULL,						160,	7,		0,				0,		3,		'UNITCOMBAT_MOUNTED',		'DOMAIN_LAND',	'UNITAI_FAST_ATTACK',	1,			1,					1,					'TECH_WAR_HORSES',	1,			'ART_DEF_UNIT_MAN_CHARIOT',				'UNIT_ATLAS_1',				17,				'UNIT_FLAG_ATLAS',				17,					'QUADRUPED'		),
('UNIT_HORSEMEN_MAN',			'TECH_HORSEBACK_RIDING',	200,	9,		0,				0,		4,		'UNITCOMBAT_MOUNTED',		'DOMAIN_LAND',	'UNITAI_FAST_ATTACK',	1,			1,					1,					'TECH_WAR_HORSES',	0,			'ART_DEF_UNIT_HORSEMAN',				'UNIT_ATLAS_1',				17,				'UNIT_FLAG_ATLAS',				17,					'QUADRUPED'		),
('UNIT_EQUITES_MAN',			'TECH_STIRRUPS',			260,	12,		0,				0,		4,		'UNITCOMBAT_MOUNTED',		'DOMAIN_LAND',	'UNITAI_FAST_ATTACK',	1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_HORSEMAN',				'UNIT_ATLAS_1',				17,				'UNIT_FLAG_ATLAS',				17,					'QUADRUPED'		),
('UNIT_ARMORED_CAVALRY_MAN',	'TECH_STIRRUPS',			280,	13,		0,				0,		3,		'UNITCOMBAT_MOUNTED',		'DOMAIN_LAND',	'UNITAI_FAST_ATTACK',	1,			1,					1,					'TECH_WAR_HORSES',	0,			'ART_DEF_UNIT_KNIGHT',					'UNIT_ATLAS_1',				26,				'UNIT_FLAG_ATLAS',				25,					'QUADRUPED'		),
('UNIT_CATAPHRACTS_MAN',		'TECH_WAR_HORSES',			340,	16,		0,				0,		3,		'UNITCOMBAT_MOUNTED',		'DOMAIN_LAND',	'UNITAI_FAST_ATTACK',	1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_KNIGHT',					'UNIT_ATLAS_1',				26,				'UNIT_FLAG_ATLAS',				25,					'QUADRUPED'		),
('UNIT_CLIBANARII_MAN',			'TECH_MITHRIL_WORKING',		460,	22,		0,				0,		3,		'UNITCOMBAT_MOUNTED',		'DOMAIN_LAND',	'UNITAI_FAST_ATTACK',	1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_KNIGHT',					'UNIT_ATLAS_1',				26,				'UNIT_FLAG_ATLAS',				25,					'QUADRUPED'		),

('UNIT_ARCHERS_MAN',			'TECH_ARCHERY',				180,	8,		8,				1,		2,		'UNITCOMBAT_ARCHER',		'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_ARCHER',					'UNIT_ATLAS_1',				6,				'UNIT_FLAG_ATLAS',				6,					'BIPED'			),
('UNIT_BOWMEN_MAN',				'TECH_BOWYERS',				260,	12,		12,				1,		2,		'UNITCOMBAT_ARCHER',		'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_COMPOSITE_BOWMAN',		'EXPANSION_UNIT_ATLAS_1',	13,				'EXPANSION_UNIT_FLAG_ATLAS',	13,					'BIPED'			),
('UNIT_MARKSMEN_MAN',			'TECH_MARKSMANSHIP',		360,	17,		17,				1,		2,		'UNITCOMBAT_ARCHER',		'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_COMPOSITE_BOWMAN',		'EXPANSION_UNIT_ATLAS_1',	13,				'EXPANSION_UNIT_FLAG_ATLAS',	13,					'BIPED'			),
('UNIT_CROSSBOWMEN_MAN',		'TECH_MECHANICS',			180,	8,		8,				1,		2,		'UNITCOMBAT_ARCHER',		'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_CROSSBOWMAN',				'UNIT_ATLAS_1',				30,				'UNIT_FLAG_ATLAS',				29,					'BIPED'			),
('UNIT_ARQUEBUSSMEN_MAN',		'TECH_MACHINERY',			320,	15,		15,				1,		2,		'UNITCOMBAT_ARCHER',		'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_MUSKETMAN',				'UNIT_ATLAS_1',				38,				'UNIT_FLAG_ATLAS',				37,					'BIPED'			),

('UNIT_CHARIOT_ARCHERS_MAN',	'TECH_ARCHERY',				160,	7,		7,				1,		3,		'UNITCOMBAT_GUN',			'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				1,			'ART_DEF_UNIT_CHARIOT_ARCHER',			'UNIT_ATLAS_1',				12,				'UNIT_FLAG_ATLAS',				12,					'WHEELED'		),
('UNIT_HORSE_ARCHERS_MAN',		'TECH_HORSEBACK_RIDING',	200,	9,		9,				1,		4,		'UNITCOMBAT_GUN',			'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_U_MONGOLIAN_KESHIK',		'GENGHIS_UNIT_ATLAS',		0,				'GENGHIS_UNIT_FLAG_ATLAS',		0,					'BIPED'			),
('UNIT_BOWED_CAVALRY_MAN',		'TECH_STIRRUPS',			260,	12,		12,				1,		4,		'UNITCOMBAT_GUN',			'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_U_MONGOLIAN_KESHIK',		'GENGHIS_UNIT_ATLAS',		0,				'GENGHIS_UNIT_FLAG_ATLAS',		0,					'BIPED'			),
('UNIT_SAGITARII_MAN',			'TECH_WAR_HORSES',			260,	12,		12,				1,		4,		'UNITCOMBAT_GUN',			'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_U_MONGOLIAN_KESHIK',		'GENGHIS_UNIT_ATLAS',		0,				'GENGHIS_UNIT_FLAG_ATLAS',		0,					'BIPED'			),

-- Sidhe
('UNIT_SETTLERS_SIDHE',			NULL,						0,		0,		0,				0,		2,		NULL,						'DOMAIN_LAND',	'UNITAI_SETTLE',		0,			0,					0,					NULL,				0,			'ART_DEF_UNIT__SETTLER',				'UNIT_ATLAS_1',				0,				'UNIT_FLAG_ATLAS',				0,					'BIPED'			),
('UNIT_WORKERS_SIDHE',			NULL,						100,	0,		0,				0,		2,		NULL,						'DOMAIN_LAND',	'UNITAI_WORKER',		0,			0,					0,					NULL,				0,			'ART_DEF_UNIT__WORKER',					'UNIT_ATLAS_1',				1,				'UNIT_FLAG_ATLAS',				1,					'BIPED'			),
('UNIT_SLAVES_SIDHE',			NULL,						70,		0,		0,				0,		2,		NULL,						'DOMAIN_LAND',	'UNITAI_WORKER',		0,			0,					0,					NULL,				0,			'ART_DEF_UNIT__WORKER',					'UNIT_ATLAS_1',				1,				'UNIT_FLAG_ATLAS',				1,					'BIPED'			),

('UNIT_SCOUTS_SIDHE',			'TECH_HUNTING',				80,		4,		0,				0,		2,		'UNITCOMBAT_RECON',			'DOMAIN_LAND',	'UNITAI_EXPLORE',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_SCOUT',					'UNIT_ATLAS_1',				5,				'UNIT_FLAG_ATLAS',				5,					'BIPED'			),
('UNIT_TRACKERS_SIDHE',			'TECH_TRACKING_TRAPPING',	160,	8,		0,				0,		2,		'UNITCOMBAT_RECON',			'DOMAIN_LAND',	'UNITAI_EXPLORE',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_SCOUT',					'UNIT_ATLAS_1',				5,				'UNIT_FLAG_ATLAS',				5,					'BIPED'			),
('UNIT_RANGERS_SIDHE',			'TECH_ANIMAL_MASTERY',		240,	12,		0,				0,		2,		'UNITCOMBAT_RECON',			'DOMAIN_LAND',	'UNITAI_EXPLORE',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_SCOUT',					'UNIT_ATLAS_1',				5,				'UNIT_FLAG_ATLAS',				5,					'BIPED'			),

('UNIT_WARRIORS_SIDHE',			NULL,						120,	6,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT__WARRIOR',				'UNIT_ATLAS_1',				3,				'UNIT_FLAG_ATLAS',				3,					'BIPED'			),
('UNIT_LIGHT_INFANTRY_SIDHE',	'TECH_BRONZE_WORKING',		180,	9,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_SPEARMAN',				'UNIT_ATLAS_1',				9,				'UNIT_FLAG_ATLAS',				9,					'BIPED'			),
('UNIT_MEDIUM_INFANTRY_SIDHE',	'TECH_IRON_WORKING',		240,	12,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_SWORDSMAN',				'UNIT_ATLAS_1',				14,				'UNIT_FLAG_ATLAS',				14,					'HEAVY_BIPED'	),
('UNIT_HEAVY_INFANTRY_SIDHE',	'TECH_METAL_CASTING',		300,	15,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_U_ROMAN_LEGION',			'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'HEAVY_BIPED'	),
('UNIT_IMMORTALS_SIDHE',		'TECH_MITHRIL_WORKING',		420,	21,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_LONGSWORDSMAN',			'UNIT_ATLAS_1',				36,				'UNIT_FLAG_ATLAS',				35,					'BIPED'			),

('UNIT_CHARIOTS_SIDHE',			NULL,						160,	7,		0,				0,		3,		'UNITCOMBAT_MOUNTED',		'DOMAIN_LAND',	'UNITAI_FAST_ATTACK',	1,			1,					1,					'TECH_WAR_HORSES',	1,			'ART_DEF_UNIT_MAN_CHARIOT',				'UNIT_ATLAS_1',				17,				'UNIT_FLAG_ATLAS',				17,					'QUADRUPED'		),
('UNIT_HORSEMEN_SIDHE',			'TECH_HORSEBACK_RIDING',	200,	9,		0,				0,		4,		'UNITCOMBAT_MOUNTED',		'DOMAIN_LAND',	'UNITAI_FAST_ATTACK',	1,			1,					1,					'TECH_WAR_HORSES',	0,			'ART_DEF_UNIT_HORSEMAN',				'UNIT_ATLAS_1',				17,				'UNIT_FLAG_ATLAS',				17,					'QUADRUPED'		),
('UNIT_EQUITES_SIDHE',			'TECH_STIRRUPS',			260,	12,		0,				0,		4,		'UNITCOMBAT_MOUNTED',		'DOMAIN_LAND',	'UNITAI_FAST_ATTACK',	1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_HORSEMAN',				'UNIT_ATLAS_1',				17,				'UNIT_FLAG_ATLAS',				17,					'QUADRUPED'		),
('UNIT_ARMORED_CAVALRY_SIDHE',	'TECH_STIRRUPS',			280,	13,		0,				0,		3,		'UNITCOMBAT_MOUNTED',		'DOMAIN_LAND',	'UNITAI_FAST_ATTACK',	1,			1,					1,					'TECH_WAR_HORSES',	0,			'ART_DEF_UNIT_KNIGHT',					'UNIT_ATLAS_1',				26,				'UNIT_FLAG_ATLAS',				25,					'QUADRUPED'		),
('UNIT_CATAPHRACTS_SIDHE',		'TECH_WAR_HORSES',			340,	16,		0,				0,		3,		'UNITCOMBAT_MOUNTED',		'DOMAIN_LAND',	'UNITAI_FAST_ATTACK',	1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_KNIGHT',					'UNIT_ATLAS_1',				26,				'UNIT_FLAG_ATLAS',				25,					'QUADRUPED'		),
('UNIT_CLIBANARII_SIDHE',		'TECH_MITHRIL_WORKING',		460,	22,		0,				0,		3,		'UNITCOMBAT_MOUNTED',		'DOMAIN_LAND',	'UNITAI_FAST_ATTACK',	1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_KNIGHT',					'UNIT_ATLAS_1',				26,				'UNIT_FLAG_ATLAS',				25,					'QUADRUPED'		),

('UNIT_ARCHERS_SIDHE',			'TECH_ARCHERY',				180,	8,		8,				1,		2,		'UNITCOMBAT_ARCHER',		'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_ARCHER',					'UNIT_ATLAS_1',				6,				'UNIT_FLAG_ATLAS',				6,					'BIPED'			),
('UNIT_BOWMEN_SIDHE',			'TECH_BOWYERS',				260,	12,		12,				1,		2,		'UNITCOMBAT_ARCHER',		'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_COMPOSITE_BOWMAN',		'EXPANSION_UNIT_ATLAS_1',	13,				'EXPANSION_UNIT_FLAG_ATLAS',	13,					'BIPED'			),
('UNIT_MARKSMEN_SIDHE',			'TECH_MARKSMANSHIP',		360,	17,		17,				1,		2,		'UNITCOMBAT_ARCHER',		'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_COMPOSITE_BOWMAN',		'EXPANSION_UNIT_ATLAS_1',	13,				'EXPANSION_UNIT_FLAG_ATLAS',	13,					'BIPED'			),
('UNIT_CROSSBOWMEN_SIDHE',		'TECH_MECHANICS',			180,	8,		8,				1,		2,		'UNITCOMBAT_ARCHER',		'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_CROSSBOWMAN',				'UNIT_ATLAS_1',				30,				'UNIT_FLAG_ATLAS',				29,					'BIPED'			),
('UNIT_ARQUEBUSSMEN_SIDHE',		'TECH_MACHINERY',			320,	15,		15,				1,		2,		'UNITCOMBAT_ARCHER',		'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_MUSKETMAN',				'UNIT_ATLAS_1',				38,				'UNIT_FLAG_ATLAS',				37,					'BIPED'			),

('UNIT_CHARIOT_ARCHERS_SIDHE',	'TECH_ARCHERY',				160,	7,		7,				1,		3,		'UNITCOMBAT_GUN',			'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				1,			'ART_DEF_UNIT_CHARIOT_ARCHER',			'UNIT_ATLAS_1',				12,				'UNIT_FLAG_ATLAS',				12,					'WHEELED'		),
('UNIT_HORSE_ARCHERS_SIDHE',	'TECH_HORSEBACK_RIDING',	200,	9,		9,				1,		4,		'UNITCOMBAT_GUN',			'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_U_MONGOLIAN_KESHIK',		'GENGHIS_UNIT_ATLAS',		0,				'GENGHIS_UNIT_FLAG_ATLAS',		0,					'BIPED'			),
('UNIT_BOWED_CAVALRY_SIDHE',	'TECH_STIRRUPS',			260,	12,		12,				1,		4,		'UNITCOMBAT_GUN',			'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_U_MONGOLIAN_KESHIK',		'GENGHIS_UNIT_ATLAS',		0,				'GENGHIS_UNIT_FLAG_ATLAS',		0,					'BIPED'			),
('UNIT_SAGITARII_SIDHE',		'TECH_WAR_HORSES',			260,	12,		12,				1,		4,		'UNITCOMBAT_GUN',			'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_U_MONGOLIAN_KESHIK',		'GENGHIS_UNIT_ATLAS',		0,				'GENGHIS_UNIT_FLAG_ATLAS',		0,					'BIPED'			),

-- Heldeofol
('UNIT_SETTLERS_ORC',			NULL,						0,		0,		0,				0,		2,		NULL,						'DOMAIN_LAND',	'UNITAI_SETTLE',		0,			0,					0,					NULL,				0,			'ART_DEF_UNIT__SETTLER',				'UNIT_ATLAS_1',				0,				'UNIT_FLAG_ATLAS',				0,					'BIPED'			),
('UNIT_WORKERS_ORC',			NULL,						100,	0,		0,				0,		2,		NULL,						'DOMAIN_LAND',	'UNITAI_WORKER',		0,			0,					0,					NULL,				0,			'ART_DEF_UNIT__WORKER',					'UNIT_ATLAS_1',				1,				'UNIT_FLAG_ATLAS',				1,					'BIPED'			),
('UNIT_SLAVES_ORC',				NULL,						70,		0,		0,				0,		2,		NULL,						'DOMAIN_LAND',	'UNITAI_WORKER',		0,			0,					0,					NULL,				0,			'ART_DEF_UNIT__WORKER',					'UNIT_ATLAS_1',				1,				'UNIT_FLAG_ATLAS',				1,					'BIPED'			),

('UNIT_SCOUTS_GOBLIN',			'TECH_HUNTING',				80,		4,		0,				0,		2,		'UNITCOMBAT_RECON',			'DOMAIN_LAND',	'UNITAI_EXPLORE',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_GOBLIN_SCOUT',			'UNIT_ATLAS_1',				5,				'UNIT_FLAG_ATLAS',				5,					'BIPED'			),
('UNIT_TRACKERS_GOBLIN',		'TECH_TRACKING_TRAPPING',	160,	8,		0,				0,		2,		'UNITCOMBAT_RECON',			'DOMAIN_LAND',	'UNITAI_EXPLORE',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_GOBLIN_TRACKER',			'UNIT_ATLAS_1',				5,				'UNIT_FLAG_ATLAS',				5,					'BIPED'			),
('UNIT_RANGERS_GOBLIN',			'TECH_ANIMAL_MASTERY',		240,	12,		0,				0,		2,		'UNITCOMBAT_RECON',			'DOMAIN_LAND',	'UNITAI_EXPLORE',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_GOBLIN_TRACKER',			'UNIT_ATLAS_1',				5,				'UNIT_FLAG_ATLAS',				5,					'BIPED'			),

('UNIT_WARRIORS_ORC',			NULL,						120,	6,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_ORC_SPEARMAN',			'UNIT_ATLAS_1',				3,				'UNIT_FLAG_ATLAS',				3,					'BIPED'			),
('UNIT_LIGHT_INFANTRY_ORC',		'TECH_BRONZE_WORKING',		180,	9,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_SPEARMAN',				'UNIT_ATLAS_1',				9,				'UNIT_FLAG_ATLAS',				9,					'BIPED'			),
('UNIT_MEDIUM_INFANTRY_ORC',	'TECH_IRON_WORKING',		240,	12,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_SWORDSMAN',				'UNIT_ATLAS_1',				14,				'UNIT_FLAG_ATLAS',				14,					'HEAVY_BIPED'	),
('UNIT_HEAVY_INFANTRY_ORC',		'TECH_METAL_CASTING',		300,	15,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_U_ROMAN_LEGION',			'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'HEAVY_BIPED'	),
('UNIT_IMMORTALS_ORC',			'TECH_MITHRIL_WORKING',		420,	21,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_LONGSWORDSMAN',			'UNIT_ATLAS_1',				36,				'UNIT_FLAG_ATLAS',				35,					'BIPED'			),
--note: will remove horse units later
('UNIT_WOLF_RIDERS_GOBLIN',		'TECH_HORSEBACK_RIDING',	200,	9,		0,				0,		4,		'UNITCOMBAT_MOUNTED',		'DOMAIN_LAND',	'UNITAI_FAST_ATTACK',	1,			1,					1,					'TECH_WAR_HORSES',	0,			'ART_DEF_UNIT_GOBLIN_WOLF_RIDER',		'UNIT_ATLAS_1',				17,				'UNIT_FLAG_ATLAS',				17,					'QUADRUPED'		),
('UNIT_WARG_RIDERS_GOBLIN',		'TECH_STIRRUPS',			260,	12,		0,				0,		4,		'UNITCOMBAT_MOUNTED',		'DOMAIN_LAND',	'UNITAI_FAST_ATTACK',	1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_GOBLIN_WOLF_RIDER',		'UNIT_ATLAS_1',				17,				'UNIT_FLAG_ATLAS',				17,					'QUADRUPED'		),

('UNIT_ARCHERS_GOBLIN',			'TECH_ARCHERY',				180,	8,		8,				1,		2,		'UNITCOMBAT_ARCHER',		'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_GOBLIN_ARCHER',			'UNIT_ATLAS_1',				6,				'UNIT_FLAG_ATLAS',				6,					'BIPED'			),
('UNIT_BOWMEN_GOBLIN',			'TECH_BOWYERS',				260,	12,		12,				1,		2,		'UNITCOMBAT_ARCHER',		'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_GOBLIN_ARCHER',			'EXPANSION_UNIT_ATLAS_1',	13,				'EXPANSION_UNIT_FLAG_ATLAS',	13,					'BIPED'			),
('UNIT_MARKSMEN_GOBLIN',		'TECH_MARKSMANSHIP',		360,	17,		17,				1,		2,		'UNITCOMBAT_ARCHER',		'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_GOBLIN_ARCHER',			'EXPANSION_UNIT_ATLAS_1',	13,				'EXPANSION_UNIT_FLAG_ATLAS',	13,					'BIPED'			),
('UNIT_CROSSBOWMEN_GOBLIN',		'TECH_MECHANICS',			180,	8,		8,				1,		2,		'UNITCOMBAT_ARCHER',		'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_GOBLIN_CROSSBOWMAN',		'UNIT_ATLAS_1',				30,				'UNIT_FLAG_ATLAS',				29,					'BIPED'			),
('UNIT_ARQUEBUSSMEN_GOBLIN',	'TECH_MACHINERY',			320,	15,		15,				1,		2,		'UNITCOMBAT_ARCHER',		'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_GOBLIN_CROSSBOWMAN',		'UNIT_ATLAS_1',				38,				'UNIT_FLAG_ATLAS',				37,					'BIPED'			);

--Barb Only
INSERT INTO Units (Type,		Cost,	Combat,	RangedCombat,	Range,	Moves,	CombatClass,				Domain,			DefaultUnitAI,			Pillage,	MilitarySupport,	MilitaryProduction,	ObsoleteTech,		Mechanized,	UnitArtInfo,							IconAtlas,					PortraitIndex,	UnitFlagAtlas,					UnitFlagIconOffset,	MoveRate,		EaNoTrain	) VALUES
('UNIT_GALLEYS_PIRATES',		-1,		9,		0,				0,		3,		'UNITCOMBAT_NAVALMELEE',	'DOMAIN_SEA',	'UNITAI_ATTACK_SEA',	1,			1,					1,					NULL,				1,			'ART_DEF_UNIT_BARBARIAN_GALLEY',		'UNIT_ATLAS_1',				23,				'UNIT_FLAG_ATLAS',				23,					'WOODEN_BOAT',	1			),
('UNIT_WARRIORS_BARB',			-1,		7,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_BARBARIAN_EURO',			'UNIT_ATLAS_1',				25,				'UNIT_FLAG_ATLAS',				3,					'BIPED',		1			),
('UNIT_LIGHT_INFANTRY_BARB',	-1,		9,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_BARBARIAN_SPEARMAN',		'UNIT_ATLAS_1',				9,				'UNIT_FLAG_ATLAS',				9,					'BIPED',		1			),
('UNIT_MEDIUM_INFANTRY_BARB',	-1,		12,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_BARBARIAN_SWORDSMAN',		'UNIT_ATLAS_1',				14,				'UNIT_FLAG_ATLAS',				14,					'HEAVY_BIPED',	1			),
('UNIT_ARCHERS_BARB',			-1,		8,		8,				1,		2,		'UNITCOMBAT_ARCHER',		'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_BARBARIAN_ARCHER',		'UNIT_ATLAS_1',				6,				'UNIT_FLAG_ATLAS',				6,					'BIPED',		1			),
('UNIT_AXMAN_BARB',				-1,		8,		8,				1,		2,		'UNITCOMBAT_ARCHER',		'DOMAIN_LAND',	'UNITAI_RANGED',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_HAND_AXE_BARBARIAN',		'EXPANSION2_UNIT_ATLAS',	9,				'EXPANSION2_UNIT_FLAG_ATLAS',	9,					'BIPED',		1			),
('UNIT_WARRIORS_GOBLIN',		-1,		5,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_GOBLIN_WARRIOR',			'UNIT_ATLAS_1',				25,				'UNIT_FLAG_ATLAS',				3,					'BIPED',		1			),
('UNIT_NAGA_GREEN',				-1,		9,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_NAGA_GREEN',				'UNIT_ATLAS_1',				9,				'UNIT_FLAG_ATLAS',				9,					'BIPED',		1			),
('UNIT_NAGA_BLUE',				-1,		11,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_NAGA_BLUE',				'UNIT_ATLAS_1',				9,				'UNIT_FLAG_ATLAS',				9,					'BIPED',		1			),
('UNIT_OGRES',					-1,		15,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_STONESKIN_OGRE',			'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1			),
('UNIT_HOBGOBLINS',				-1,		12,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			1,					1,					NULL,				0,			'ART_DEF_UNIT_OGRE',					'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1			);

--Animals and Beasts
INSERT INTO Units (Type,		Cost,	Combat,	RangedCombat,	Range,	Moves,	CombatClass,				Domain,			DefaultUnitAI,			Pillage,	MilitarySupport,	MilitaryProduction,	ObsoleteTech,		Mechanized,	UnitArtInfo,							IconAtlas,					PortraitIndex,	UnitFlagAtlas,					UnitFlagIconOffset,	MoveRate,		EaNoTrain,	EaSpecial	) VALUES
('UNIT_WOLVES',					-1,		6,		0,				0,		4,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		0,			0,					1,					NULL,				0,			'ART_DEF_UNIT_WOLVES',					'UNIT_ATLAS_1',				4,				'UNIT_FLAG_ATLAS',				4,					'BIPED',		1,			'Animal'	),
('UNIT_LIONS',					-1,		9,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		0,			0,					1,					NULL,				0,			'ART_DEF_UNIT_LIONS',					'UNIT_ATLAS_1',				4,				'UNIT_FLAG_ATLAS',				4,					'BIPED',		1,			'Animal'	),
('UNIT_GRIFFONS',				-1,		8,		0,				0,		4,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		0,			0,					1,					NULL,				0,			'ART_DEF_UNIT_GRIFFONS',				'UNIT_ATLAS_1',				4,				'UNIT_FLAG_ATLAS',				4,					'BIPED',		1,			'Animal'	),
('UNIT_SCORPIONS_SAND',			-1,		8,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		0,			0,					1,					NULL,				0,			'ART_DEF_UNIT_SCORPIONS_SAND',			'UNIT_ATLAS_1',				4,				'UNIT_FLAG_ATLAS',				4,					'BIPED',		1,			'Animal'	),
('UNIT_SCORPIONS_BLACK',		-1,		8,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		0,			0,					1,					NULL,				0,			'ART_DEF_UNIT_SCORPIONS_BLACK',			'UNIT_ATLAS_1',				4,				'UNIT_FLAG_ATLAS',				4,					'BIPED',		1,			'Animal'	),
('UNIT_SCORPIONS_WHITE',		-1,		8,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		0,			0,					1,					NULL,				0,			'ART_DEF_UNIT_SCORPIONS_WHITE',			'UNIT_ATLAS_1',				4,				'UNIT_FLAG_ATLAS',				4,					'BIPED',		1,			'Animal'	),
('UNIT_KRAKEN',					-1,		15,		0,				0,		2,		'UNITCOMBAT_NAVALMELEE',	'DOMAIN_SEA',	'UNITAI_ATTACK',		0,			0,					1,					NULL,				0,			'ART_DEF_UNIT_KRAKEN',					'UNIT_ATLAS_1',				4,				'UNIT_FLAG_ATLAS',				4,					'BIPED',		1,			'Beast'		),
('UNIT_GIANT_SPIDER',			-1,		9,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		0,			0,					1,					NULL,				0,			'ART_DEF_UNIT_GIANT_SPIDER',			'UNIT_ATLAS_1',				4,				'UNIT_FLAG_ATLAS',				4,					'BIPED',		1,			'Beast'		),
('UNIT_DRAKE_GREEN',			-1,		11,		0,				0,		4,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		0,			0,					1,					NULL,				0,			'ART_DEF_UNIT_DRAKE_GREEN',				'UNIT_ATLAS_1',				4,				'UNIT_FLAG_ATLAS',				4,					'BIPED',		1,			'Beast'		),
('UNIT_DRAKE_BLUE',				-1,		13,		0,				0,		4,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		0,			0,					1,					NULL,				0,			'ART_DEF_UNIT_DRAKE_BLUE',				'UNIT_ATLAS_1',				4,				'UNIT_FLAG_ATLAS',				4,					'BIPED',		1,			'Beast'		),
('UNIT_DRAKE_RED',				-1,		15,		0,				0,		4,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		0,			0,					1,					NULL,				0,			'ART_DEF_UNIT_DRAKE_RED',				'UNIT_ATLAS_1',				4,				'UNIT_FLAG_ATLAS',				4,					'BIPED',		1,			'Beast'		);

--Summoned, called or raised
INSERT INTO Units (Type,		Cost,	Combat,	RangedCombat,	Range,	Moves,	CombatClass,				Domain,			DefaultUnitAI,			Pillage,	MilitarySupport,	MilitaryProduction,	ObsoleteTech,		Mechanized,	UnitArtInfo,							IconAtlas,					PortraitIndex,	UnitFlagAtlas,					UnitFlagIconOffset,	MoveRate,		EaNoTrain,	EaSpecial	) VALUES
('UNIT_TREE_ENT',				-1,		15,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_TREE_ENT',				'UNIT_ATLAS_1',				4,				'UNIT_FLAG_ATLAS',				4,					'BIPED',		1,			'Spirit'	),
('UNIT_SKELETON_SWORDSMEN',		-1,		6,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_SKELETON_SWORDSMAN',		'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Undead'	),
('UNIT_ZOMBIES',				-1,		9,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_ZOMBIE',					'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Undead'	),
('UNIT_HIVE_TYRANT',			-1,		15,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_HIVE_TYRANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Demon'		),
('UNIT_LICTOR',					-1,		12,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_LICTOR',					'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Demon'		),
('UNIT_HORMAGAUNT',				-1,		8,		0,				0,		3,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_HORMAGAUNT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Demon'		),
--('UNIT_CARNIFEX',				-1,		12,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_CARNIFEX',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Demon'		),
('UNIT_ANGEL_SPEARMAN',			-1,		12,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_ANGEL_SPEARMAN',			'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Angel'		),
('UNIT_ANGEL',					-1,		18,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_ANGEL',					'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Angel'		),

--Don't mess with these guys
('UNIT_ARCHDEMON_ZAURI',		-1,		23,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_GREAT_UNCLEAN_ONE',		'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archdemon'	),
('UNIT_ARCHDEMON_GANNAG_MENOG',	-1,		25,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_GREAT_UNCLEAN_ONE',		'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archdemon'	),
('UNIT_ARCHDEMON_AKA_MANAH',	-1,		27,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_GREAT_UNCLEAN_ONE',		'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archdemon'	),
('UNIT_ARCHDEMON_TAURVI',		-1,		29,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_GREAT_UNCLEAN_ONE',		'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archdemon'	),
('UNIT_ARCHDEMON_NAONGHAITHYA',	-1,		31,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_GREAT_UNCLEAN_ONE',		'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archdemon'	),
('UNIT_ARCHDEMON_INDAR',		-1,		33,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_GREAT_UNCLEAN_ONE',		'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archdemon'	),
('UNIT_ARCHDEMON_SAURVA',		-1,		35,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_GREAT_UNCLEAN_ONE',		'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archdemon'	),
('UNIT_ARCHDEMON_AESHMA',		-1,		37,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_GREAT_UNCLEAN_ONE',		'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archdemon'	),

('UNIT_ARCHANGEL_ZAM',			-1,		24,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_ARCHANGEL',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archangel'	),
('UNIT_ARCHANGEL_DRVASPA',		-1,		25,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_ARCHANGEL',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archangel'	),
('UNIT_ARCHANGEL_TISHTRYA',		-1,		27,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_ARCHANGEL',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archangel'	),
('UNIT_ARCHANGEL_ASHI',			-1,		29,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_ARCHANGEL',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archangel'	),
('UNIT_ARCHANGEL_ANAHITA',		-1,		31,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_ARCHANGEL',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archangel'	),
('UNIT_ARCHANGEL_TUSHNAMAITI',	-1,		32,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_ARCHANGEL',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archangel'	),
('UNIT_ARCHANGEL_IZA',			-1,		33,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_ARCHANGEL',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archangel'	),
('UNIT_ARCHANGEL_ATAR',			-1,		34,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_ARCHANGEL',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archangel'	),
('UNIT_ARCHANGEL_VERATHRAGNA',	-1,		35,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_ARCHANGEL',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archangel'	),
('UNIT_ARCHANGEL_RASHNU',		-1,		36,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_ARCHANGEL',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archangel'	),
('UNIT_ARCHANGEL_SRAOSHA',		-1,		38,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_ARCHANGEL',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archangel'	),
('UNIT_ARCHANGEL_MITHRA',		-1,		40,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_ARCHANGEL',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'Archangel'	),

('UNIT_GOD_FAGUS',				-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_ABELLIO',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_BUXENUS',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_ROBOR',				-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_ABNOAB',				-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_AVETA',				-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_CONDATIS',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_ABANDINUS',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_ADSULLATA',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_ICAUNUS',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_BELISAMA',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_CLOTA',				-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_SABRINA',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_SEQUANA',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_VERBEIA',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_BORVO',				-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_AEGIR',				-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_BARINTHUS',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_LIBAN',				-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_FIMAFENG',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_ELDIR',				-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_RITONA',				-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_ERECURA',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_VOSEGUS',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_NANTOSUELTA',		-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_DIS_PATER',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_NERGAL',				-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_WADD',				-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_ABGAL',				-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_NESR',				-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_EPONA',				-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_ATEPOMARUS',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_SABAZIOS',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_BAKKHOS',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_PAN',				-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit'),
('UNIT_GOD_SILENUS',			-1,		28,		0,				0,		2,		'UNITCOMBAT_MELEE',			'DOMAIN_LAND',	'UNITAI_ATTACK',		1,			0,					1,					NULL,				0,			'ART_DEF_UNIT_STORM_GIANT',				'UNIT_ATLAS_1',				15,				'UNIT_FLAG_ATLAS',				15,					'BIPED',		1,			'MajorSpirit');

--ART_DEF_UNIT_SKELETON_SWORDSMAN

--Utility (don't show anywhere)
INSERT INTO Units (Type,		PrereqTech,					Cost,	Combat,	RangedCombat,	NukeDamageLevel,	Range,	Moves,	Immobile,	NoMaintenance,	Special,				CombatClass,	Domain,			DefaultUnitAI,			Suicide,	MilitarySupport,	Mechanized,	AirUnitCap,	CombatLimit,	RangedCombatLimit,	UnitArtInfo,					IconAtlas,			PortraitIndex,	UnitFlagAtlas,		UnitFlagIconOffset,	MoveRate,		EaNoTrain,	EaSpecial	) VALUES
--All dummy air strike units should have Suicide = 1; use RangedCombat = 10 if it will be modified by mod (and not a nuke)
('UNIT_DUMMY_EXPLODER',			'TECH_NEVER',				-1,		0,		10,				-1,					10,		2,		1,			1,				'SPECIALUNIT_MISSILE',	NULL,			'DOMAIN_AIR',	'UNITAI_MISSILE_AIR',	1,			0,					1,			1,			0,				100,				'ART_DEF_UNIT_GUIDED_MISSILE',	'UNIT_ATLAS_2',		30,				'UNIT_FLAG_ATLAS',	77,					'AIR_REBASE',	1,			'Utility'	),
('UNIT_DUMMY_NUKE',				'TECH_NEVER',				-1,		0,		0,				2,					10,		2,		1,			1,				'SPECIALUNIT_MISSILE',	NULL,			'DOMAIN_AIR',	'UNITAI_ICBM',			1,			0,					1,			1,			0,				100,				'ART_DEF_UNIT_NUCLEAR_MISSILE',	'UNIT_ATLAS_2',		30,				'UNIT_FLAG_ATLAS',	77,					'AIR_REBASE',	1,			'Utility'	);
--IMPORTANT! Make sure these get PROMOTION_DUMMY_AIR_STRIKE in Unit_FreePromotions below

UPDATE Units SET IsWorker = 1 WHERE Type GLOB 'UNIT_WORKERS_*' OR Type GLOB 'UNIT_SLAVES_*';
UPDATE Units SET EaRace = 'EARACE_MAN', EaCityTrainRace = 'EARACE_MAN' WHERE Type GLOB '*_MAN' OR Type GLOB '*_BARB';
UPDATE Units SET EaRace = 'EARACE_SIDHE', EaCityTrainRace = 'EARACE_SIDHE' WHERE Type GLOB '*_SIDHE';
UPDATE Units SET EaRace = 'EARACE_ORC', EaCityTrainRace = 'EARACE_HELDEOFOL' WHERE Type GLOB '*_ORC';
UPDATE Units SET EaRace = 'EARACE_GOBLIN', EaCityTrainRace = 'EARACE_HELDEOFOL' WHERE Type GLOB '*_GOBLIN';
UPDATE Units SET EaLiving = 1 WHERE (Mechanized = 0 OR Type GLOB 'UNIT_CHARIOT*') AND (EaSpecial IS NULL OR EaSpecial IN ('Animal', 'Beast'));
UPDATE Units SET NoMaintenance = 1 WHERE Type GLOB 'UNIT_WARRIORS_*' OR Type GLOB 'UNIT_SCOUTS_*';
UPDATE Units SET CombatLimit = 0, Food = 1, Found = 1, CivilianAttackPriority = 'CIVILIAN_ATTACK_PRIORITY_HIGH_EARLY_GAME_ONLY' WHERE Type GLOB 'UNIT_SETTLERS_*';
UPDATE Units SET CombatLimit = 0, WorkRate = 100, CivilianAttackPriority = 'CIVILIAN_ATTACK_PRIORITY_LOW' WHERE Type GLOB 'UNIT_WORKERS_*';
UPDATE Units SET CombatLimit = 0, WorkRate = 70, CivilianAttackPriority = 'CIVILIAN_ATTACK_PRIORITY_LOW', NoMaintenance=1 WHERE Type GLOB 'UNIT_SLAVES_*';
UPDATE Units SET CombatLimit = 0, Immobile = 1 WHERE Type IN ('UNIT_FISHING_BOATS','UNIT_WHALING_BOATS','UNIT_HUNTERS');
--UPDATE Units SET CombatLimit = 0, Immobile = 1, Trade = 1, NoMaintenance = 1, CivilianAttackPriority = 'CIVILIAN_ATTACK_PRIORITY_LOW' WHERE Type IN ('UNIT_CARAVAN','UNITCLASS_CARGO_SHIP');
UPDATE Units SET Capture = 'UNITCLASS_SLAVES_MAN' WHERE Type IN ('UNIT_SETTLERS_MAN','UNIT_WORKERS_MAN','UNIT_SLAVES_MAN'); 
UPDATE Units SET Capture = 'UNITCLASS_SLAVES_SIDHE' WHERE Type IN ('UNIT_SETTLERS_SIDHE','UNIT_WORKERS_SIDHE','UNIT_SLAVES_SIDHE');
UPDATE Units SET Capture = 'UNITCLASS_SLAVES_ORC' WHERE Type IN ('UNIT_SETTLERS_ORC','UNIT_WORKERS_ORC','UNIT_SLAVES_ORC');
UPDATE Units SET XPValueAttack=3, XPValueDefense=3;
UPDATE Units SET MinAreaSize=20 WHERE CombatClass = 'UNITCOMBAT_NAVAL';
UPDATE Units SET PrereqTech = 'TECH_CURRENCY' WHERE Type = 'UNIT_CARAVAN';
UPDATE Units SET PrereqTech = 'TECH_SAILING' WHERE Type = 'UNIT_CARGO_SHIP';

--BALANCE
UPDATE Units SET Cost = Cost / 2 WHERE Cost != -1;


-- specific adds: NoBadGoodies, GoodyHutUpgradeUnitClass

----------------------------------------------------------------------------------------
-- People
----------------------------------------------------------------------------------------

INSERT INTO Units (Type, UnitArtInfo,				IconAtlas,					PortraitIndex,	UnitFlagAtlas,			UnitFlagIconOffset,	Special) VALUES
('UNIT_ENGINEER',		'ART_DEF_UNIT_EA_ENGINEER',	'UNIT_ATLAS_2',				47,				'UNIT_FLAG_ATLAS',		89,					'SPECIALUNIT_PEOPLE'	),
('UNIT_MERCHANT',		'ART_DEF_UNIT_EA_MERCHANT',	'UNIT_ATLAS_2',				46,				'UNIT_FLAG_ATLAS',		92,					'SPECIALUNIT_PEOPLE'	),
('UNIT_SAGE',			'ART_DEF_UNIT_EA_SAGE',		'UNIT_ATLAS_2',				45,				'EA_FLAG_ATLAS',		0,					'SPECIALUNIT_PEOPLE'	),
('UNIT_ALCHEMIST',		'ART_DEF_UNIT_EA_SAGE',		'UNIT_ATLAS_2',				45,				'UNIT_FLAG_ATLAS',		91,					'SPECIALUNIT_PEOPLE'	),
('UNIT_ARTIST',			'ART_DEF_UNIT_EA_ARTIST',	'UNIT_ATLAS_2',				44,				'UNIT_FLAG_ATLAS',		88,					'SPECIALUNIT_PEOPLE'	),
('UNIT_WARRIOR',		'ART_DEF_UNIT_EA_WARRIOR',	'UNIT_ATLAS_2',				48,				'UNIT_FLAG_ATLAS',		90,					'SPECIALUNIT_PEOPLE'	),
('UNIT_BERSERKER',		'ART_DEF_UNIT_EA_WARRIOR',	'UNIT_ATLAS_2',				48,				'UNIT_FLAG_ATLAS',		90,					'SPECIALUNIT_PEOPLE'	),
('UNIT_PRIEST',			'ART_DEF_UNIT_EA_PRIEST',	'EXPANSION_UNIT_ATLAS_1',	20,				'EA_FLAG_ATLAS',		3,					'SPECIALUNIT_PEOPLE'	),
('UNIT_FALLENPRIEST',	'ART_DEF_UNIT_EA_PRIEST',	'EXPANSION_UNIT_ATLAS_1',	20,				'EA_FLAG_ATLAS',		3,					'SPECIALUNIT_PEOPLE'	),
('UNIT_PALADIN',		'ART_DEF_UNIT_EA_PALADIN',	'UNIT_ATLAS_2',				48,				'UNIT_FLAG_ATLAS',		90,					'SPECIALUNIT_PEOPLE'	),
('UNIT_EIDOLON',		'ART_DEF_UNIT_EA_PALADIN',	'UNIT_ATLAS_2',				48,				'EA_FLAG_ATLAS',		6,					'SPECIALUNIT_PEOPLE'	),
('UNIT_DRUID',			'ART_DEF_UNIT_EA_DRUID',	'EXPANSION_UNIT_ATLAS_1',	17,				'EA_FLAG_ATLAS',		2,					'SPECIALUNIT_PEOPLE'	),
('UNIT_WITCH',			'ART_DEF_UNIT_INQUISITOR',	'EXPANSION_UNIT_ATLAS_1',	17,				'EA_FLAG_ATLAS',		1,					'SPECIALUNIT_PEOPLE'	),
('UNIT_WIZARD',			'ART_DEF_UNIT_INQUISITOR',	'EXPANSION_UNIT_ATLAS_1',	17,				'EA_FLAG_ATLAS',		5,					'SPECIALUNIT_PEOPLE'	),
('UNIT_SORCERER',		'ART_DEF_UNIT_INQUISITOR',	'EXPANSION_UNIT_ATLAS_1',	17,				'EA_FLAG_ATLAS',		8,					'SPECIALUNIT_PEOPLE'	),
('UNIT_NECROMANCER',	'ART_DEF_UNIT_INQUISITOR',	'EXPANSION_UNIT_ATLAS_1',	17,				'EA_FLAG_ATLAS',		8,					'SPECIALUNIT_PEOPLE'	),
('UNIT_LICH',			'ART_DEF_UNIT_INQUISITOR',	'EXPANSION_UNIT_ATLAS_1',	17,				'EA_FLAG_ATLAS',		8,					'SPECIALUNIT_PEOPLE'	);

UPDATE Units SET Cost = -1, AdvancedStartCost = -1, Domain = 'DOMAIN_LAND', Moves = 2, MoveRate = 'GREAT_PERSON', WorkRate = 100, Combat = 5, CombatLimit = 100, CombatClass = 'UNITCOMBAT_MELEE', RivalTerritory = 1, NoMaintenance = 1, XPValueAttack = 3, XPValueDefense = 3 WHERE Special = 'SPECIALUNIT_PEOPLE';

----------------------------------------------------------------------------------------
-- People temp type units
----------------------------------------------------------------------------------------

INSERT INTO Units (Type,		Description,			EaGPTempRole,	Combat,	RangedCombat,	Range,	Moves,	Immobile,	CombatClass,			DefaultUnitAI,			UnitArtInfo,							IconAtlas,					PortraitIndex,	UnitFlagIconOffset,	Special					) VALUES
('UNIT_DRUID_MAGIC_MISSLE',		'TXT_KEY_UNIT_DRUID',	'MagicMissle',	5,		10,				2,		2,		1,			'UNITCOMBAT_ARCHER',	'UNITAI_RANGED',		'ART_DEF_UNIT_EA_DRUID_MAGIC_MISSLE',	'EXPANSION_UNIT_ATLAS_1',	17,				17,					'SPECIALUNIT_PEOPLE'	),
('UNIT_PRIEST_MAGIC_MISSLE',	'TXT_KEY_UNIT_DRUID',	'MagicMissle',	5,		10,				2,		2,		1,			'UNITCOMBAT_ARCHER',	'UNITAI_RANGED',		'ART_DEF_UNIT_EA_PRIEST_MAGIC_MISSLE',	'EXPANSION_UNIT_ATLAS_1',	20,				20,					'SPECIALUNIT_PEOPLE'	);

UPDATE Units SET Cost = -1, AdvancedStartCost = -1, Domain = 'DOMAIN_LAND', Moves = 2, MoveRate = 'GREAT_PERSON', CombatLimit = 100, RivalTerritory = 1, NoMaintenance = 1, XPValueAttack = 3, XPValueDefense = 3 WHERE EaGPTempRole IS NOT NULL;


--Build out the Units table for dependent strings

UPDATE Units SET Description = 'TXT_KEY_EA_ARCHANGEL_' || REPLACE(Type, 'UNIT_', '') WHERE EaSpecial = 'Archangel';
UPDATE Units SET Description = 'TXT_KEY_EA_ARCHDEMON_' || REPLACE(Type, 'UNIT_', '') WHERE EaSpecial = 'Archdemon';
UPDATE Units SET Description = 'TXT_KEY_EA_GOD_' || REPLACE(Type, 'UNIT_', '') WHERE EaSpecial = 'MajorSpirit';
UPDATE Units SET Description = 'TXT_KEY_EA_' || Type WHERE Description IS NULL;
UPDATE Units SET Description = REPLACE(Description, '_MAN', '');
UPDATE Units SET Description = REPLACE(Description, '_SIDHE', '');
UPDATE Units SET Description = REPLACE(Description, '_ORC', '');
UPDATE Units SET Description = REPLACE(Description, '_GOBLIN', '');
UPDATE Units SET Civilopedia = Description || '_PEDIA', Strategy = Description || '_STRATEGY', Help = Description || '_HELP';



CREATE TABLE Unit_EaGPTempTypes (UnitType, TempUnitType);
INSERT INTO Unit_EaGPTempTypes (UnitType, TempUnitType) VALUES
('UNIT_DRUID', 'UNIT_DRUID_MAGIC_MISSLE'),		--Lua will fallback to something if no match here
('UNIT_FALLENPRIEST', 'UNIT_PRIEST_MAGIC_MISSLE');


----------------------------------------------------------------------------------------
--Build out the Units table for dependent strings
UPDATE Units SET Class = REPLACE(Type, 'UNIT_', 'UNITCLASS_');

--fixinator
CREATE TABLE IDRemapper ( id INTEGER PRIMARY KEY AUTOINCREMENT, Type TEXT );
INSERT INTO IDRemapper (Type) SELECT Type FROM Units ORDER BY ID;
UPDATE Units SET ID =	( SELECT IDRemapper.id-1 FROM IDRemapper WHERE Units.Type = IDRemapper.Type);
DROP TABLE IDRemapper;

----------------------------------------------------------------------------------------
-- UnitClasses (this is soooooo much easier...)
----------------------------------------------------------------------------------------

DELETE FROM UnitClasses;
INSERT INTO UnitClasses (Type, Description, DefaultUnit) SELECT Class, Description, Type FROM Units;

--fixinator
CREATE TABLE IDRemapper ( id INTEGER PRIMARY KEY AUTOINCREMENT, Type TEXT );
INSERT INTO IDRemapper (Type) SELECT Type FROM UnitClasses ORDER BY ID;
UPDATE UnitClasses SET ID =	( SELECT IDRemapper.id-1 FROM IDRemapper WHERE UnitClasses.Type = IDRemapper.Type);
DROP TABLE IDRemapper;

----------------------------------------------------------------------------------------
-- Unit subtables
----------------------------------------------------------------------------------------

DELETE FROM Unit_Buildings;
DELETE FROM Unit_ProductionModifierBuildings;
DELETE FROM Unit_GreatPersons;
DELETE FROM Unit_UniqueNames;
DELETE FROM Unit_YieldFromKills;
DELETE FROM Unit_NotAITypes;
DELETE FROM Unit_ProductionTraits;

DELETE FROM Unit_ClassUpgrades;
INSERT INTO Unit_ClassUpgrades (UnitType, UnitClassType) VALUES	--alter dll to allow alternate upgrade paths?

('UNIT_BIREMES', 'UNITCLASS_TRIREMES'),
('UNIT_TRIREMES', 'UNITCLASS_QUINQUEREMES'),

('UNIT_DROMONS', 'UNITCLASS_CARRACKS'),
('UNIT_CARRACKS', 'UNITCLASS_GALLEONS'),
('UNIT_BALLISTAE', 'UNITCLASS_TREBUCHETS'),
('UNIT_CATAPULTS', 'UNITCLASS_TREBUCHETS'),
('UNIT_TREBUCHETS', 'UNITCLASS_BOMBARDS'),
('UNIT_FIRE_CATAPULTS', 'UNITCLASS_FIRE_TREBUCHETS'),
('UNIT_FIRE_TREBUCHETS', 'UNITCLASS_BOMBARDS'),
('UNIT_MOUNTED_ELEPHANTS', 'UNITCLASS_WAR_ELEPHANTS'),
('UNIT_WAR_ELEPHANTS', 'UNITCLASS_MUMAKIL'),

('UNIT_SCOUTS_MAN', 'UNITCLASS_TRACKERS_MAN'),
('UNIT_TRACKERS_MAN', 'UNITCLASS_RANGERS_MAN'),
('UNIT_WARRIORS_MAN', 'UNITCLASS_LIGHT_INFANTRY_MAN'),
('UNIT_LIGHT_INFANTRY_MAN', 'UNITCLASS_MEDIUM_INFANTRY_MAN'),
('UNIT_MEDIUM_INFANTRY_MAN', 'UNITCLASS_HEAVY_INFANTRY_MAN'),
('UNIT_HEAVY_INFANTRY_MAN', 'UNITCLASS_IMMORTALS_MAN'),
('UNIT_CHARIOTS_MAN', 'UNITCLASS_HORSEMEN_MAN'),
('UNIT_HORSEMEN_MAN', 'UNITCLASS_EQUITES_MAN'),
('UNIT_EQUITES_MAN', 'UNITCLASS_CATAPHRACTS_MAN'),
('UNIT_ARMORED_CAVALRY_MAN', 'UNITCLASS_CATAPHRACTS_MAN'),
('UNIT_CATAPHRACTS_MAN', 'UNITCLASS_CLIBANARII_MAN'),
('UNIT_ARCHERS_MAN', 'UNITCLASS_BOWMEN_MAN'),
('UNIT_BOWMEN_MAN', 'UNITCLASS_MARKSMEN_MAN'),
('UNIT_CHARIOT_ARCHERS_MAN', 'UNITCLASS_HORSE_ARCHERS_MAN'),
('UNIT_HORSE_ARCHERS_MAN', 'UNITCLASS_BOWED_CAVALRY_MAN'),
('UNIT_BOWED_CAVALRY_MAN', 'UNITCLASS_SAGITARII_MAN'),

('UNIT_SCOUTS_SIDHE', 'UNITCLASS_TRACKERS_SIDHE'),
('UNIT_TRACKERS_SIDHE', 'UNITCLASS_RANGERS_SIDHE'),
('UNIT_WARRIORS_SIDHE', 'UNITCLASS_LIGHT_INFANTRY_SIDHE'),
('UNIT_LIGHT_INFANTRY_SIDHE', 'UNITCLASS_MEDIUM_INFANTRY_SIDHE'),
('UNIT_MEDIUM_INFANTRY_SIDHE', 'UNITCLASS_HEAVY_INFANTRY_SIDHE'),
('UNIT_HEAVY_INFANTRY_SIDHE', 'UNITCLASS_IMMORTALS_SIDHE'),
('UNIT_CHARIOTS_SIDHE', 'UNITCLASS_HORSEMEN_SIDHE'),
('UNIT_HORSEMEN_SIDHE', 'UNITCLASS_EQUITES_SIDHE'),
('UNIT_EQUITES_SIDHE', 'UNITCLASS_CATAPHRACTS_SIDHE'),
('UNIT_ARMORED_CAVALRY_SIDHE', 'UNITCLASS_CATAPHRACTS_SIDHE'),
('UNIT_CATAPHRACTS_SIDHE', 'UNITCLASS_CLIBANARII_SIDHE'),
('UNIT_ARCHERS_SIDHE', 'UNITCLASS_BOWMEN_SIDHE'),
('UNIT_BOWMEN_SIDHE', 'UNITCLASS_MARKSMEN_SIDHE'),
('UNIT_CHARIOT_ARCHERS_SIDHE', 'UNITCLASS_HORSE_ARCHERS_SIDHE'),
('UNIT_HORSE_ARCHERS_SIDHE', 'UNITCLASS_BOWED_CAVALRY_SIDHE'),
('UNIT_BOWED_CAVALRY_SIDHE', 'UNITCLASS_SAGITARII_SIDHE'),

('UNIT_SCOUTS_GOBLIN', 'UNITCLASS_TRACKERS_GOBLIN'),
('UNIT_TRACKERS_GOBLIN', 'UNITCLASS_RANGERS_GOBLIN'),
('UNIT_WARRIORS_ORC', 'UNITCLASS_LIGHT_INFANTRY_ORC'),
('UNIT_LIGHT_INFANTRY_ORC', 'UNITCLASS_MEDIUM_INFANTRY_ORC'),
('UNIT_MEDIUM_INFANTRY_ORC', 'UNITCLASS_HEAVY_INFANTRY_ORC'),
('UNIT_HEAVY_INFANTRY_ORC', 'UNITCLASS_IMMORTALS_ORC'),
('UNIT_WOLF_RIDERS_GOBLIN', 'UNITCLASS_WARG_RIDER_GOBLIN'),
('UNIT_ARCHERS_GOBLIN', 'UNITCLASS_BOWMEN_GOBLIN'),
('UNIT_BOWMEN_GOBLIN', 'UNITCLASS_MARKSMEN_GOBLIN');

DELETE FROM Unit_AITypes;
INSERT INTO Unit_AITypes (UnitType, UnitAIType)		--Automated to stop errors
SELECT Type, DefaultUnitAI FROM Units WHERE DefaultUnitAI IN ('UNITAI_SETTLE', 'UNITAI_WORKER', 'UNITAI_WORKER_SEA') UNION ALL
SELECT Type, 'UNITAI_CITY_BOMBARD' FROM Units WHERE CombatClass = 'UNITCOMBAT_SIEGE' UNION ALL
SELECT Type, 'UNITAI_RANGED' FROM Units WHERE CombatClass = 'UNITCOMBAT_SIEGE' UNION ALL
SELECT Type, 'UNITAI_EXPLORE' FROM Units WHERE CombatClass = 'UNITCOMBAT_RECON' UNION ALL
SELECT Type, 'UNITAI_ATTACK' FROM Units WHERE CombatClass = 'UNITCOMBAT_RECON' AND Combat > 6 UNION ALL		--Trackers, Rangers can attack
SELECT Type, 'UNITAI_DEFENSE' FROM Units WHERE CombatClass = 'UNITCOMBAT_RECON' AND Combat > 6 UNION ALL	--Trackers, Rangers can defend
SELECT Type, 'UNITAI_ATTACK' FROM Units WHERE CombatClass = 'UNITCOMBAT_MELEE' UNION ALL
SELECT Type, 'UNITAI_DEFENSE' FROM Units WHERE CombatClass = 'UNITCOMBAT_MELEE' UNION ALL
SELECT Type, 'UNITAI_EXPLORE' FROM Units WHERE CombatClass = 'UNITCOMBAT_MELEE' AND Combat < 7 UNION ALL	--Warriors can explore
SELECT Type, 'UNITAI_RANGED' FROM Units WHERE CombatClass = 'UNITCOMBAT_ARCHER' UNION ALL
SELECT Type, 'UNITAI_FAST_ATTACK' FROM Units WHERE CombatClass = 'UNITCOMBAT_MOUNTED' UNION ALL
SELECT Type, 'UNITAI_DEFENSE' FROM Units WHERE CombatClass = 'UNITCOMBAT_MOUNTED' UNION ALL
SELECT Type, 'UNITAI_FAST_ATTACK' FROM Units WHERE CombatClass = 'UNITCOMBAT_GUN' UNION ALL					--Horse-mounted archers
SELECT Type, 'UNITAI_RANGED' FROM Units WHERE CombatClass = 'UNITCOMBAT_GUN' UNION ALL						--Horse-mounted archers
SELECT Type, 'UNITAI_ATTACK' FROM Units WHERE CombatClass = 'UNITCOMBAT_ARMOR' UNION ALL					--Elephants
SELECT Type, 'UNITAI_DEFENSE' FROM Units WHERE CombatClass = 'UNITCOMBAT_ARMOR' UNION ALL					--Elephants
SELECT Type, 'UNITAI_ATTACK_SEA' FROM Units WHERE CombatClass = 'UNITCOMBAT_NAVALMELEE' UNION ALL
SELECT Type, 'UNITAI_RESERVE_SEA' FROM Units WHERE CombatClass = 'UNITCOMBAT_NAVALMELEE' AND EaSpecial != 'Beast' UNION ALL
SELECT Type, 'UNITAI_ESCORT_SEA' FROM Units WHERE CombatClass = 'UNITCOMBAT_NAVALMELEE' AND EaSpecial != 'Beast' UNION ALL
SELECT Type, 'UNITAI_EXPLORE_SEA' FROM Units WHERE CombatClass = 'UNITCOMBAT_NAVALMELEE' AND EaSpecial != 'Beast' UNION ALL
SELECT Type, 'UNITAI_ATTACK_SEA' FROM Units WHERE CombatClass = 'UNITCOMBAT_NAVALRANGED' UNION ALL
SELECT Type, 'UNITAI_RESERVE_SEA' FROM Units WHERE CombatClass = 'UNITCOMBAT_NAVALRANGED' UNION ALL
SELECT Type, 'UNITAI_ESCORT_SEA' FROM Units WHERE CombatClass = 'UNITCOMBAT_NAVALRANGED' UNION ALL
SELECT Type, 'UNITAI_EXPLORE_SEA' FROM Units WHERE CombatClass = 'UNITCOMBAT_NAVALRANGED' ;


DELETE FROM Unit_BuildingClassRequireds;
INSERT INTO Unit_BuildingClassRequireds (UnitType, BuildingClassType)
SELECT Type, 'BUILDINGCLASS_MAN' FROM Units WHERE Type GLOB '*_MAN' UNION ALL
SELECT Type, 'BUILDINGCLASS_SIDHE' FROM Units WHERE Type GLOB '*_SIDHE' UNION ALL
SELECT Type, 'BUILDINGCLASS_HELDEOFOL' FROM Units WHERE Type GLOB '*_ORC' ;


DELETE FROM Unit_Builds;	
INSERT INTO Unit_Builds (UnitType, BuildType) VALUES	--see Builds in UnitBuilds.sql

--debug testing
--('UNIT_WORKERS_MAN', 'BUILD_PYRAMID'),
--('UNIT_WORKERS_MAN', 'BUILD_STONEHENGE'),

('UNIT_WORKERS_MAN', 'BUILD_ROAD'),
('UNIT_WORKERS_MAN', 'BUILD_RAILROAD'),
('UNIT_WORKERS_MAN', 'BUILD_LUMBERMILL'),
('UNIT_WORKERS_MAN', 'BUILD_BOWYERS_CAMP'),
('UNIT_WORKERS_MAN', 'BUILD_GATHERERS_HUT'),
('UNIT_WORKERS_MAN', 'BUILD_REPAIR'),
('UNIT_WORKERS_MAN', 'BUILD_REMOVE_ROUTE'),
('UNIT_WORKERS_MAN', 'BUILD_FARM'),
('UNIT_WORKERS_MAN', 'BUILD_MINE'),
('UNIT_WORKERS_MAN', 'BUILD_PASTURE'),
('UNIT_WORKERS_MAN', 'BUILD_E_PLANTATION'),
('UNIT_WORKERS_MAN', 'BUILD_T_PLANTATION'),
('UNIT_WORKERS_MAN', 'BUILD_VINEYARD'),
('UNIT_WORKERS_MAN', 'BUILD_ORCHARD'),
('UNIT_WORKERS_MAN', 'BUILD_QUARRY'),
('UNIT_WORKERS_MAN', 'BUILD_LUMBERMILL_2'),
('UNIT_WORKERS_MAN', 'BUILD_FARM_2'),
('UNIT_WORKERS_MAN', 'BUILD_MINE_2'),
('UNIT_WORKERS_MAN', 'BUILD_SLASH_BURN_FOREST'),
('UNIT_WORKERS_MAN', 'BUILD_SLASH_BURN_JUNGLE'),
('UNIT_WORKERS_MAN', 'BUILD_CHOP_FOREST'),
('UNIT_WORKERS_MAN', 'BUILD_CHOP_JUNGLE'),
('UNIT_WORKERS_MAN', 'BUILD_REMOVE_MARSH'),
('UNIT_WORKERS_MAN', 'BUILD_FARM_PAN'),
('UNIT_WORKERS_MAN', 'BUILD_MINE_PAN'),
('UNIT_WORKERS_MAN', 'BUILD_PASTURE_PAN'),
('UNIT_WORKERS_MAN', 'BUILD_E_PLANTATION_PAN'),
('UNIT_WORKERS_MAN', 'BUILD_T_PLANTATION_PAN'),
('UNIT_WORKERS_MAN', 'BUILD_VINEYARD_PAN'),
('UNIT_WORKERS_MAN', 'BUILD_ORCHARD_PAN'),
('UNIT_WORKERS_MAN', 'BUILD_QUARRY_PAN'),
('UNIT_SLAVES_MAN', 'BUILD_ROAD'),
('UNIT_SLAVES_MAN', 'BUILD_RAILROAD'),
('UNIT_SLAVES_MAN', 'BUILD_LUMBERMILL'),
('UNIT_SLAVES_MAN', 'BUILD_BOWYERS_CAMP'),
('UNIT_SLAVES_MAN', 'BUILD_GATHERERS_HUT'),
('UNIT_SLAVES_MAN', 'BUILD_REPAIR'),
('UNIT_SLAVES_MAN', 'BUILD_REMOVE_ROUTE'),
('UNIT_SLAVES_MAN', 'BUILD_FARM'),
('UNIT_SLAVES_MAN', 'BUILD_MINE'),
('UNIT_SLAVES_MAN', 'BUILD_PASTURE'),
('UNIT_SLAVES_MAN', 'BUILD_E_PLANTATION'),
('UNIT_SLAVES_MAN', 'BUILD_T_PLANTATION'),
('UNIT_SLAVES_MAN', 'BUILD_VINEYARD'),
('UNIT_SLAVES_MAN', 'BUILD_ORCHARD'),
('UNIT_SLAVES_MAN', 'BUILD_QUARRY'),
('UNIT_SLAVES_MAN', 'BUILD_LUMBERMILL_2'),
('UNIT_SLAVES_MAN', 'BUILD_FARM_2'),
('UNIT_SLAVES_MAN', 'BUILD_MINE_2'),
('UNIT_SLAVES_MAN', 'BUILD_SLASH_BURN_FOREST'),
('UNIT_SLAVES_MAN', 'BUILD_SLASH_BURN_JUNGLE'),
('UNIT_SLAVES_MAN', 'BUILD_CHOP_FOREST'),
('UNIT_SLAVES_MAN', 'BUILD_CHOP_JUNGLE'),
('UNIT_SLAVES_MAN', 'BUILD_REMOVE_MARSH'),
('UNIT_SLAVES_MAN', 'BUILD_FARM_PAN'),
('UNIT_SLAVES_MAN', 'BUILD_MINE_PAN'),
('UNIT_SLAVES_MAN', 'BUILD_PASTURE_PAN'),
('UNIT_SLAVES_MAN', 'BUILD_E_PLANTATION_PAN'),
('UNIT_SLAVES_MAN', 'BUILD_T_PLANTATION_PAN'),
('UNIT_SLAVES_MAN', 'BUILD_VINEYARD_PAN'),
('UNIT_SLAVES_MAN', 'BUILD_ORCHARD_PAN'),
('UNIT_SLAVES_MAN', 'BUILD_QUARRY_PAN'),

('UNIT_WORKERS_SIDHE', 'BUILD_ROAD'),
('UNIT_WORKERS_SIDHE', 'BUILD_RAILROAD'),
('UNIT_WORKERS_SIDHE', 'BUILD_LUMBERMILL'),
('UNIT_WORKERS_SIDHE', 'BUILD_BOWYERS_CAMP'),
('UNIT_WORKERS_SIDHE', 'BUILD_GATHERERS_HUT'),
('UNIT_WORKERS_SIDHE', 'BUILD_REPAIR'),
('UNIT_WORKERS_SIDHE', 'BUILD_REMOVE_ROUTE'),
('UNIT_WORKERS_SIDHE', 'BUILD_FARM'),
('UNIT_WORKERS_SIDHE', 'BUILD_MINE'),
('UNIT_WORKERS_SIDHE', 'BUILD_PASTURE'),
('UNIT_WORKERS_SIDHE', 'BUILD_E_PLANTATION'),
('UNIT_WORKERS_SIDHE', 'BUILD_T_PLANTATION'),
('UNIT_WORKERS_SIDHE', 'BUILD_VINEYARD'),
('UNIT_WORKERS_SIDHE', 'BUILD_ORCHARD'),
('UNIT_WORKERS_SIDHE', 'BUILD_QUARRY'),
('UNIT_WORKERS_SIDHE', 'BUILD_LUMBERMILL_2'),
('UNIT_WORKERS_SIDHE', 'BUILD_FARM_2'),
('UNIT_WORKERS_SIDHE', 'BUILD_MINE_2'),
('UNIT_WORKERS_SIDHE', 'BUILD_SLASH_BURN_FOREST'),
('UNIT_WORKERS_SIDHE', 'BUILD_SLASH_BURN_JUNGLE'),
('UNIT_WORKERS_SIDHE', 'BUILD_CHOP_FOREST'),
('UNIT_WORKERS_SIDHE', 'BUILD_CHOP_JUNGLE'),
('UNIT_WORKERS_SIDHE', 'BUILD_REMOVE_MARSH'),
('UNIT_WORKERS_SIDHE', 'BUILD_FARM_PAN'),
('UNIT_WORKERS_SIDHE', 'BUILD_MINE_PAN'),
('UNIT_WORKERS_SIDHE', 'BUILD_PASTURE_PAN'),
('UNIT_WORKERS_SIDHE', 'BUILD_E_PLANTATION_PAN'),
('UNIT_WORKERS_SIDHE', 'BUILD_T_PLANTATION_PAN'),
('UNIT_WORKERS_SIDHE', 'BUILD_VINEYARD_PAN'),
('UNIT_WORKERS_SIDHE', 'BUILD_ORCHARD_PAN'),
('UNIT_WORKERS_SIDHE', 'BUILD_QUARRY_PAN'),
('UNIT_SLAVES_SIDHE', 'BUILD_ROAD'),
('UNIT_SLAVES_SIDHE', 'BUILD_RAILROAD'),
('UNIT_SLAVES_SIDHE', 'BUILD_LUMBERMILL'),
('UNIT_SLAVES_SIDHE', 'BUILD_BOWYERS_CAMP'),
('UNIT_SLAVES_SIDHE', 'BUILD_GATHERERS_HUT'),
('UNIT_SLAVES_SIDHE', 'BUILD_REPAIR'),
('UNIT_SLAVES_SIDHE', 'BUILD_REMOVE_ROUTE'),
('UNIT_SLAVES_SIDHE', 'BUILD_FARM'),
('UNIT_SLAVES_SIDHE', 'BUILD_MINE'),
('UNIT_SLAVES_SIDHE', 'BUILD_PASTURE'),
('UNIT_SLAVES_SIDHE', 'BUILD_E_PLANTATION'),
('UNIT_SLAVES_SIDHE', 'BUILD_T_PLANTATION'),
('UNIT_SLAVES_SIDHE', 'BUILD_VINEYARD'),
('UNIT_SLAVES_SIDHE', 'BUILD_ORCHARD'),
('UNIT_SLAVES_SIDHE', 'BUILD_QUARRY'),
('UNIT_SLAVES_SIDHE', 'BUILD_LUMBERMILL_2'),
('UNIT_SLAVES_SIDHE', 'BUILD_FARM_2'),
('UNIT_SLAVES_SIDHE', 'BUILD_MINE_2'),
('UNIT_SLAVES_SIDHE', 'BUILD_SLASH_BURN_FOREST'),
('UNIT_SLAVES_SIDHE', 'BUILD_SLASH_BURN_JUNGLE'),
('UNIT_SLAVES_SIDHE', 'BUILD_CHOP_FOREST'),
('UNIT_SLAVES_SIDHE', 'BUILD_CHOP_JUNGLE'),
('UNIT_SLAVES_SIDHE', 'BUILD_REMOVE_MARSH'),
('UNIT_SLAVES_SIDHE', 'BUILD_FARM_PAN'),
('UNIT_SLAVES_SIDHE', 'BUILD_MINE_PAN'),
('UNIT_SLAVES_SIDHE', 'BUILD_PASTURE_PAN'),
('UNIT_SLAVES_SIDHE', 'BUILD_E_PLANTATION_PAN'),
('UNIT_SLAVES_SIDHE', 'BUILD_T_PLANTATION_PAN'),
('UNIT_SLAVES_SIDHE', 'BUILD_VINEYARD_PAN'),
('UNIT_SLAVES_SIDHE', 'BUILD_ORCHARD_PAN'),
('UNIT_SLAVES_SIDHE', 'BUILD_QUARRY_PAN'),

('UNIT_WORKERS_ORC', 'BUILD_ROAD'),
('UNIT_WORKERS_ORC', 'BUILD_RAILROAD'),
('UNIT_WORKERS_ORC', 'BUILD_LUMBERMILL'),
('UNIT_WORKERS_ORC', 'BUILD_BOWYERS_CAMP'),
('UNIT_WORKERS_ORC', 'BUILD_GATHERERS_HUT'),
('UNIT_WORKERS_ORC', 'BUILD_REPAIR'),
('UNIT_WORKERS_ORC', 'BUILD_REMOVE_ROUTE'),
('UNIT_WORKERS_ORC', 'BUILD_FARM'),
('UNIT_WORKERS_ORC', 'BUILD_MINE'),
('UNIT_WORKERS_ORC', 'BUILD_PASTURE'),
('UNIT_WORKERS_ORC', 'BUILD_E_PLANTATION'),
('UNIT_WORKERS_ORC', 'BUILD_T_PLANTATION'),
('UNIT_WORKERS_ORC', 'BUILD_VINEYARD'),
('UNIT_WORKERS_ORC', 'BUILD_ORCHARD'),
('UNIT_WORKERS_ORC', 'BUILD_QUARRY'),
('UNIT_WORKERS_ORC', 'BUILD_LUMBERMILL_2'),
('UNIT_WORKERS_ORC', 'BUILD_FARM_2'),
('UNIT_WORKERS_ORC', 'BUILD_MINE_2'),
('UNIT_WORKERS_ORC', 'BUILD_SLASH_BURN_FOREST'),
('UNIT_WORKERS_ORC', 'BUILD_SLASH_BURN_JUNGLE'),
('UNIT_WORKERS_ORC', 'BUILD_CHOP_FOREST'),
('UNIT_WORKERS_ORC', 'BUILD_CHOP_JUNGLE'),
('UNIT_WORKERS_ORC', 'BUILD_REMOVE_MARSH'),
('UNIT_WORKERS_ORC', 'BUILD_FARM_PAN'),
('UNIT_WORKERS_ORC', 'BUILD_MINE_PAN'),
('UNIT_WORKERS_ORC', 'BUILD_PASTURE_PAN'),
('UNIT_WORKERS_ORC', 'BUILD_E_PLANTATION_PAN'),
('UNIT_WORKERS_ORC', 'BUILD_T_PLANTATION_PAN'),
('UNIT_WORKERS_ORC', 'BUILD_VINEYARD_PAN'),
('UNIT_WORKERS_ORC', 'BUILD_ORCHARD_PAN'),
('UNIT_WORKERS_ORC', 'BUILD_QUARRY_PAN'),
('UNIT_SLAVES_ORC', 'BUILD_ROAD'),
('UNIT_SLAVES_ORC', 'BUILD_RAILROAD'),
('UNIT_SLAVES_ORC', 'BUILD_LUMBERMILL'),
('UNIT_SLAVES_ORC', 'BUILD_BOWYERS_CAMP'),
('UNIT_SLAVES_ORC', 'BUILD_GATHERERS_HUT'),
('UNIT_SLAVES_ORC', 'BUILD_REPAIR'),
('UNIT_SLAVES_ORC', 'BUILD_REMOVE_ROUTE'),
('UNIT_SLAVES_ORC', 'BUILD_FARM'),
('UNIT_SLAVES_ORC', 'BUILD_MINE'),
('UNIT_SLAVES_ORC', 'BUILD_PASTURE'),
('UNIT_SLAVES_ORC', 'BUILD_E_PLANTATION'),
('UNIT_SLAVES_ORC', 'BUILD_T_PLANTATION'),
('UNIT_SLAVES_ORC', 'BUILD_VINEYARD'),
('UNIT_SLAVES_ORC', 'BUILD_ORCHARD'),
('UNIT_SLAVES_ORC', 'BUILD_QUARRY'),
('UNIT_SLAVES_ORC', 'BUILD_LUMBERMILL_2'),
('UNIT_SLAVES_ORC', 'BUILD_FARM_2'),
('UNIT_SLAVES_ORC', 'BUILD_MINE_2'),
('UNIT_SLAVES_ORC', 'BUILD_SLASH_BURN_FOREST'),
('UNIT_SLAVES_ORC', 'BUILD_SLASH_BURN_JUNGLE'),
('UNIT_SLAVES_ORC', 'BUILD_CHOP_FOREST'),
('UNIT_SLAVES_ORC', 'BUILD_CHOP_JUNGLE'),
('UNIT_SLAVES_ORC', 'BUILD_REMOVE_MARSH'),
('UNIT_SLAVES_ORC', 'BUILD_FARM_PAN'),
('UNIT_SLAVES_ORC', 'BUILD_MINE_PAN'),
('UNIT_SLAVES_ORC', 'BUILD_PASTURE_PAN'),
('UNIT_SLAVES_ORC', 'BUILD_E_PLANTATION_PAN'),
('UNIT_SLAVES_ORC', 'BUILD_T_PLANTATION_PAN'),
('UNIT_SLAVES_ORC', 'BUILD_VINEYARD_PAN'),
('UNIT_SLAVES_ORC', 'BUILD_ORCHARD_PAN'),
('UNIT_SLAVES_ORC', 'BUILD_QUARRY_PAN' );

--
DELETE FROM Unit_FreePromotions;
INSERT INTO Unit_FreePromotions (UnitType, PromotionType) VALUES
('UNIT_SLAVES_MAN', 'PROMOTION_SLAVE'),
('UNIT_SLAVES_SIDHE', 'PROMOTION_SLAVE'),
('UNIT_SLAVES_ORC', 'PROMOTION_SLAVE'),

('UNIT_CARAVAN', 'PROMOTION_SIGHT_PENALTY'),
('UNIT_CARGO_SHIP', 'PROMOTION_SIGHT_PENALTY'),

('UNIT_BIREMES', 'PROMOTION_WOODEN'),
('UNIT_BIREMES', 'PROMOTION_OCEAN_IMPASSABLE_UNTIL_ASTRONOMY'),
('UNIT_TRIREMES', 'PROMOTION_WOODEN'),
('UNIT_TRIREMES', 'PROMOTION_OCEAN_IMPASSABLE_UNTIL_ASTRONOMY'),
('UNIT_QUINQUEREMES', 'PROMOTION_WOODEN'),
('UNIT_QUINQUEREMES', 'PROMOTION_OCEAN_IMPASSABLE_UNTIL_ASTRONOMY'),
('UNIT_CARAVELS', 'PROMOTION_WOODEN'),
('UNIT_DROMONS', 'PROMOTION_WOODEN'),
('UNIT_DROMONS', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_DROMONS', 'PROMOTION_OCEAN_IMPASSABLE_UNTIL_ASTRONOMY'),
('UNIT_CARRACKS', 'PROMOTION_WOODEN'),
('UNIT_CARRACKS', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_CARRACKS', 'PROMOTION_OCEAN_IMPASSABLE_UNTIL_ASTRONOMY'),
('UNIT_GALLEONS', 'PROMOTION_WOODEN'),
('UNIT_IRONCLADS', 'PROMOTION_METAL'),
('UNIT_IRONCLADS', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_IRONCLADS', 'PROMOTION_OCEAN_IMPASSABLE_UNTIL_ASTRONOMY'),
('UNIT_IRONCLADS', 'PROMOTION_STEAM_POWERED'),

('UNIT_BALLISTAE', 'PROMOTION_WOODEN'),
('UNIT_BALLISTAE', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_BALLISTAE', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_BALLISTAE', 'PROMOTION_MUST_SET_UP'),
('UNIT_BALLISTAE', 'PROMOTION_SIGHT_PENALTY'),
('UNIT_CATAPULTS', 'PROMOTION_WOODEN'),
('UNIT_CATAPULTS', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_CATAPULTS', 'PROMOTION_CITY_SIEGE'),
('UNIT_CATAPULTS', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_CATAPULTS', 'PROMOTION_MUST_SET_UP'),
('UNIT_CATAPULTS', 'PROMOTION_SIGHT_PENALTY'),
('UNIT_TREBUCHETS', 'PROMOTION_WOODEN'),
('UNIT_TREBUCHETS', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_TREBUCHETS', 'PROMOTION_CITY_SIEGE'),
('UNIT_TREBUCHETS', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_TREBUCHETS', 'PROMOTION_MUST_SET_UP'),
('UNIT_TREBUCHETS', 'PROMOTION_SIGHT_PENALTY'),
('UNIT_FIRE_CATAPULTS', 'PROMOTION_WOODEN'),
('UNIT_FIRE_CATAPULTS', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_FIRE_CATAPULTS', 'PROMOTION_CITY_SIEGE'),
('UNIT_FIRE_CATAPULTS', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_FIRE_CATAPULTS', 'PROMOTION_MUST_SET_UP'),
('UNIT_FIRE_CATAPULTS', 'PROMOTION_SIGHT_PENALTY'),
('UNIT_FIRE_TREBUCHETS', 'PROMOTION_WOODEN'),
('UNIT_FIRE_TREBUCHETS', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_FIRE_TREBUCHETS', 'PROMOTION_CITY_SIEGE'),
('UNIT_FIRE_TREBUCHETS', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_FIRE_TREBUCHETS', 'PROMOTION_MUST_SET_UP'),
('UNIT_FIRE_TREBUCHETS', 'PROMOTION_SIGHT_PENALTY'),
('UNIT_BOMBARDS', 'PROMOTION_METAL'),
('UNIT_BOMBARDS', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_BOMBARDS', 'PROMOTION_CITY_SIEGE'),
('UNIT_BOMBARDS', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_BOMBARDS', 'PROMOTION_MUST_SET_UP'),
('UNIT_BOMBARDS', 'PROMOTION_SIGHT_PENALTY'),
('UNIT_GREAT_BOMBARDE', 'PROMOTION_METAL'),
('UNIT_GREAT_BOMBARDE', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_GREAT_BOMBARDE', 'PROMOTION_GREAT_BOMBARDE'),
('UNIT_GREAT_BOMBARDE', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_GREAT_BOMBARDE', 'PROMOTION_MUST_SET_UP'),
('UNIT_GREAT_BOMBARDE', 'PROMOTION_SIGHT_PENALTY'),

('UNIT_MOUNTED_ELEPHANTS', 'PROMOTION_ELEPHANT'),
('UNIT_MOUNTED_ELEPHANTS', 'PROMOTION_FEARED_ELEPHANT'),
('UNIT_WAR_ELEPHANTS', 'PROMOTION_ELEPHANT'),
('UNIT_WAR_ELEPHANTS', 'PROMOTION_FEARED_ELEPHANT'),
('UNIT_MUMAKIL', 'PROMOTION_ELEPHANT'),
('UNIT_MUMAKIL', 'PROMOTION_FEARED_ELEPHANT'),

('UNIT_SCOUTS_MAN', 'PROMOTION_RECON'),
('UNIT_TRACKERS_MAN', 'PROMOTION_RECON'),
('UNIT_RANGERS_MAN', 'PROMOTION_RECON'),
('UNIT_WARRIORS_MAN', 'PROMOTION_INFANTRY'),
('UNIT_LIGHT_INFANTRY_MAN', 'PROMOTION_INFANTRY'),
('UNIT_MEDIUM_INFANTRY_MAN', 'PROMOTION_INFANTRY'),
('UNIT_HEAVY_INFANTRY_MAN', 'PROMOTION_INFANTRY'),
('UNIT_IMMORTALS_MAN', 'PROMOTION_INFANTRY'),
('UNIT_CHARIOTS_MAN', 'PROMOTION_WOODEN'),
('UNIT_CHARIOTS_MAN', 'PROMOTION_ROUGH_TERRAIN_ENDS_TURN'),
('UNIT_CHARIOTS_MAN', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_CHARIOTS_MAN', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_HORSEMEN_MAN', 'PROMOTION_HORSE_MOUNTED'),
('UNIT_HORSEMEN_MAN', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_HORSEMEN_MAN', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_EQUITES_MAN', 'PROMOTION_HORSE_MOUNTED'),
('UNIT_EQUITES_MAN', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_EQUITES_MAN', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_ARMORED_CAVALRY_MAN', 'PROMOTION_HORSE_MOUNTED'),
('UNIT_ARMORED_CAVALRY_MAN', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_ARMORED_CAVALRY_MAN', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_CATAPHRACTS_MAN', 'PROMOTION_HORSE_MOUNTED'),
('UNIT_CATAPHRACTS_MAN', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_CATAPHRACTS_MAN', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_CLIBANARII_MAN', 'PROMOTION_HORSE_MOUNTED'),
('UNIT_CLIBANARII_MAN', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_CLIBANARII_MAN', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_ARCHERS_MAN', 'PROMOTION_UNMOUNTED_ARCHER'),
('UNIT_ARCHERS_MAN', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_BOWMEN_MAN', 'PROMOTION_UNMOUNTED_ARCHER'),
('UNIT_BOWMEN_MAN', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_MARKSMEN_MAN', 'PROMOTION_UNMOUNTED_ARCHER'),
('UNIT_MARKSMEN_MAN', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_CROSSBOWMEN_MAN', 'PROMOTION_UNMOUNTED_ARCHER'),
('UNIT_CROSSBOWMEN_MAN', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_CROSSBOWMEN_MAN', 'PROMOTION_PIERCING_1'),
('UNIT_ARQUEBUSSMEN_MAN', 'PROMOTION_UNMOUNTED_ARCHER'),
('UNIT_ARQUEBUSSMEN_MAN', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_ARQUEBUSSMEN_MAN', 'PROMOTION_PIERCING_1'),
('UNIT_ARQUEBUSSMEN_MAN', 'PROMOTION_PIERCING_2'),
('UNIT_CHARIOT_ARCHERS_MAN', 'PROMOTION_WOODEN'),
('UNIT_CHARIOT_ARCHERS_MAN', 'PROMOTION_ROUGH_TERRAIN_ENDS_TURN'),
('UNIT_CHARIOT_ARCHERS_MAN', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_CHARIOT_ARCHERS_MAN', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_CHARIOT_ARCHERS_MAN', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_HORSE_ARCHERS_MAN', 'PROMOTION_HORSE_MOUNTED'),
('UNIT_HORSE_ARCHERS_MAN', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_HORSE_ARCHERS_MAN', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_HORSE_ARCHERS_MAN', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_BOWED_CAVALRY_MAN', 'PROMOTION_HORSE_MOUNTED'),
('UNIT_BOWED_CAVALRY_MAN', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_BOWED_CAVALRY_MAN', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_BOWED_CAVALRY_MAN', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_SAGITARII_MAN', 'PROMOTION_HORSE_MOUNTED'),
('UNIT_SAGITARII_MAN', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_SAGITARII_MAN', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_SAGITARII_MAN', 'PROMOTION_MOVEMENT_TO_GENERAL'),

('UNIT_SCOUTS_SIDHE', 'PROMOTION_RECON'),
('UNIT_TRACKERS_SIDHE', 'PROMOTION_RECON'),
('UNIT_RANGERS_SIDHE', 'PROMOTION_RECON'),
('UNIT_WARRIORS_SIDHE', 'PROMOTION_INFANTRY'),
('UNIT_LIGHT_INFANTRY_SIDHE', 'PROMOTION_INFANTRY'),
('UNIT_MEDIUM_INFANTRY_SIDHE', 'PROMOTION_INFANTRY'),
('UNIT_HEAVY_INFANTRY_SIDHE', 'PROMOTION_INFANTRY'),
('UNIT_IMMORTALS_SIDHE', 'PROMOTION_INFANTRY'),
('UNIT_CHARIOTS_SIDHE', 'PROMOTION_WOODEN'),
('UNIT_CHARIOTS_SIDHE', 'PROMOTION_ROUGH_TERRAIN_ENDS_TURN'),
('UNIT_CHARIOTS_SIDHE', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_CHARIOTS_SIDHE', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_HORSEMEN_SIDHE', 'PROMOTION_HORSE_MOUNTED'),
('UNIT_HORSEMEN_SIDHE', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_HORSEMEN_SIDHE', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_EQUITES_SIDHE', 'PROMOTION_HORSE_MOUNTED'),
('UNIT_EQUITES_SIDHE', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_EQUITES_SIDHE', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_ARMORED_CAVALRY_SIDHE', 'PROMOTION_HORSE_MOUNTED'),
('UNIT_ARMORED_CAVALRY_SIDHE', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_ARMORED_CAVALRY_SIDHE', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_CATAPHRACTS_SIDHE', 'PROMOTION_HORSE_MOUNTED'),
('UNIT_CATAPHRACTS_SIDHE', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_CATAPHRACTS_SIDHE', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_CLIBANARII_SIDHE', 'PROMOTION_HORSE_MOUNTED'),
('UNIT_CLIBANARII_SIDHE', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_CLIBANARII_SIDHE', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_ARCHERS_SIDHE', 'PROMOTION_UNMOUNTED_ARCHER'),
('UNIT_ARCHERS_SIDHE', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_BOWMEN_SIDHE', 'PROMOTION_UNMOUNTED_ARCHER'),
('UNIT_BOWMEN_SIDHE', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_MARKSMEN_SIDHE', 'PROMOTION_UNMOUNTED_ARCHER'),
('UNIT_MARKSMEN_SIDHE', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_CROSSBOWMEN_SIDHE', 'PROMOTION_UNMOUNTED_ARCHER'),
('UNIT_CROSSBOWMEN_SIDHE', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_CROSSBOWMEN_SIDHE', 'PROMOTION_PIERCING_1'),
('UNIT_ARQUEBUSSMEN_SIDHE', 'PROMOTION_UNMOUNTED_ARCHER'),
('UNIT_ARQUEBUSSMEN_SIDHE', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_ARQUEBUSSMEN_SIDHE', 'PROMOTION_PIERCING_1'),
('UNIT_ARQUEBUSSMEN_SIDHE', 'PROMOTION_PIERCING_2'),
('UNIT_CHARIOT_ARCHERS_SIDHE', 'PROMOTION_WOODEN'),
('UNIT_CHARIOT_ARCHERS_SIDHE', 'PROMOTION_ROUGH_TERRAIN_ENDS_TURN'),
('UNIT_CHARIOT_ARCHERS_SIDHE', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_CHARIOT_ARCHERS_SIDHE', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_CHARIOT_ARCHERS_SIDHE', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_HORSE_ARCHERS_SIDHE', 'PROMOTION_HORSE_MOUNTED'),
('UNIT_HORSE_ARCHERS_SIDHE', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_HORSE_ARCHERS_SIDHE', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_HORSE_ARCHERS_SIDHE', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_BOWED_CAVALRY_SIDHE', 'PROMOTION_HORSE_MOUNTED'),
('UNIT_BOWED_CAVALRY_SIDHE', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_BOWED_CAVALRY_SIDHE', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_BOWED_CAVALRY_SIDHE', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_SAGITARII_SIDHE', 'PROMOTION_HORSE_MOUNTED'),
('UNIT_SAGITARII_SIDHE', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_SAGITARII_SIDHE', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_SAGITARII_SIDHE', 'PROMOTION_MOVEMENT_TO_GENERAL'),

('UNIT_SCOUTS_GOBLIN', 'PROMOTION_RECON'),
('UNIT_TRACKERS_GOBLIN', 'PROMOTION_RECON'),
('UNIT_RANGERS_GOBLIN', 'PROMOTION_RECON'),
('UNIT_WARRIORS_ORC', 'PROMOTION_INFANTRY'),
('UNIT_LIGHT_INFANTRY_ORC', 'PROMOTION_INFANTRY'),
('UNIT_MEDIUM_INFANTRY_ORC', 'PROMOTION_INFANTRY'),
('UNIT_HEAVY_INFANTRY_ORC', 'PROMOTION_INFANTRY'),
('UNIT_IMMORTALS_ORC', 'PROMOTION_INFANTRY'),
('UNIT_WOLF_RIDERS_GOBLIN', 'PROMOTION_HORSE_MOUNTED'),
('UNIT_WOLF_RIDERS_GOBLIN', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_WOLF_RIDERS_GOBLIN', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_WARG_RIDERS_GOBLIN', 'PROMOTION_HORSE_MOUNTED'),
('UNIT_WARG_RIDERS_GOBLIN', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_WARG_RIDERS_GOBLIN', 'PROMOTION_MOVEMENT_TO_GENERAL'),
('UNIT_ARCHERS_GOBLIN', 'PROMOTION_UNMOUNTED_ARCHER'),
('UNIT_ARCHERS_GOBLIN', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_BOWMEN_GOBLIN', 'PROMOTION_UNMOUNTED_ARCHER'),
('UNIT_BOWMEN_GOBLIN', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_MARKSMEN_GOBLIN', 'PROMOTION_UNMOUNTED_ARCHER'),
('UNIT_MARKSMEN_GOBLIN', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_CROSSBOWMEN_GOBLIN', 'PROMOTION_UNMOUNTED_ARCHER'),
('UNIT_CROSSBOWMEN_GOBLIN', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_CROSSBOWMEN_GOBLIN', 'PROMOTION_PIERCING_1'),
('UNIT_ARQUEBUSSMEN_GOBLIN', 'PROMOTION_UNMOUNTED_ARCHER'),
('UNIT_ARQUEBUSSMEN_GOBLIN', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_ARQUEBUSSMEN_GOBLIN', 'PROMOTION_PIERCING_1'),
('UNIT_ARQUEBUSSMEN_GOBLIN', 'PROMOTION_PIERCING_2'),

('UNIT_GALLEYS_PIRATES', 'PROMOTION_WOODEN'),
('UNIT_GALLEYS_PIRATES', 'PROMOTION_OCEAN_IMPASSABLE_UNTIL_ASTRONOMY'),
('UNIT_WARRIORS_BARB', 'PROMOTION_INFANTRY'),
('UNIT_LIGHT_INFANTRY_BARB', 'PROMOTION_INFANTRY'),
('UNIT_MEDIUM_INFANTRY_BARB', 'PROMOTION_INFANTRY'),
('UNIT_ARCHERS_BARB', 'PROMOTION_UNMOUNTED_ARCHER'),
('UNIT_AXMAN_BARB', 'PROMOTION_UNMOUNTED_ARCHER'),
('UNIT_OGRES', 'PROMOTION_INFANTRY'),
('UNIT_HOBGOBLINS', 'PROMOTION_INFANTRY'),

('UNIT_WOLVES', 'PROMOTION_ANIMAL'),
('UNIT_LIONS', 'PROMOTION_ANIMAL'),
('UNIT_GRIFFONS', 'PROMOTION_ANIMAL'),
('UNIT_GRIFFONS', 'PROMOTION_HOVERING_UNIT'),
('UNIT_GRIFFONS', 'PROMOTION_IGNORE_TERRAIN_COST'),
('UNIT_SCORPIONS_SAND', 'PROMOTION_ANIMAL'),
('UNIT_SCORPIONS_BLACK', 'PROMOTION_ANIMAL'),
('UNIT_SCORPIONS_WHITE', 'PROMOTION_ANIMAL'),
('UNIT_KRAKEN', 'PROMOTION_ANIMAL'),
('UNIT_GIANT_SPIDER', 'PROMOTION_ANIMAL'),
('UNIT_DRAKE_GREEN', 'PROMOTION_ANIMAL'),
('UNIT_DRAKE_GREEN', 'PROMOTION_HOVERING_UNIT'),
('UNIT_DRAKE_GREEN', 'PROMOTION_IGNORE_TERRAIN_COST'),
('UNIT_DRAKE_BLUE', 'PROMOTION_ANIMAL'),
('UNIT_DRAKE_BLUE', 'PROMOTION_HOVERING_UNIT'),
('UNIT_DRAKE_BLUE', 'PROMOTION_IGNORE_TERRAIN_COST'),
('UNIT_DRAKE_RED', 'PROMOTION_ANIMAL'),
('UNIT_DRAKE_RED', 'PROMOTION_HOVERING_UNIT'),
('UNIT_DRAKE_RED', 'PROMOTION_IGNORE_TERRAIN_COST'),

-- all GPs can move rival terrain
('UNIT_ENGINEER', 'PROMOTION_ENGINEER'),
('UNIT_ENGINEER', 'PROMOTION_RIVAL_TERRITORY'),
('UNIT_MERCHANT', 'PROMOTION_MERCHANT'),
('UNIT_MERCHANT', 'PROMOTION_RIVAL_TERRITORY'),
('UNIT_SAGE', 'PROMOTION_SAGE'),
('UNIT_SAGE', 'PROMOTION_RIVAL_TERRITORY'),
('UNIT_ALCHEMIST', 'PROMOTION_SAGE'),
('UNIT_ALCHEMIST', 'PROMOTION_ALCHEMIST'),
('UNIT_ALCHEMIST', 'PROMOTION_RIVAL_TERRITORY'),
('UNIT_ARTIST', 'PROMOTION_ARTIST'),
('UNIT_ARTIST', 'PROMOTION_RIVAL_TERRITORY'),
('UNIT_WARRIOR', 'PROMOTION_WARRIOR'),
('UNIT_WARRIOR', 'PROMOTION_RIVAL_TERRITORY'),
('UNIT_BERSERKER', 'PROMOTION_WARRIOR'),
('UNIT_BERSERKER', 'PROMOTION_BERSERKER'),
('UNIT_BERSERKER', 'PROMOTION_RIVAL_TERRITORY'),
('UNIT_PRIEST', 'PROMOTION_DEVOUT'),
('UNIT_PRIEST', 'PROMOTION_PRIEST'),
('UNIT_PRIEST', 'PROMOTION_RIVAL_TERRITORY'),
('UNIT_FALLENPRIEST', 'PROMOTION_DEVOUT'),
('UNIT_FALLENPRIEST', 'PROMOTION_THAUMATURGE'),
('UNIT_FALLENPRIEST', 'PROMOTION_FALLENPRIEST'),
('UNIT_FALLENPRIEST', 'PROMOTION_RIVAL_TERRITORY'),
('UNIT_PALADIN', 'PROMOTION_WARRIOR'),
('UNIT_PALADIN', 'PROMOTION_DEVOUT'),
('UNIT_PALADIN', 'PROMOTION_PALADIN'),
('UNIT_PALADIN', 'PROMOTION_RIVAL_TERRITORY'),
('UNIT_EIDOLON', 'PROMOTION_WARRIOR'),
('UNIT_EIDOLON', 'PROMOTION_DEVOUT'),
('UNIT_EIDOLON', 'PROMOTION_EIDOLON'),
('UNIT_EIDOLON', 'PROMOTION_RIVAL_TERRITORY'),
('UNIT_DRUID', 'PROMOTION_DEVOUT'),
('UNIT_DRUID', 'PROMOTION_THAUMATURGE'),
('UNIT_DRUID', 'PROMOTION_DRUID'),
('UNIT_DRUID', 'PROMOTION_RIVAL_TERRITORY'),
('UNIT_WITCH', 'PROMOTION_THAUMATURGE'),
('UNIT_WITCH', 'PROMOTION_WITCH'),
('UNIT_WITCH', 'PROMOTION_RIVAL_TERRITORY'),
('UNIT_WIZARD', 'PROMOTION_THAUMATURGE'),
('UNIT_WIZARD', 'PROMOTION_WIZARD'),
('UNIT_WIZARD', 'PROMOTION_RIVAL_TERRITORY'),
('UNIT_SORCERER', 'PROMOTION_THAUMATURGE'),
('UNIT_SORCERER', 'PROMOTION_SORCERER'),
('UNIT_SORCERER', 'PROMOTION_RIVAL_TERRITORY'),
('UNIT_NECROMANCER', 'PROMOTION_THAUMATURGE'),
('UNIT_NECROMANCER', 'PROMOTION_NECROMANCER'),
('UNIT_NECROMANCER', 'PROMOTION_RIVAL_TERRITORY'),
('UNIT_LICH', 'PROMOTION_THAUMATURGE'),
('UNIT_LICH', 'PROMOTION_LICH'),
('UNIT_LICH', 'PROMOTION_RIVAL_TERRITORY'),

('UNIT_DRUID_MAGIC_MISSLE', 'PROMOTION_INDIRECT_FIRE'),
('UNIT_DRUID_MAGIC_MISSLE', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_PRIEST_MAGIC_MISSLE', 'PROMOTION_INDIRECT_FIRE'),
('UNIT_PRIEST_MAGIC_MISSLE', 'PROMOTION_ONLY_DEFENSIVE' );

--('UNIT_DUMMY_EXPLODER', 'PROMOTION_DUMMY_AIR_STRIKE'),
--('UNIT_DUMMY_NUKE', 'PROMOTION_DUMMY_AIR_STRIKE' ;


DELETE FROM Unit_Flavors;
INSERT INTO Unit_Flavors (UnitType, FlavorType, Flavor) VALUES
('UNIT_FISHING_BOATS', 'FLAVOR_NAVAL_TILE_IMPROVEMENT', 100),
('UNIT_FISHING_BOATS', 'FLAVOR_TILE_IMPROVEMENT', 100),
('UNIT_FISHING_BOATS', 'FLAVOR_EXPANSION', 100),
('UNIT_WHALING_BOATS', 'FLAVOR_NAVAL_TILE_IMPROVEMENT', 100),
('UNIT_WHALING_BOATS', 'FLAVOR_EXPANSION', 100),
('UNIT_HUNTERS', 'FLAVOR_TILE_IMPROVEMENT', 100),
('UNIT_HUNTERS', 'FLAVOR_EXPANSION', 100),

('UNIT_CARAVAN', 'FLAVOR_I_LAND_TRADE_ROUTE', 40),
('UNIT_CARAVAN', 'FLAVOR_GOLD', 20),
('UNIT_CARGO_SHIP', 'FLAVOR_I_SEA_TRADE_ROUTE', 40),
('UNIT_CARGO_SHIP', 'FLAVOR_GOLD', 40),

('UNIT_BIREMES', 'FLAVOR_NAVAL', 8),
('UNIT_BIREMES', 'FLAVOR_NAVAL_RECON', 12),
('UNIT_TRIREMES', 'FLAVOR_NAVAL', 24),
('UNIT_TRIREMES', 'FLAVOR_NAVAL_RECON', 8),
('UNIT_QUINQUEREMES', 'FLAVOR_NAVAL', 30),
('UNIT_QUINQUEREMES', 'FLAVOR_NAVAL_RECON', 8),
('UNIT_DROMONS', 'FLAVOR_NAVAL', 24),
('UNIT_DROMONS', 'FLAVOR_NAVAL_RECON', 12),
('UNIT_CARRACKS', 'FLAVOR_NAVAL', 30),
('UNIT_CARRACKS', 'FLAVOR_NAVAL_RECON', 8),
('UNIT_CARAVELS', 'FLAVOR_NAVAL', 4),
('UNIT_CARAVELS', 'FLAVOR_NAVAL_RECON', 20),
('UNIT_GALLEONS', 'FLAVOR_NAVAL', 36),
('UNIT_GALLEONS', 'FLAVOR_NAVAL_RECON', 12),
('UNIT_IRONCLADS', 'FLAVOR_NAVAL', 36),

('UNIT_BALLISTAE', 'FLAVOR_OFFENSE', 8),
('UNIT_BALLISTAE', 'FLAVOR_DEFENSE', 14),
('UNIT_BALLISTAE', 'FLAVOR_RANGED', 14),
('UNIT_CATAPULTS', 'FLAVOR_OFFENSE', 12),
('UNIT_CATAPULTS', 'FLAVOR_DEFENSE', 12),
('UNIT_CATAPULTS', 'FLAVOR_RANGED', 14),
('UNIT_TREBUCHETS', 'FLAVOR_OFFENSE', 12),
('UNIT_TREBUCHETS', 'FLAVOR_DEFENSE', 12),
('UNIT_TREBUCHETS', 'FLAVOR_RANGED', 14),
('UNIT_FIRE_CATAPULTS', 'FLAVOR_OFFENSE', 12),
('UNIT_FIRE_CATAPULTS', 'FLAVOR_DEFENSE', 12),
('UNIT_FIRE_CATAPULTS', 'FLAVOR_RANGED', 14),
('UNIT_FIRE_TREBUCHETS', 'FLAVOR_OFFENSE', 12),
('UNIT_FIRE_TREBUCHETS', 'FLAVOR_DEFENSE', 12),
('UNIT_FIRE_TREBUCHETS', 'FLAVOR_RANGED', 14),
('UNIT_BOMBARDS', 'FLAVOR_OFFENSE', 12),
('UNIT_BOMBARDS', 'FLAVOR_DEFENSE', 12),
('UNIT_BOMBARDS', 'FLAVOR_RANGED', 14),
('UNIT_GREAT_BOMBARDE', 'FLAVOR_OFFENSE', 12),
('UNIT_GREAT_BOMBARDE', 'FLAVOR_RANGED', 14),

('UNIT_MOUNTED_ELEPHANTS', 'FLAVOR_OFFENSE', 20),
('UNIT_MOUNTED_ELEPHANTS', 'FLAVOR_DEFENSE', 20),
('UNIT_WAR_ELEPHANTS', 'FLAVOR_OFFENSE', 30),
('UNIT_WAR_ELEPHANTS', 'FLAVOR_DEFENSE', 30),
('UNIT_MUMAKIL', 'FLAVOR_OFFENSE', 40),
('UNIT_MUMAKIL', 'FLAVOR_DEFENSE', 40),

('UNIT_SETTLERS_MAN', 'FLAVOR_EXPANSION', 21),
('UNIT_WORKERS_MAN', 'FLAVOR_TILE_IMPROVEMENT', 30),
('UNIT_SLAVES_MAN', 'FLAVOR_TILE_IMPROVEMENT', 30),

('UNIT_SCOUTS_MAN', 'FLAVOR_RECON', 14),
('UNIT_TRACKERS_MAN', 'FLAVOR_RECON', 14),
('UNIT_TRACKERS_MAN', 'FLAVOR_OFFENSE', 4),
('UNIT_TRACKERS_MAN', 'FLAVOR_DEFENSE', 10),
('UNIT_RANGERS_MAN', 'FLAVOR_RECON', 18),
('UNIT_RANGERS_MAN', 'FLAVOR_OFFENSE', 8),
('UNIT_RANGERS_MAN', 'FLAVOR_DEFENSE', 12),

('UNIT_WARRIORS_MAN', 'FLAVOR_RECON', 4),
('UNIT_WARRIORS_MAN', 'FLAVOR_OFFENSE', 4),
('UNIT_WARRIORS_MAN', 'FLAVOR_DEFENSE', 4),
('UNIT_LIGHT_INFANTRY_MAN', 'FLAVOR_OFFENSE', 12),
('UNIT_LIGHT_INFANTRY_MAN', 'FLAVOR_DEFENSE', 12),
('UNIT_MEDIUM_INFANTRY_MAN', 'FLAVOR_OFFENSE', 18),
('UNIT_MEDIUM_INFANTRY_MAN', 'FLAVOR_DEFENSE', 14),
('UNIT_MEDIUM_INFANTRY_MAN', 'FLAVOR_OFFENSE', 24),
('UNIT_MEDIUM_INFANTRY_MAN', 'FLAVOR_DEFENSE', 20),
('UNIT_HEAVY_INFANTRY_MAN', 'FLAVOR_OFFENSE', 30),
('UNIT_HEAVY_INFANTRY_MAN', 'FLAVOR_DEFENSE', 26),
('UNIT_IMMORTALS_MAN', 'FLAVOR_OFFENSE', 36),
('UNIT_IMMORTALS_MAN', 'FLAVOR_DEFENSE', 36),

('UNIT_CHARIOTS_MAN', 'FLAVOR_OFFENSE', 8),
('UNIT_CHARIOTS_MAN', 'FLAVOR_DEFENSE', 4),
('UNIT_CHARIOTS_MAN', 'FLAVOR_MOBILE', 4),
('UNIT_HORSEMEN_MAN', 'FLAVOR_OFFENSE', 12),
('UNIT_HORSEMEN_MAN', 'FLAVOR_DEFENSE', 4),
('UNIT_HORSEMEN_MAN', 'FLAVOR_MOBILE', 8),
('UNIT_EQUITES_MAN', 'FLAVOR_OFFENSE', 20),
('UNIT_EQUITES_MAN', 'FLAVOR_DEFENSE', 12),
('UNIT_EQUITES_MAN', 'FLAVOR_MOBILE', 18),
('UNIT_ARMORED_CAVALRY_MAN', 'FLAVOR_OFFENSE', 20),
('UNIT_ARMORED_CAVALRY_MAN', 'FLAVOR_DEFENSE', 12),
('UNIT_ARMORED_CAVALRY_MAN', 'FLAVOR_MOBILE', 14),
('UNIT_CATAPHRACTS_MAN', 'FLAVOR_OFFENSE', 24),
('UNIT_CATAPHRACTS_MAN', 'FLAVOR_DEFENSE', 16),
('UNIT_CATAPHRACTS_MAN', 'FLAVOR_MOBILE', 18),
('UNIT_CLIBANARII_MAN', 'FLAVOR_OFFENSE', 30),
('UNIT_CLIBANARII_MAN', 'FLAVOR_DEFENSE', 24),
('UNIT_CLIBANARII_MAN', 'FLAVOR_MOBILE', 30),

('UNIT_ARCHERS_MAN', 'FLAVOR_OFFENSE', 4),
('UNIT_ARCHERS_MAN', 'FLAVOR_DEFENSE', 4),
('UNIT_ARCHERS_MAN', 'FLAVOR_RANGED', 14),
('UNIT_BOWMEN_MAN', 'FLAVOR_OFFENSE', 12),
('UNIT_BOWMEN_MAN', 'FLAVOR_DEFENSE', 16),
('UNIT_BOWMEN_MAN', 'FLAVOR_RANGED', 26),
('UNIT_MARKSMEN_MAN', 'FLAVOR_OFFENSE', 16),
('UNIT_MARKSMEN_MAN', 'FLAVOR_DEFENSE', 20),
('UNIT_MARKSMEN_MAN', 'FLAVOR_RANGED', 36),
('UNIT_CROSSBOWMEN_MAN', 'FLAVOR_OFFENSE', 12),
('UNIT_CROSSBOWMEN_MAN', 'FLAVOR_DEFENSE', 16),
('UNIT_CROSSBOWMEN_MAN', 'FLAVOR_RANGED', 26),
('UNIT_ARQUEBUSSMEN_MAN', 'FLAVOR_OFFENSE', 12),
('UNIT_ARQUEBUSSMEN_MAN', 'FLAVOR_DEFENSE', 16),
('UNIT_ARQUEBUSSMEN_MAN', 'FLAVOR_RANGED', 23),

('UNIT_CHARIOT_ARCHERS_MAN', 'FLAVOR_OFFENSE', 4),
('UNIT_CHARIOT_ARCHERS_MAN', 'FLAVOR_DEFENSE', 2),
('UNIT_CHARIOT_ARCHERS_MAN', 'FLAVOR_RANGED', 8),
('UNIT_CHARIOT_ARCHERS_MAN', 'FLAVOR_MOBILE', 2),
('UNIT_HORSE_ARCHERS_MAN', 'FLAVOR_OFFENSE', 10),
('UNIT_HORSE_ARCHERS_MAN', 'FLAVOR_DEFENSE', 4),
('UNIT_HORSE_ARCHERS_MAN', 'FLAVOR_RANGED', 14),
('UNIT_HORSE_ARCHERS_MAN', 'FLAVOR_MOBILE', 14),
('UNIT_BOWED_CAVALRY_MAN', 'FLAVOR_OFFENSE', 14),
('UNIT_BOWED_CAVALRY_MAN', 'FLAVOR_DEFENSE', 4),
('UNIT_BOWED_CAVALRY_MAN', 'FLAVOR_RANGED', 24),
('UNIT_BOWED_CAVALRY_MAN', 'FLAVOR_MOBILE', 24),
('UNIT_SAGITARII_MAN', 'FLAVOR_OFFENSE', 24),
('UNIT_SAGITARII_MAN', 'FLAVOR_DEFENSE', 20),
('UNIT_SAGITARII_MAN', 'FLAVOR_RANGED', 36),
('UNIT_SAGITARII_MAN', 'FLAVOR_MOBILE', 36),


('UNIT_SETTLERS_SIDHE', 'FLAVOR_EXPANSION', 21),
('UNIT_WORKERS_SIDHE', 'FLAVOR_TILE_IMPROVEMENT', 30),
('UNIT_SLAVES_SIDHE', 'FLAVOR_TILE_IMPROVEMENT', 30),

('UNIT_SCOUTS_SIDHE', 'FLAVOR_RECON', 14),
('UNIT_TRACKERS_SIDHE', 'FLAVOR_RECON', 14),
('UNIT_TRACKERS_SIDHE', 'FLAVOR_OFFENSE', 4),
('UNIT_TRACKERS_SIDHE', 'FLAVOR_DEFENSE', 10),
('UNIT_RANGERS_SIDHE', 'FLAVOR_RECON', 18),
('UNIT_RANGERS_SIDHE', 'FLAVOR_OFFENSE', 8),
('UNIT_RANGERS_SIDHE', 'FLAVOR_DEFENSE', 12),

('UNIT_WARRIORS_SIDHE', 'FLAVOR_RECON', 4),
('UNIT_WARRIORS_SIDHE', 'FLAVOR_OFFENSE', 4),
('UNIT_WARRIORS_SIDHE', 'FLAVOR_DEFENSE', 4),
('UNIT_LIGHT_INFANTRY_SIDHE', 'FLAVOR_OFFENSE', 12),
('UNIT_LIGHT_INFANTRY_SIDHE', 'FLAVOR_DEFENSE', 12),
('UNIT_MEDIUM_INFANTRY_SIDHE', 'FLAVOR_OFFENSE', 18),
('UNIT_MEDIUM_INFANTRY_SIDHE', 'FLAVOR_DEFENSE', 14),
('UNIT_MEDIUM_INFANTRY_SIDHE', 'FLAVOR_OFFENSE', 24),
('UNIT_MEDIUM_INFANTRY_SIDHE', 'FLAVOR_DEFENSE', 20),
('UNIT_HEAVY_INFANTRY_SIDHE', 'FLAVOR_OFFENSE', 30),
('UNIT_HEAVY_INFANTRY_SIDHE', 'FLAVOR_DEFENSE', 26),
('UNIT_IMMORTALS_SIDHE', 'FLAVOR_OFFENSE', 36),
('UNIT_IMMORTALS_SIDHE', 'FLAVOR_DEFENSE', 36),

('UNIT_CHARIOTS_SIDHE', 'FLAVOR_OFFENSE', 8),
('UNIT_CHARIOTS_SIDHE', 'FLAVOR_DEFENSE', 4),
('UNIT_CHARIOTS_SIDHE', 'FLAVOR_MOBILE', 4),
('UNIT_HORSEMEN_SIDHE', 'FLAVOR_OFFENSE', 12),
('UNIT_HORSEMEN_SIDHE', 'FLAVOR_DEFENSE', 4),
('UNIT_HORSEMEN_SIDHE', 'FLAVOR_MOBILE', 8),
('UNIT_EQUITES_SIDHE', 'FLAVOR_OFFENSE', 20),
('UNIT_EQUITES_SIDHE', 'FLAVOR_DEFENSE', 12),
('UNIT_EQUITES_SIDHE', 'FLAVOR_MOBILE', 18),
('UNIT_ARMORED_CAVALRY_SIDHE', 'FLAVOR_OFFENSE', 20),
('UNIT_ARMORED_CAVALRY_SIDHE', 'FLAVOR_DEFENSE', 12),
('UNIT_ARMORED_CAVALRY_SIDHE', 'FLAVOR_MOBILE', 14),
('UNIT_CATAPHRACTS_SIDHE', 'FLAVOR_OFFENSE', 24),
('UNIT_CATAPHRACTS_SIDHE', 'FLAVOR_DEFENSE', 16),
('UNIT_CATAPHRACTS_SIDHE', 'FLAVOR_MOBILE', 18),
('UNIT_CLIBANARII_SIDHE', 'FLAVOR_OFFENSE', 30),
('UNIT_CLIBANARII_SIDHE', 'FLAVOR_DEFENSE', 24),
('UNIT_CLIBANARII_SIDHE', 'FLAVOR_MOBILE', 30),

('UNIT_ARCHERS_SIDHE', 'FLAVOR_OFFENSE', 4),
('UNIT_ARCHERS_SIDHE', 'FLAVOR_DEFENSE', 4),
('UNIT_ARCHERS_SIDHE', 'FLAVOR_RANGED', 14),
('UNIT_BOWMEN_SIDHE', 'FLAVOR_OFFENSE', 12),
('UNIT_BOWMEN_SIDHE', 'FLAVOR_DEFENSE', 16),
('UNIT_BOWMEN_SIDHE', 'FLAVOR_RANGED', 26),
('UNIT_MARKSMEN_SIDHE', 'FLAVOR_OFFENSE', 16),
('UNIT_MARKSMEN_SIDHE', 'FLAVOR_DEFENSE', 20),
('UNIT_MARKSMEN_SIDHE', 'FLAVOR_RANGED', 36),
('UNIT_CROSSBOWMEN_SIDHE', 'FLAVOR_OFFENSE', 12),
('UNIT_CROSSBOWMEN_SIDHE', 'FLAVOR_DEFENSE', 16),
('UNIT_CROSSBOWMEN_SIDHE', 'FLAVOR_RANGED', 26),
('UNIT_ARQUEBUSSMEN_SIDHE', 'FLAVOR_OFFENSE', 12),
('UNIT_ARQUEBUSSMEN_SIDHE', 'FLAVOR_DEFENSE', 16),
('UNIT_ARQUEBUSSMEN_SIDHE', 'FLAVOR_RANGED', 23),

('UNIT_CHARIOT_ARCHERS_SIDHE', 'FLAVOR_OFFENSE', 4),
('UNIT_CHARIOT_ARCHERS_SIDHE', 'FLAVOR_DEFENSE', 2),
('UNIT_CHARIOT_ARCHERS_SIDHE', 'FLAVOR_RANGED', 8),
('UNIT_CHARIOT_ARCHERS_SIDHE', 'FLAVOR_MOBILE', 2),
('UNIT_HORSE_ARCHERS_SIDHE', 'FLAVOR_OFFENSE', 10),
('UNIT_HORSE_ARCHERS_SIDHE', 'FLAVOR_DEFENSE', 4),
('UNIT_HORSE_ARCHERS_SIDHE', 'FLAVOR_RANGED', 14),
('UNIT_HORSE_ARCHERS_SIDHE', 'FLAVOR_MOBILE', 14),
('UNIT_BOWED_CAVALRY_SIDHE', 'FLAVOR_OFFENSE', 14),
('UNIT_BOWED_CAVALRY_SIDHE', 'FLAVOR_DEFENSE', 4),
('UNIT_BOWED_CAVALRY_SIDHE', 'FLAVOR_RANGED', 24),
('UNIT_BOWED_CAVALRY_SIDHE', 'FLAVOR_MOBILE', 24),
('UNIT_SAGITARII_SIDHE', 'FLAVOR_OFFENSE', 24),
('UNIT_SAGITARII_SIDHE', 'FLAVOR_DEFENSE', 20),
('UNIT_SAGITARII_SIDHE', 'FLAVOR_RANGED', 36),
('UNIT_SAGITARII_SIDHE', 'FLAVOR_MOBILE', 36),


('UNIT_SETTLERS_ORC', 'FLAVOR_EXPANSION', 21),
('UNIT_WORKERS_ORC', 'FLAVOR_TILE_IMPROVEMENT', 30),
('UNIT_SLAVES_ORC', 'FLAVOR_TILE_IMPROVEMENT', 30),

('UNIT_SCOUTS_GOBLIN', 'FLAVOR_RECON', 14),
('UNIT_TRACKERS_GOBLIN', 'FLAVOR_RECON', 14),
('UNIT_TRACKERS_GOBLIN', 'FLAVOR_OFFENSE', 4),
('UNIT_TRACKERS_GOBLIN', 'FLAVOR_DEFENSE', 10),
('UNIT_RANGERS_GOBLIN', 'FLAVOR_RECON', 18),
('UNIT_RANGERS_GOBLIN', 'FLAVOR_OFFENSE', 8),
('UNIT_RANGERS_GOBLIN', 'FLAVOR_DEFENSE', 12),

('UNIT_WARRIORS_ORC', 'FLAVOR_RECON', 4),
('UNIT_WARRIORS_ORC', 'FLAVOR_OFFENSE', 4),
('UNIT_WARRIORS_ORC', 'FLAVOR_DEFENSE', 4),
('UNIT_LIGHT_INFANTRY_ORC', 'FLAVOR_OFFENSE', 12),
('UNIT_LIGHT_INFANTRY_ORC', 'FLAVOR_DEFENSE', 12),
('UNIT_MEDIUM_INFANTRY_ORC', 'FLAVOR_OFFENSE', 18),
('UNIT_MEDIUM_INFANTRY_ORC', 'FLAVOR_DEFENSE', 14),
('UNIT_MEDIUM_INFANTRY_ORC', 'FLAVOR_OFFENSE', 24),
('UNIT_MEDIUM_INFANTRY_ORC', 'FLAVOR_DEFENSE', 20),
('UNIT_HEAVY_INFANTRY_ORC', 'FLAVOR_OFFENSE', 30),
('UNIT_HEAVY_INFANTRY_ORC', 'FLAVOR_DEFENSE', 26),
('UNIT_IMMORTALS_ORC', 'FLAVOR_OFFENSE', 36),
('UNIT_IMMORTALS_ORC', 'FLAVOR_DEFENSE', 36),

('UNIT_WOLF_RIDERS_GOBLIN', 'FLAVOR_OFFENSE', 12),
('UNIT_WOLF_RIDERS_GOBLIN', 'FLAVOR_DEFENSE', 4),
('UNIT_WOLF_RIDERS_GOBLIN', 'FLAVOR_MOBILE', 8),
('UNIT_WARG_RIDERS_GOBLIN', 'FLAVOR_OFFENSE', 20),
('UNIT_WARG_RIDERS_GOBLIN', 'FLAVOR_DEFENSE', 12),
('UNIT_WARG_RIDERS_GOBLIN', 'FLAVOR_MOBILE', 18),

('UNIT_ARCHERS_GOBLIN', 'FLAVOR_OFFENSE', 4),
('UNIT_ARCHERS_GOBLIN', 'FLAVOR_DEFENSE', 4),
('UNIT_ARCHERS_GOBLIN', 'FLAVOR_RANGED', 14),
('UNIT_BOWMEN_GOBLIN', 'FLAVOR_OFFENSE', 12),
('UNIT_BOWMEN_GOBLIN', 'FLAVOR_DEFENSE', 16),
('UNIT_BOWMEN_GOBLIN', 'FLAVOR_RANGED', 26),
('UNIT_MARKSMEN_GOBLIN', 'FLAVOR_OFFENSE', 16),
('UNIT_MARKSMEN_GOBLIN', 'FLAVOR_DEFENSE', 20),
('UNIT_MARKSMEN_GOBLIN', 'FLAVOR_RANGED', 36),
('UNIT_CROSSBOWMEN_GOBLIN', 'FLAVOR_OFFENSE', 12),
('UNIT_CROSSBOWMEN_GOBLIN', 'FLAVOR_DEFENSE', 16),
('UNIT_CROSSBOWMEN_GOBLIN', 'FLAVOR_RANGED', 26),
('UNIT_ARQUEBUSSMEN_GOBLIN', 'FLAVOR_OFFENSE', 12),
('UNIT_ARQUEBUSSMEN_GOBLIN', 'FLAVOR_DEFENSE', 16),
('UNIT_ARQUEBUSSMEN_GOBLIN', 'FLAVOR_RANGED', 23);


DELETE FROM Unit_ResourceQuantityRequirements;
INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType) VALUES
('UNIT_BIREMES', 'RESOURCE_TIMBER'),
('UNIT_TRIREMES', 'RESOURCE_TIMBER'),
('UNIT_TRIREMES', 'RESOURCE_COPPER'),
('UNIT_QUINQUEREMES', 'RESOURCE_TIMBER'),
('UNIT_QUINQUEREMES', 'RESOURCE_IRON'),
('UNIT_DROMONS', 'RESOURCE_TIMBER'),
('UNIT_DROMONS', 'RESOURCE_NAPHTHA'),
('UNIT_CARAVELS', 'RESOURCE_TIMBER'),
('UNIT_CARRACKS', 'RESOURCE_TIMBER'),
('UNIT_CARRACKS', 'RESOURCE_IRON'),
--('UNIT_CARRACKS', 'RESOURCE_BLASTING_POWDER'),
('UNIT_GALLEONS', 'RESOURCE_TIMBER'),
('UNIT_GALLEONS', 'RESOURCE_IRON'),
--('UNIT_GALLEONS', 'RESOURCE_BLASTING_POWDER'),
('UNIT_IRONCLADS', 'RESOURCE_IRON'),
--('UNIT_IRONCLADS', 'RESOURCE_BLASTING_POWDER'),

('UNIT_BALLISTAE', 'RESOURCE_TIMBER'),
('UNIT_CATAPULTS', 'RESOURCE_TIMBER'),
('UNIT_TREBUCHETS', 'RESOURCE_TIMBER'),
('UNIT_FIRE_CATAPULTS', 'RESOURCE_TIMBER'),
('UNIT_FIRE_CATAPULTS', 'RESOURCE_NAPHTHA'),
('UNIT_FIRE_TREBUCHETS', 'RESOURCE_TIMBER'),
('UNIT_FIRE_TREBUCHETS', 'RESOURCE_NAPHTHA'),
('UNIT_BOMBARDS', 'RESOURCE_IRON'),
--('UNIT_BOMBARDS', 'RESOURCE_BLASTING_POWDER'),
('UNIT_GREAT_BOMBARDE', 'RESOURCE_IRON'),
--('UNIT_GREAT_BOMBARDE', 'RESOURCE_BLASTING_POWDER'),

('UNIT_MOUNTED_ELEPHANTS', 'RESOURCE_ELEPHANT'),
('UNIT_WAR_ELEPHANTS', 'RESOURCE_ELEPHANT'),
('UNIT_MUMAKIL', 'RESOURCE_ELEPHANT'),

('UNIT_LIGHT_INFANTRY_MAN', 'RESOURCE_COPPER'),
('UNIT_MEDIUM_INFANTRY_MAN', 'RESOURCE_IRON'),
('UNIT_HEAVY_INFANTRY_MAN', 'RESOURCE_IRON'),
('UNIT_IMMORTALS_MAN', 'RESOURCE_MITHRIL'),
('UNIT_CHARIOTS_MAN', 'RESOURCE_HORSE'),
('UNIT_HORSEMEN_MAN', 'RESOURCE_HORSE'),
('UNIT_EQUITES_MAN', 'RESOURCE_HORSE'),
('UNIT_ARMORED_CAVALRY_MAN', 'RESOURCE_HORSE'),
('UNIT_ARMORED_CAVALRY_MAN', 'RESOURCE_IRON'),
('UNIT_CATAPHRACTS_MAN', 'RESOURCE_HORSE'),
('UNIT_CATAPHRACTS_MAN', 'RESOURCE_IRON'),
('UNIT_CLIBANARII_MAN', 'RESOURCE_HORSE'),
('UNIT_CLIBANARII_MAN', 'RESOURCE_MITHRIL'),
('UNIT_BOWMEN_MAN', 'RESOURCE_YEW'),
('UNIT_MARKSMEN_MAN', 'RESOURCE_YEW'),
('UNIT_CHARIOT_ARCHERS_MAN', 'RESOURCE_HORSE'),
('UNIT_HORSE_ARCHERS_MAN', 'RESOURCE_HORSE'),
('UNIT_BOWED_CAVALRY_MAN', 'RESOURCE_HORSE'),
('UNIT_BOWED_CAVALRY_MAN', 'RESOURCE_YEW'),
('UNIT_SAGITARII_MAN', 'RESOURCE_HORSE'),
('UNIT_SAGITARII_MAN', 'RESOURCE_YEW'),

('UNIT_LIGHT_INFANTRY_SIDHE', 'RESOURCE_COPPER'),
('UNIT_MEDIUM_INFANTRY_SIDHE', 'RESOURCE_IRON'),
('UNIT_HEAVY_INFANTRY_SIDHE', 'RESOURCE_IRON'),
('UNIT_IMMORTALS_SIDHE', 'RESOURCE_MITHRIL'),
('UNIT_CHARIOTS_SIDHE', 'RESOURCE_HORSE'),
('UNIT_HORSEMEN_SIDHE', 'RESOURCE_HORSE'),
('UNIT_EQUITES_SIDHE', 'RESOURCE_HORSE'),
('UNIT_ARMORED_CAVALRY_SIDHE', 'RESOURCE_HORSE'),
('UNIT_ARMORED_CAVALRY_SIDHE', 'RESOURCE_IRON'),
('UNIT_CATAPHRACTS_SIDHE', 'RESOURCE_HORSE'),
('UNIT_CATAPHRACTS_SIDHE', 'RESOURCE_IRON'),
('UNIT_CLIBANARII_SIDHE', 'RESOURCE_HORSE'),
('UNIT_CLIBANARII_SIDHE', 'RESOURCE_MITHRIL'),
('UNIT_BOWMEN_SIDHE', 'RESOURCE_YEW'),
('UNIT_MARKSMEN_SIDHE', 'RESOURCE_YEW'),
('UNIT_CHARIOT_ARCHERS_SIDHE', 'RESOURCE_HORSE'),
('UNIT_HORSE_ARCHERS_SIDHE', 'RESOURCE_HORSE'),
('UNIT_BOWED_CAVALRY_SIDHE', 'RESOURCE_HORSE'),
('UNIT_BOWED_CAVALRY_SIDHE', 'RESOURCE_YEW'),
('UNIT_SAGITARII_SIDHE', 'RESOURCE_HORSE'),
('UNIT_SAGITARII_SIDHE', 'RESOURCE_YEW'),

('UNIT_LIGHT_INFANTRY_ORC', 'RESOURCE_COPPER'),
('UNIT_MEDIUM_INFANTRY_ORC', 'RESOURCE_IRON'),
('UNIT_HEAVY_INFANTRY_ORC', 'RESOURCE_IRON'),
('UNIT_IMMORTALS_ORC', 'RESOURCE_MITHRIL'),
('UNIT_BOWMEN_GOBLIN', 'RESOURCE_YEW'),
('UNIT_MARKSMEN_GOBLIN', 'RESOURCE_YEW');

DELETE FROM Unit_TechTypes;		--and techs (main table determines where shown in tech tree)
INSERT INTO Unit_TechTypes (UnitType, TechType) VALUES			

('UNIT_GREAT_BOMBARDE', 'TECH_CHEMISTRY'),
('UNIT_BOMBARDS', 'TECH_CHEMISTRY'),
('UNIT_CARRACKS', 'TECH_CHEMISTRY'),
('UNIT_GALLEONS', 'TECH_CHEMISTRY'),
('UNIT_IRONCLADS', 'TECH_CHEMISTRY'),
('UNIT_CARAVELS', 'TECH_SHIP_BUILDING'),
('UNIT_ARQUEBUSSMEN_MAN', 'TECH_CHEMISTRY'),

('UNIT_HORSE_ARCHERS_MAN', 'TECH_ARCHERY'),
('UNIT_BOWED_CAVALRY_MAN', 'TECH_BOWYERS'),
('UNIT_SAGITARII_MAN', 'TECH_MARKSMANSHIP'),
('UNIT_CLIBANARII_MAN', 'TECH_WAR_HORSES'),
('UNIT_ARQUEBUSSMEN_SIDHE', 'TECH_CHEMISTRY'),
('UNIT_HORSE_ARCHERS_SIDHE', 'TECH_ARCHERY'),
('UNIT_BOWED_CAVALRY_SIDHE', 'TECH_BOWYERS'),
('UNIT_SAGITARII_SIDHE', 'TECH_MARKSMANSHIP'),
('UNIT_CLIBANARII_SIDHE', 'TECH_WAR_HORSES'),
('UNIT_ARQUEBUSSMEN_GOBLIN', 'TECH_CHEMISTRY');



INSERT INTO EaDebugTableCheck(FileName) SELECT 'Units.sql';
