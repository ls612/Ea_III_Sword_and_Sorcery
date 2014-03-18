--Interface and AI notes:
--Available EaActions will appear in the unit panel as "action" or "build", even though they are neither. Those
--that appear as "builds" hijack the build progress graphics.

--The AI is totally Lua controlled for these. On each turn we cycle through people, then we:
-- * figure out available EaActions (not just this tile but anywhere)
-- * calculate net value, considering value and distance to valid target and progress (STRONGLY weight for current EaAction)
-- * pick one or continue current action
-- * drive unit to tile
-- * do EaAction


-- Tables
CREATE TABLE EaActions ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,
						'Type' TEXT NOT NULL UNIQUE,
						'Description' TEXT DEFAULT NULL,
						'Help' TEXT DEFAULT NULL,			--Most help is provided in EaAction.lua; use this only if not set there
						--UI
						'UIType' TEXT DEFAULT NULL,		--Action, SecondaryAction, Build, [Spell, CityAction, CivAction]
						--'OrderPriority' INTEGER DEFAULT 0,
						'IconIndex' INTEGER DEFAULT -1,
						'IconAtlas' TEXT DEFAULT NULL,
						'NoFloatUpText' BOOLEAN DEFAULT NULL,
						--AI
						'AICombatRole' TEXT DEFAULT NULL,	-- =NULL,  "CityCapture", "CrowdControl", "Any"
						'AIDontCombatOverride' BOOLEAN DEFAULT NULL,	-- =NULL or 1 (eg, Citadel) Otherwise, GP with combat role will drop what they are doing (if <1/2 done) and go to a combat zone
						'AITarget'  TEXT DEFAULT NULL,		--"AllCities", "OwnCities", "OwnClosestCity" (Epics), "OwnClosestLibraryCity" (Tomes), "OwnCapital",
															--"ForeignCities", "ForeignCapitals", "WorkPlot", "NonWorkPlot", "Protection" (Fort, Citadel)
															-- AI needs this heuristic so it knows what potential targets to test/evaluate.
															-- Don�t set if AICombatRole has a value. Leave NULL for special actions handled individually in AI code (e.g., leader & city resident).
						'AISimpleYield' INTEGER DEFAULT 0,	-- Sets the "per turn payoff" value (p); not needed if AI values set in specific SetAIValues function in EaAction.lua
						'AIAdHocValue' INTEGER DEFAULT 0,	-- Sets an "instant payoff" value (i); not needed if AI values set in specific SetAIValues function in EaAction.lua
						--Spells (if set, all "caster reqs" below are treated as "learn prereq"; they don't apply to casting)
						'SpellClass' TEXT DEFAULT NULL,	--'Divine', 'Arcane' or NULL
						'FreeSpellSubclass' TEXT DEFAULT NULL,
						'FallenAltSpell' TEXT DEFAULT NULL,
						--Civ reqs
						'TechReq' TEXT DEFAULT NULL,
						'AndTechReq' TEXT DEFAULT NULL,
						'PolicyTrumpsTechReq' TEXT DEFAULT NULL,	--with this policy, TechReq and AndTechReq ignored
						'TechDisallow' TEXT DEFAULT NULL,
						'PolicyReq' TEXT DEFAULT NULL,
						'OrPolicyReq' TEXT DEFAULT NULL,
						'ReligionNotFounded' TEXT DEFAULT NULL,
						'ReligionFounded' TEXT DEFAULT NULL,
						'CivReligion' TEXT DEFAULT NULL,
						'MaleficiumLearnedByAnyone' BOOLEAN DEFAULT NULL,
						'ExcludeFallen' BOOLEAN DEFAULT NULL,

						--Caster reqs (any EaAction may also have a Lua req defined in EaActions.lua)
						'GPOnly' BOOLEAN DEFAULT NULL,
						'GPClass' TEXT DEFAULT NULL,	
						'NotGPClass' TEXT DEFAULT NULL,		
						'GPSubclass' TEXT DEFAULT NULL,	
						'OrGPSubclass' TEXT DEFAULT NULL,
						'ExcludeGPSubclass' TEXT DEFAULT NULL,	
						'LevelReq' INTEGER DEFAULT NULL,
						'PromotionReq' TEXT DEFAULT NULL,
						'PromotionDisallow' TEXT DEFAULT NULL,
						'PromotionDisallow2' TEXT DEFAULT NULL,
						'PromotionDisallow3' TEXT DEFAULT NULL,

						'PantheismCult' TEXT DEFAULT NULL,
						--non-GP caster prereqs
						'UnitCombatType' TEXT DEFAULT NULL,		
						'NormalCombatUnit' BOOLEAN DEFAULT NULL,		
						'UnitType' TEXT DEFAULT NULL,			
						'OrUnitType' TEXT DEFAULT NULL,			
						'OrUnitType2' TEXT DEFAULT NULL,		
						'UnitTypePrefix1' TEXT DEFAULT NULL,	
						'UnitTypePrefix2' TEXT DEFAULT NULL,	
						'UnitTypePrefix3' TEXT DEFAULT NULL,							
						--Target reqs
						'City' TEXT DEFAULT NULL,			--'Own', 'Foreign', 'Any', 'Not' or NULL
						'CapitalOnly' BOOLEAN DEFAULT NULL,
						'BuildingReq' TEXT DEFAULT NULL,
						'OwnTerritory' BOOLEAN DEFAULT NULL,
						'OwnCityRadius' BOOLEAN DEFAULT NULL,
						--'HolyCityDisallow' BOOLEAN DEFAULT NULL,
						--Process
						'GPModType1' TEXT DEFAULT NULL,
						'GPModType2' TEXT DEFAULT NULL,
						'ApplyTowerTempleMod' BOOLEAN DEFAULT NULL,
						'NoGPNumLimit' BOOLEAN DEFAULT NULL,
						'FinishMoves' BOOLEAN DEFAULT 1,
						'StayInvisible' BOOLEAN DEFAULT NULL,
						--'Disappear' BOOLEAN DEFAULT NULL,		--DEPRECIATED
						'TurnsToComplete' INTEGER DEFAULT 1,	--1 immediate; >1 will run until done; 1000 means run forever for human (changes to 8 for AI; so resident will wake up and look around)
						'ProgressHolder' TEXT DEFAULT NULL,			--Person, City or CityCiv or Plot
						'BuildType' TEXT DEFAULT NULL,				--if above is Plot then this should be a valid BuildType
						'GoldCostPerBuildTurn' INTEGER DEFAULT 0,
						'ProductionCostPerBuildTurn' INTEGER DEFAULT 0,
						'UniqueType' TEXT DEFAULT NULL,			-- "National" or "World"
						'BuildingUnderConstruction' TEXT DEFAULT NULL,		--to show under construction when started
						'DoXP' INTEGER DEFAULT 0,
						'DoGainPromotion' TEXT DEFAULT NULL,
						'FixedFaith' INTEGER DEFAULT 0,		--NOT YET IMPLEMENTED
						--Do or Finish sound and FX
						'HumanOnlyFX' INTEGER DEFAULT NULL,		--only one FX now, so it is just a nil test (will be specific ID later)
						'HumanVisibleFX' INTEGER DEFAULT NULL,	--any player but must be visible plot (don't use at same time as above)
						'HumanOnlySound' TEXT DEFAULT NULL,		--"AS2D_INTERFACE_NEW_ERA" works
						'HumanVisibleSound' TEXT DEFAULT NULL,
						'PlayAnywhereSound' TEXT DEFAULT NULL,
						--Do effect (only works when TurnsToComplete = 1)
						'UnitUpgradeTypePrefix' TEXT DEFAULT NULL,
						--Finish effect (only works when TurnsToComplete > 1)
						'ImprovementType' TEXT DEFAULT NULL,		--must be set with BuildType	
						'ClaimsPlot' BOOLEAN DEFAULT NULL,			--works to radius 10 for now
						'FoundsSpreadsCult' TEXT DEFAULT NULL,
						'Building' TEXT DEFAULT NULL,		--this building already present acts as target disallow
						'BuildingMod' TEXT DEFAULT NULL,	--adds mod instances of this building; this building already present acts as target disallow
						'EaWonder' TEXT DEFAULT NULL,
						'EaEpic' TEXT DEFAULT NULL,
						'EaArtifact' TEXT DEFAULT NULL,
						'FinishXP' INTEGER DEFAULT 0);

INSERT INTO EaActions (ID,	Type,			Description,			GPOnly) VALUES
(0,	'EA_ACTION_GO_TO_PLOT',			'TXT_KEY_EA_NOTSHOWN',	1		);	--special action; must have ID = 0


--StayInvisible

--Order here is the order they will appear in actions or builds panel (all before core game actions and builds)

--Non-GP
INSERT INTO EaActions (Type,			Description,							Help,										UnitTypePrefix1,	NormalCombatUnit,	UIType,		AITarget,		City,	IconIndex,	IconAtlas) VALUES
('EA_ACTION_SELL_SLAVES',				'TXT_KEY_EA_ACTION_SELL_SLAVES',		'TXT_KEY_EA_ACTION_SELL_SLAVE_HELP',		'UNIT_SLAVES',		NULL,				'Action',	'OwnCities',	'Own',	17,			'TECH_ATLAS_1'	),
('EA_ACTION_RENDER_SLAVES',				'TXT_KEY_EA_ACTION_RENDER_SLAVES',		'TXT_KEY_EA_ACTION_RENDER_SLAVE_HELP',		'UNIT_SLAVES',		NULL,				'Action',	'OwnCities',	'Own',	5,			'TECH_ATLAS_1'	),
('EA_ACTION_HIRE_OUT_MERC',				'TXT_KEY_EA_ACTION_HIRE_OUT_MERC',		'TXT_KEY_EA_ACTION_HIRE_OUT_MERC_HELP',		NULL,				1,					'Action',	'Self',			NULL,	17,			'TECH_ATLAS_1'	),
('EA_ACTION_CANC_HIRE_OUT_MERC',		'TXT_KEY_EA_ACTION_CANC_HIRE_OUT_MERC',	'TXT_KEY_EA_ACTION_CANC_HIRE_OUT_MERC_HELP',NULL,				1,					'Action',	'Self',			NULL,	17,			'TECH_ATLAS_1'	);

UPDATE EaActions SET BuildingReq = 'BUILDING_SLAVE_MARKET' WHERE Type = 'EA_ACTION_SELL_SLAVES';
UPDATE EaActions SET BuildingReq = 'BUILDING_SLAVE_KNACKERY' WHERE Type = 'EA_ACTION_RENDER_SLAVES';
UPDATE EaActions SET FinishMoves = NULL, PolicyReq = 'POLICY_MERCENARIES', PromotionDisallow = 'PROMOTION_FOR_HIRE', PromotionDisallow2 = 'PROMOTION_MERCENARY', PromotionDisallow3 = 'PROMOTION_SLAVE' WHERE Type = 'EA_ACTION_HIRE_OUT_MERC';
UPDATE EaActions SET FinishMoves = NULL, PolicyReq = 'POLICY_MERCENARIES', PromotionReq = 'PROMOTION_FOR_HIRE' WHERE Type = 'EA_ACTION_CANC_HIRE_OUT_MERC';

--Non-GP alternate upgrades
INSERT INTO EaActions (Type,			Description,				UnitTypePrefix1,		UnitTypePrefix2,		UnitTypePrefix3,	TechReq,				UnitUpgradeTypePrefix) VALUES
('EA_ACTION_UPGRD_MED_INF',				'TXT_KEY_COMMAND_UPGRADE',	'UNIT_WARRIORS',		NULL,					NULL,				'TECH_IRON_WORKING',	'UNIT_MEDIUM_INFANTRY'	),
('EA_ACTION_UPGRD_HEAVY_INF',			'TXT_KEY_COMMAND_UPGRADE',	'UNIT_RANGERS',			NULL,					NULL,				'TECH_METAL_CASTING',	'UNIT_HEAVY_INFANTRY'	),
('EA_ACTION_UPGRD_IMMORTALS',			'TXT_KEY_COMMAND_UPGRADE',	'UNIT_WARRIORS',		'UNIT_LIGHT_INFANTRY',	'UNIT_RANGERS',		'TECH_MITHRIL_WORKING',	'UNIT_IMMORTALS'		),
('EA_ACTION_UPGRD_ARQUEBUSSMEN',		'TXT_KEY_COMMAND_UPGRADE',	'UNIT_ARCHERS',			NULL,					NULL,				'TECH_MACHINERY',		'UNIT_ARQUEBUSSMEN'		),
('EA_ACTION_UPGRD_BOWMEN',				'TXT_KEY_COMMAND_UPGRADE',	'UNIT_TRACKERS',		NULL,					NULL,				'TECH_BOWYERS',			'UNIT_BOWMEN'			),
('EA_ACTION_UPGRD_MARKSMEN',			'TXT_KEY_COMMAND_UPGRADE',	'UNIT_BOWMEN',			'UNIT_RANGERS',			NULL,				'TECH_BOWYERS',			'UNIT_MARKSMEN'			),
('EA_ACTION_UPGRD_SAGITARII',			'TXT_KEY_COMMAND_UPGRADE',	'UNIT_BOWED_CAVALRY',	NULL,					NULL,				'TECH_BOWYERS',			'UNIT_SAGITARII'		),
('EA_ACTION_UPGRD_ARMORED_CAV',			'TXT_KEY_COMMAND_UPGRADE',	'UNIT_HORSEMEN',		NULL,					NULL,				'TECH_HORSEBACK_RIDING','UNIT_ARMORED_CAVALRY'	),
('EA_ACTION_UPGRD_CATAPHRACTS',			'TXT_KEY_COMMAND_UPGRADE',	'UNIT_EQUITES',			'UNIT_RANGERS',			NULL,				'TECH_WAR_HORSES',		'UNIT_CATAPHRACTS'		),
('EA_ACTION_UPGRD_CLIBANARII',			'TXT_KEY_COMMAND_UPGRADE',	'UNIT_EQUITES',			'UNIT_RANGERS',			NULL,				'TECH_WAR_HORSES',		'UNIT_CLIBANARII'		),
('EA_ACTION_UPGRD_F_CATAPULTS',			'TXT_KEY_COMMAND_UPGRADE',	'UNIT_CATAPULTS',		NULL,					NULL,				'TECH_MATHEMATICS',		'UNIT_FIRE_CATAPULTS'	),
('EA_ACTION_UPGRD_F_TREBUCHETS',		'TXT_KEY_COMMAND_UPGRADE',	'UNIT_TREBUCHETS',		NULL,					NULL,				'TECH_MECHANICS',		'UNIT_FIRE_TREBUCHETS'	),
('EA_ACTION_UPGRD_SLAVES_WARRIORS',		'TXT_KEY_COMMAND_UPGRADE',	'UNIT_SLAVES',			NULL,					NULL,				NULL,					'UNIT_WARRIORS'			);

UPDATE EaActions SET UIType = 'Action', AITarget = 'Self', OwnTerritory = 1, IconIndex = 44, IconAtlas = 'UNIT_ACTION_ATLAS' WHERE UnitUpgradeTypePrefix IS NOT NULL;
UPDATE EaActions SET NormalCombatUnit = 1 WHERE UnitUpgradeTypePrefix IS NOT NULL AND Type != 'EA_ACTION_UPGRD_SLAVES_WARRIORS';
UPDATE EaActions SET LevelReq = 6 WHERE Type IN ('EA_ACTION_UPGRD_MARKSMEN', 'EA_ACTION_UPGRD_SAGITARII');
UPDATE EaActions SET PolicyReq = 'POLICY_SLAVE_ARMIES' WHERE Type = 'EA_ACTION_UPGRD_SLAVES_WARRIORS';

--GP actions
--Common actions
INSERT INTO EaActions (Type,			Description,							Help,										GPOnly,	UIType,		AITarget,		City,	GPModType1,			ProgressHolder,	IconIndex,	IconAtlas) VALUES
('EA_ACTION_TAKE_LEADERSHIP',			'TXT_KEY_EA_ACTION_TAKE_LEADERSHIP',	'TXT_KEY_EA_ACTION_TAKE_LEADERSHIP_HELP',	1,		'Action',	'OwnCapital',	'Own',	'EAMOD_LEADERSHIP',	NULL,			0,			'EA_ACTION_ATLAS'	),
('EA_ACTION_TAKE_RESIDENCE',			'TXT_KEY_EA_ACTION_TAKE_RESIDENCE',		NULL,										1,		'Action',	'OwnCities',	'Own',	'EAMOD_LEADERSHIP',	'Person',		40,			'UNIT_ACTION_ATLAS'	),
--('EA_ACTION_JOIN',					'TXT_KEY_EA_ACTION_JOIN',				NULL,										1,		'Action',	NULL,			NULL,	NULL,				NULL,			18,			'UNIT_ACTION_ATLAS' ),
('EA_ACTION_HEAL',						'TXT_KEY_EA_ACTION_HEAL',				NULL,										1,		'Action',	'Self',			NULL,	NULL,				NULL,			40,			'UNIT_ACTION_ATLAS'	);

UPDATE EaActions SET CapitalOnly = 1, DoXP = 20 WHERE Type = 'EA_ACTION_TAKE_LEADERSHIP';
UPDATE EaActions SET TurnsToComplete = 1000 WHERE Type = 'EA_ACTION_TAKE_RESIDENCE';
UPDATE EaActions SET AICombatRole = 'Any', TurnsToComplete = 1, StayInvisible = 1 WHERE Type = 'EA_ACTION_HEAL';
--


--GP yield actions
INSERT INTO EaActions (Type,			Description,						Help,										GPOnly,	NoGPNumLimit,	UIType,		AITarget,			GPClass,	City,		GPModType1,				TurnsToComplete,	ProgressHolder,	IconIndex,	IconAtlas) VALUES
('EA_ACTION_BUILD',						'TXT_KEY_EA_ACTION_BUILD',			'TXT_KEY_EA_ACTION_BUILD_HELP',				1,		1,				'Action',	'OwnClosestCity',	'Engineer',	'Own',		'EAMOD_CONSTRUCTION',	1000,				'Person',		5,			'TECH_ATLAS_1'			),
('EA_ACTION_TRADE',						'TXT_KEY_EA_ACTION_TRADE',			'TXT_KEY_EA_ACTION_TRADE_HELP',				1,		1,				'Action',	'OwnClosestCity',	'Merchant',	'Own',		'EAMOD_TRADE',			1000,				'Person',		17,			'TECH_ATLAS_1'			),
('EA_ACTION_RESEARCH',					'TXT_KEY_EA_ACTION_RESEARCH',		'TXT_KEY_EA_ACTION_RESEARCH_HELP',			1,		1,				'Action',	'OwnClosestCity',	'Sage',		'Own',		'EAMOD_SCHOLARSHIP',	1000,				'Person',		11,			'BW_ATLAS_1'			),
('EA_ACTION_PERFORM',					'TXT_KEY_EA_ACTION_PERFORM',		'TXT_KEY_EA_ACTION_PERFORM_HELP',			1,		1,				'Action',	'OwnClosestCity',	'Artist',	'Own',		'EAMOD_BARDING',		1000,				'Person',		44,			'BW_ATLAS_1'			),
('EA_ACTION_WORSHIP',					'TXT_KEY_EA_ACTION_WORSHIP',		'TXT_KEY_EA_ACTION_WORSHIP_HELP',			1,		1,				'Action',	'OwnClosestCity',	'Devout',	'Own',		'EAMOD_PROSELYTISM',	1000,				'Person',		17,			'BW_ATLAS_2'			);

UPDATE EaActions SET GPModType2 = 'EAMOD_RITUALISM' WHERE Type = 'EA_ACTION_WORSHIP';


--Warrior actions
INSERT INTO EaActions (Type,			Description,							Help,										GPOnly,	UIType,		GPClass,	AITarget,		AICombatRole,	GPModType1,				TurnsToComplete,	HumanVisibleFX,	IconIndex,	IconAtlas) VALUES
('EA_ACTION_LEAD_CHARGE',				'TXT_KEY_EA_ACTION_LEAD_CHARGE',		'TXT_KEY_EA_ACTION_LEAD_CHARGE_HELP',		1,		'Action',	'Warrior',	NULL,			'Any',			'EAMOD_COMBAT',			1,					1,				6,			'BW_ATLAS_1'	),
('EA_ACTION_RALLY_TROOPS',				'TXT_KEY_EA_ACTION_RALLY_TROOPS',		'TXT_KEY_EA_ACTION_RALLY_TROOPS_HELP',		1,		'Action',	'Warrior',	NULL,			'Any',			'EAMOD_LEADERSHIP',		1,					1,				33,			'TECH_ATLAS_1'	),
--('EA_ACTION_FORTIFY_TROOPS',			'TXT_KEY_EA_ACTION_FORTIFY_TROOPS',		'TXT_KEY_EA_ACTION_FORTIFY_TROOPS_HELP',	1,		'Action',	'Warrior',	NULL,			'Any',			'EAMOD_LEADERSHIP',		1,					1,				6,			'BW_ATLAS_1'	),
('EA_ACTION_TRAIN_UNIT',				'TXT_KEY_EA_ACTION_TRAIN_UNIT',			'TXT_KEY_EA_ACTION_TRAIN_UNIT_HELP',		1,		'Action',	'Warrior',	'OwnLandUnits',	NULL,			'EAMOD_LEADERSHIP',		1000,				1,				5,			'BW_ATLAS_1'	);

UPDATE EaActions SET FinishMoves = NULL, GPModType2 = 'EAMOD_LEADERSHIP' WHERE Type = 'EA_ACTION_LEAD_CHARGE';

--Prophecies
INSERT INTO EaActions (Type,			Description,								Help,											GPOnly,	UIType,		DoXP,	AITarget,		AIAdHocValue,	GPClass,	City,		UniqueType,	PlayAnywhereSound,					IconIndex,	IconAtlas) VALUES
('EA_ACTION_PROPHECY_AHURADHATA',		'TXT_KEY_EA_ACTION_PROPHECY_AHURADHATA',	'TXT_KEY_EA_ACTION_PROPHECY_AHURADHATA_HELP',	1,		'Action',	100,	'OwnCities',	10000,			'Devout',	'Own',		'World',	'AS2D_EVENT_NOTIFICATION_GOOD',		16,			'EXPANSION_UNIT_ATLAS_1'			),
('EA_ACTION_PROPHECY_MITHRA',			'TXT_KEY_EA_ACTION_PROPHECY_MITHRA',		'TXT_KEY_EA_ACTION_PROPHECY_MITHRA_HELP',		1,		'Action',	100,	'OwnCities',	10000,			'Devout',	'Own',		'World',	'AS2D_EVENT_NOTIFICATION_GOOD',		16,			'EXPANSION_UNIT_ATLAS_1'			),
('EA_ACTION_PROPHECY_MA',				'TXT_KEY_EA_ACTION_PROPHECY_MA',			'TXT_KEY_EA_ACTION_PROPHECY_MA_HELP',			1,		'Action',	100,	'OwnCities',	0,				'Devout',	'Own',		'World',	'AS2D_EVENT_NOTIFICATION_GOOD',		16,			'EXPANSION_UNIT_ATLAS_1'			),
('EA_ACTION_PROPHECY_VA',				'TXT_KEY_EA_ACTION_PROPHECY_VA',			'TXT_KEY_EA_ACTION_PROPHECY_VA_HELP',			1,		'Action',	100,	'Self',			0,				'Devout',	NULL,		'World',	'AS2D_EVENT_NOTIFICATION_VERY_BAD',	16,			'EXPANSION_UNIT_ATLAS_1'			),
('EA_ACTION_PROPHECY_ANRA',				'TXT_KEY_EA_ACTION_PROPHECY_ANRA',			'TXT_KEY_EA_ACTION_PROPHECY_ANRA_HELP',			1,		'Action',	100,	'OwnCities',	10000,			'Devout',	'Own',		'World',	'AS2D_EVENT_NOTIFICATION_VERY_BAD',	16,			'EXPANSION_UNIT_ATLAS_1'			),
('EA_ACTION_PROPHECY_AESHEMA',			'TXT_KEY_EA_ACTION_PROPHECY_AESHEMA',		'TXT_KEY_EA_ACTION_PROPHECY_AESHEMA_HELP',		1,		'Action',	100,	'Self',			0,				NULL,		NULL,		'World',	'AS2D_EVENT_NOTIFICATION_VERY_BAD',	16,			'EXPANSION_UNIT_ATLAS_1'			);

UPDATE EaActions SET ReligionNotFounded = 'RELIGION_AZZANDARAYASNA', PolicyReq = 'POLICY_THEISM', TechDisallow = 'TECH_MALEFICIUM', ExcludeFallen = 1 WHERE Type = 'EA_ACTION_PROPHECY_AHURADHATA';
UPDATE EaActions SET ReligionNotFounded = 'RELIGION_ANRA', TechReq = 'TECH_MALEFICIUM' WHERE Type = 'EA_ACTION_PROPHECY_ANRA';
UPDATE EaActions SET MaleficiumLearnedByAnyone = 1 WHERE Type = 'EA_ACTION_PROPHECY_VA';
UPDATE EaActions SET ReligionFounded = 'RELIGION_AZZANDARAYASNA', PolicyReq = 'POLICY_THEISM', TechDisallow = 'TECH_MALEFICIUM', CivReligion = 'RELIGION_AZZANDARAYASNA', ExcludeFallen = 1 WHERE Type = 'EA_ACTION_PROPHECY_MITHRA';
UPDATE EaActions SET DoGainPromotion = 'PROMOTION_PROPHET' WHERE Type GLOB 'EA_ACTION_PROPHECY_*';

--Wonders
INSERT INTO EaActions (Type,			Description,								GPOnly,	TechReq,				UIType,		FinishXP,	AITarget,			GPClass,		City,	OwnCityRadius,	GPModType1,				TurnsToComplete,	ProductionCostPerBuildTurn,	ProgressHolder,	BuildType,				ImprovementType,			UniqueType,	EaWonder,						BuildingUnderConstruction,	Building,					BuildingMod,					IconIndex,	IconAtlas) VALUES
('EA_ACTION_STANHENCG',					'TXT_KEY_EA_ACTION_STANHENCG',				1,		NULL,					'Build',	100,		'OwnCities',		'Devout',		'Own',	NULL,			'EAMOD_RITUALISM',		25,					0,							'City',			NULL,					NULL,						'World',	'EA_WONDER_STANHENCG',			'BUILDING_STANHENCG',		'BUILDING_STANHENCG',		'BUILDING_STANHENCG_MOD',		2,			'BW_ATLAS_2'			),
('EA_ACTION_KOLOSSOS',					'TXT_KEY_EA_ACTION_KOLOSSOS',				1,		'TECH_BRONZE_WORKING',	'Build',	100,		'OwnCities',		'Engineer',		'Own',	NULL,			'EAMOD_CONSTRUCTION',	25,					0,							'City',			NULL,					NULL,						'World',	'EA_WONDER_KOLOSSOS',			'BUILDING_KOLOSSOS',		'BUILDING_KOLOSSOS',		'BUILDING_KOLOSSOS_MOD',		4,			'BW_ATLAS_2'			),
('EA_ACTION_MEGALOS_FAROS',				'TXT_KEY_EA_ACTION_MEGALOS_FAROS',			1,		'TECH_SAILING',			'Build',	100,		'OwnCities',		'Engineer',		'Own',	NULL,			'EAMOD_CONSTRUCTION',	25,					0,							'City',			NULL,					NULL,						'World',	'EA_WONDER_MEGALOS_FAROS',		'BUILDING_MEGALOS_FAROS',	'BUILDING_MEGALOS_FAROS',	'BUILDING_MEGALOS_FAROS_MOD',	5,			'BW_ATLAS_2'			),
('EA_ACTION_HANGING_GARDENS',			'TXT_KEY_EA_ACTION_HANGING_GARDENS',		1,		'TECH_IRRIGATION',		'Build',	100,		'OwnCities',		'Engineer',		'Own',	NULL,			'EAMOD_CONSTRUCTION',	25,					0,							'City',			NULL,					NULL,						'World',	'EA_WONDER_HANGING_GARDENS',	'BUILDING_HANGING_GARDENS',	'BUILDING_HANGING_GARDENS',	'BUILDING_HANGING_GARDENS_MOD',	3,			'BW_ATLAS_2'			),
('EA_ACTION_UUC_YABNAL',				'TXT_KEY_EA_ACTION_UUC_YABNAL',				1,		'TECH_MASONRY',			'Build',	100,		'OwnCities',		'Engineer',		'Own',	NULL,			'EAMOD_CONSTRUCTION',	25,					0,							'City',			NULL,					NULL,						'World',	'EA_WONDER_UUC_YABNAL',			'BUILDING_UUC_YABNAL',		'BUILDING_UUC_YABNAL',		'BUILDING_UUC_YABNAL_MOD',		12,			'BW_ATLAS_2'			),
('EA_ACTION_THE_LONG_WALL',				'TXT_KEY_EA_ACTION_THE_LONG_WALL',			1,		'TECH_CONSTRUCTION',	'Build',	100,		'OwnCities',		'Engineer',		'Own',	NULL,			'EAMOD_CONSTRUCTION',	25,					0,							'City',			NULL,					NULL,						'World',	'EA_WONDER_THE_LONG_WALL',		'BUILDING_THE_LONG_WALL',	'BUILDING_THE_LONG_WALL',	'BUILDING_THE_LONG_WALL_MOD',	7,			'BW_ATLAS_2'			),
('EA_ACTION_CLOG_MOR',					'TXT_KEY_EA_ACTION_CLOG_MOR',				1,		'TECH_MACHINERY',		'Build',	100,		'OwnCities',		'Engineer',		'Own',	NULL,			'EAMOD_CONSTRUCTION',	25,					0,							'City',			NULL,					NULL,						'World',	'EA_WONDER_CLOG_MOR',			'BUILDING_CLOG_MOR',		'BUILDING_CLOG_MOR',		'BUILDING_CLOG_MOR_MOD',		19,			'BW_ATLAS_2'			),
('EA_ACTION_DA_BAOEN_SI',				'TXT_KEY_EA_ACTION_DA_BAOEN_SI',			1,		'TECH_ARCHITECTURE',	'Build',	100,		'OwnCities',		'Engineer',		'Own',	NULL,			'EAMOD_CONSTRUCTION',	25,					0,							'City',			NULL,					NULL,						'World',	'EA_WONDER_DA_BAOEN_SI',		'BUILDING_DA_BAOEN_SI',		'BUILDING_DA_BAOEN_SI',		'BUILDING_DA_BAOEN_SI_MOD',		16,			'BW_ATLAS_2'			),
--('EA_ACTION_GREAT_LIBRARY',			'TXT_KEY_EA_ACTION_GREAT_LIBRARY',			1,		'TECH_WRITING',			'Build',	100,		'OwnCities',		'Sage',			'Own',	NULL,			'EAMOD_SCHOLARSHIP',	25,					0,							'City',			NULL,					NULL,						'World',	'EA_WONDER_GREAT_LIBRARY',		'BUILDING_GREAT_LIBRARY',	'BUILDING_GREAT_LIBRARY',	NULL,							1,			'BW_ATLAS_2'			),	--Ughhh. This CTDs when completed. Did not CTD when substituting BUILDING_UUC_YABNAL. 'EA_WONDER_GREAT_LIBRARY',		'BUILDING_GREAT_LIBRARY',	'BUILDING_GREAT_LIBRARY',	'BUILDING_GREAT_LIBRARY_MOD'
('EA_ACTION_NATIONAL_TREASURY',			'TXT_KEY_EA_ACTION_NATIONAL_TREASURY',		1,		'TECH_COINAGE',			'Build',	100,		'OwnCities',		'Merchant',		'Own',	NULL,			'EAMOD_TRADE',			25,					0,							'City',			NULL,					NULL,						'National',	NULL,							NULL,						NULL,						'BUILDING_NATIONAL_TREASURY',	1,			'NEW_BLDG_ATLAS_DLC'	),
('EA_ACTION_ARCANE_TOWER',				'TXT_KEY_EA_ACTION_ARCANE_TOWER',			1,		'TECH_THAUMATURGY',		'Build',	100,		'WonderNoWorkPlot',	'Thaumaturge',	'Not',	1,				NULL,					4,					0,							'Plot',			'BUILD_ARCANE_TOWER',	'IMPROVEMENT_ARCANE_TOWER',	NULL,		NULL,							NULL,						NULL,						NULL,							3,			'UNIT_ACTION_ATLAS_EXP2'	);

UPDATE EaActions SET PolicyReq = 'POLICY_PANTHEISM', GPSubclass = 'Druid' WHERE Type = 'EA_ACTION_STANHENCG';
UPDATE EaActions SET AndTechReq = 'TECH_MASONRY' WHERE Type = 'EA_ACTION_MEGALOS_FAROS';
UPDATE EaActions SET PolicyReq = 'POLICY_SLAVERY' WHERE Type = 'EA_ACTION_UUC_YABNAL';
UPDATE EaActions SET PolicyReq = 'POLICY_SCHOLASTICISM' WHERE Type = 'EA_ACTION_GREAT_LIBRARY';
UPDATE EaActions SET NotGPClass = 'Devout' WHERE Type = 'EA_ACTION_ARCANE_TOWER';


--Epics
INSERT INTO EaActions (Type,			Description,								Help,											GPOnly,	TechReq,				PolicyReq,			UIType,		FinishXP,	AITarget,			AIAdHocValue,	GPClass,	City,		GPModType1,			TurnsToComplete,	ProgressHolder,	UniqueType,	EaEpic,							IconIndex,	IconAtlas) VALUES
('EA_ACTION_EPIC_VOLUSPA',				'TXT_KEY_EA_ACTION_EPIC_VOLUSPA',			'TXT_KEY_EA_ACTION_EPIC_VOLUSPA_HELP',			1,		NULL,					'POLICY_TRADITION',	'Build',	100,		'OwnClosestCity',	1000,			'Artist',	'Any',		'EAMOD_BARDING',	25,					'Person',		'World',	'EA_EPIC_VOLUSPA',				32,			'BW_ATLAS_2'			),
('EA_ACTION_EPIC_HAVAMAL',				'TXT_KEY_EA_ACTION_EPIC_HAVAMAL',			'TXT_KEY_EA_ACTION_EPIC_HAVAMAL_HELP',			1,		NULL,					'POLICY_FOLKLORE',	'Build',	100,		'OwnClosestCity',	1000,			'Artist',	'Any',		'EAMOD_BARDING',	25,					'Person',		'World',	'EA_EPIC_HAVAMAL',				32,			'BW_ATLAS_2'			),
('EA_ACTION_EPIC_VAFTHRUTHNISMAL',		'TXT_KEY_EA_ACTION_EPIC_VAFTHRUTHNISMAL',	'TXT_KEY_EA_ACTION_EPIC_VAFTHRUTHNISMAL_HELP',	1,		'TECH_WRITING',			'POLICY_FOLKLORE',	'Build',	100,		'OwnClosestCity',	1000,			'Artist',	'Any',		'EAMOD_BARDING',	25,					'Person',		'World',	'EA_EPIC_VAFTHRUTHNISMAL',		32,			'BW_ATLAS_2'			),
('EA_ACTION_EPIC_GRIMNISMAL',			'TXT_KEY_EA_ACTION_EPIC_GRIMNISMAL',		'TXT_KEY_EA_ACTION_EPIC_GRIMNISMAL_HELP',		1,		'TECH_DRAMA',			'POLICY_FOLKLORE',	'Build',	100,		'OwnClosestCity',	1000,			'Artist',	'Any',		'EAMOD_BARDING',	25,					'Person',		'World',	'EA_EPIC_GRIMNISMAL',			32,			'BW_ATLAS_2'			),
('EA_ACTION_EPIC_HYMISKVITHA',			'TXT_KEY_EA_ACTION_EPIC_HYMISKVITHA',		'TXT_KEY_EA_ACTION_EPIC_HYMISKVITHA_HELP',		1,		'TECH_ZYMURGY',			'POLICY_FOLKLORE',	'Build',	100,		'OwnClosestCity',	1000,			'Artist',	'Any',		'EAMOD_BARDING',	25,					'Person',		'World',	'EA_EPIC_HYMISKVITHA',			32,			'BW_ATLAS_2'			),
('EA_ACTION_EPIC_NATIONAL',				'TXT_KEY_EA_ACTION_EPIC_NATIONAL',			'TXT_KEY_EA_ACTION_EPIC_NATIONAL_HELP',			1,		'TECH_LITERATURE',		NULL,				'Build',	100,		'OwnClosestCity',	1000,			'Artist',	'Any',		'EAMOD_BARDING',	25,					'Person',		'National',	NULL,							32,			'BW_ATLAS_2'			);

--Items
INSERT INTO EaActions (Type,			Description,								Help,											GPOnly,	TechReq,					AndTechReq,		BuildingReq,		UIType,		FinishXP,	AITarget,					AIAdHocValue,	GPClass,	City,	GPModType1,				TurnsToComplete,	ProgressHolder,	UniqueType,	EaArtifact,							IconIndex,	IconAtlas) VALUES
('EA_ACTION_TOME_OF_EQUUS',				'TXT_KEY_EA_ACTION_TOME_OF_EQUUS',			'TXT_KEY_EA_ACTION_TOME_OF_EQUUS_HELP',			1,		'TECH_HORSEBACK_RIDING',	'TECH_WRITING',	'BUILDING_LIBRARY',	'Build',	100,		'OwnClosestLibraryCity',	1000,			'Sage',		'Own',	'EAMOD_SCHOLARSHIP',	25,					'Person',		'World',	'EA_ARTIFACT_TOME_OF_EQUUS',		2,			'EXPANSION_SCEN_TECH_ATLAS'			),
('EA_ACTION_TOME_OF_BEASTS',			'TXT_KEY_EA_ACTION_TOME_OF_BEASTS',			'TXT_KEY_EA_ACTION_TOME_OF_BEASTS_HELP',		1,		'TECH_ELEPHANT_TRAINING',	'TECH_WRITING',	'BUILDING_LIBRARY',	'Build',	100,		'OwnClosestLibraryCity',	1000,			'Sage',		'Own',	'EAMOD_SCHOLARSHIP',	25,					'Person',		'World',	'EA_ARTIFACT_TOME_OF_BEASTS',		2,			'EXPANSION_SCEN_TECH_ATLAS'			),
('EA_ACTION_TOME_OF_THE_LEVIATHAN',		'TXT_KEY_EA_ACTION_TOME_OF_THE_LEVIATHAN',	'TXT_KEY_EA_ACTION_TOME_OF_THE_LEVIATHAN_HELP',	1,		'TECH_HARPOONS',			'TECH_WRITING',	'BUILDING_LIBRARY',	'Build',	100,		'OwnClosestLibraryCity',	1000,			'Sage',		'Own',	'EAMOD_SCHOLARSHIP',	25,					'Person',		'World',	'EA_ARTIFACT_TOME_OF_THE_LEVIATHAN',2,			'EXPANSION_SCEN_TECH_ATLAS'			),
('EA_ACTION_TOME_OF_HARVESTS',			'TXT_KEY_EA_ACTION_TOME_OF_HARVESTS',		'TXT_KEY_EA_ACTION_TOME_OF_HARVESTS_HELP',		1,		'TECH_IRRIGATION',			'TECH_WRITING',	'BUILDING_LIBRARY',	'Build',	100,		'OwnClosestLibraryCity',	1000,			'Sage',		'Own',	'EAMOD_SCHOLARSHIP',	25,					'Person',		'World',	'EA_ARTIFACT_TOME_OF_HARVESTS',		2,			'EXPANSION_SCEN_TECH_ATLAS'			),
('EA_ACTION_TOME_OF_TOMES',				'TXT_KEY_EA_ACTION_TOME_OF_TOMES',			'TXT_KEY_EA_ACTION_TOME_OF_TOMES_HELP',			1,		'TECH_PHILOSOPHY',			'TECH_WRITING',	'BUILDING_LIBRARY',	'Build',	100,		'OwnClosestLibraryCity',	1000,			'Sage',		'Own',	'EAMOD_SCHOLARSHIP',	25,					'Person',		'World',	'EA_ARTIFACT_TOME_OF_TOMES',		2,			'EXPANSION_SCEN_TECH_ATLAS'			),
('EA_ACTION_TOME_OF_AESTHETICS',		'TXT_KEY_EA_ACTION_TOME_OF_AESTHETICS',		'TXT_KEY_EA_ACTION_TOME_OF_AESTHETICS_HELP',	1,		'TECH_DRAMA',				'TECH_WRITING',	'BUILDING_LIBRARY',	'Build',	100,		'OwnClosestLibraryCity',	1000,			'Sage',		'Own',	'EAMOD_SCHOLARSHIP',	25,					'Person',		'World',	'EA_ARTIFACT_TOME_OF_AESTHETICS',	2,			'EXPANSION_SCEN_TECH_ATLAS'			),
('EA_ACTION_TOME_OF_AXIOMS',			'TXT_KEY_EA_ACTION_TOME_OF_AXIOMS',			'TXT_KEY_EA_ACTION_TOME_OF_AXIOMS_HELP',		1,		'TECH_MATHEMATICS',			'TECH_WRITING',	'BUILDING_LIBRARY',	'Build',	100,		'OwnClosestLibraryCity',	1000,			'Sage',		'Own',	'EAMOD_SCHOLARSHIP',	25,					'Person',		'World',	'EA_ARTIFACT_TOME_OF_AXIOMS',		2,			'EXPANSION_SCEN_TECH_ATLAS'			),
('EA_ACTION_TOME_OF_FORM',				'TXT_KEY_EA_ACTION_TOME_OF_FORM',			'TXT_KEY_EA_ACTION_TOME_OF_FORM_HELP',			1,		'TECH_MASONRY',				'TECH_WRITING',	'BUILDING_LIBRARY',	'Build',	100,		'OwnClosestLibraryCity',	1000,			'Sage',		'Own',	'EAMOD_SCHOLARSHIP',	25,					'Person',		'World',	'EA_ARTIFACT_TOME_OF_FORM',			2,			'EXPANSION_SCEN_TECH_ATLAS'			),
('EA_ACTION_TOME_OF_METALLURGY',		'TXT_KEY_EA_ACTION_TOME_OF_METALLURGY',		'TXT_KEY_EA_ACTION_TOME_OF_METALLURGY_HELP',	1,		'TECH_BRONZE_WORKING',		'TECH_WRITING',	'BUILDING_LIBRARY',	'Build',	100,		'OwnClosestLibraryCity',	1000,			'Sage',		'Own',	'EAMOD_SCHOLARSHIP',	25,					'Person',		'World',	'EA_ARTIFACT_TOME_OF_METALLURGY',	2,			'EXPANSION_SCEN_TECH_ATLAS'			);

--GP non-unique builds
INSERT INTO EaActions (Type,			Description,							Help,								GPOnly,	UIType,		TechReq,				PolicyReq,				FinishXP,	AITarget,		AISimpleYield,	GPClass,	City,		GPModType1,		TurnsToComplete,	GoldCostPerBuildTurn,	ProductionCostPerBuildTurn,	ProgressHolder,	Building,				BuildingMod,			HumanOnlySound,			IconIndex,	IconAtlas) VALUES
('EA_ACTION_FOUNDRY',					'TXT_KEY_EA_ACTION_FOUNDRY',			'TXT_KEY_EA_ACTION_FOUNDRY_HELP',	1,		'Build',	'TECH_IRON_WORKING',	NULL,					25,			'OwnCities',	3,				'Engineer',	'Own',		NULL,			8,					0,						0,							'City',			'BUILDING_FOUNDRY',		NULL,					'AS2D_BUILD_UNIT',		1,			'NEW_BLDG_ATLAS2_DLC'	),
('EA_ACTION_ACADEMY',					'TXT_KEY_EA_ACTION_ACADEMY',			'TXT_KEY_EA_ACTION_ACADEMY_HELP',	1,		'Build',	'TECH_PHILOSOPHY',		NULL,					25,			'OwnCities',	3,				'Sage',		'Own',		NULL,			8,					0,						0,							'City',			'BUILDING_ACADEMY',		NULL,					'AS2D_BUILD_UNIT',		1,			'BW_ATLAS_2'			),
('EA_ACTION_FESTIVAL',					'TXT_KEY_EA_ACTION_FESTIVAL',			'TXT_KEY_EA_ACTION_FESTIVAL_HELP',	1,		'Build',	'TECH_CALENDAR',		NULL,					25,			'OwnCities',	3,				'Artist',	'Own',		NULL,			8,					0,						0,							'City',			'BUILDING_FESTIVAL',	NULL,					'AS2D_BUILD_UNIT',		44,			'BW_ATLAS_1'			),
('EA_ACTION_TEMPLE',					'TXT_KEY_EA_ACTION_TEMPLE',				'TXT_KEY_EA_ACTION_TEMPLE_HELP',	1,		'Build',	NULL,					'POLICY_PRIESTHOOD',	25,			'OwnCities',	3,				'Devout',	'Own',		NULL,			8,					0,						0,							'City',			'BUILDING_TEMPLE',		NULL,					'AS2D_BUILD_UNIT',		37,			'BW_ATLAS_1'			),
('EA_ACTION_TRADE_HOUSE',				'TXT_KEY_EA_ACTION_TRADE_HOUSE',		NULL,								1,		'Build',	NULL,					'POLICY_FREE_MARKETS',	25,			'OwnCities',	0,				'Merchant',	'Own',		'EAMOD_TRADE',	8,					0,						0,							'City',			NULL,					'BUILDING_TRADE_HOUSE',	'AS2D_BUILD_UNIT',		1,			'NEW_BLDG_ATLAS_DLC'	);

UPDATE EaActions SET OrPolicyReq = 'POLICY_FELLOWSHIP_OF_LEAVES' WHERE Type = 'EA_ACTION_TEMPLE';

--Other GP builds
INSERT INTO EaActions (Type,			Description,							GPOnly,	UIType,		TechReq,			PolicyReq,				FinishXP,	AITarget,			GPClass,	GPSubclass,		FoundsSpreadsCult,	City,		GPModType1,				TurnsToComplete,	GoldCostPerBuildTurn,	ProgressHolder,	HumanOnlySound,			PlayAnywhereSound,					IconIndex,	IconAtlas) VALUES
('EA_ACTION_LAND_TRADE_ROUTE',			'TXT_KEY_EA_ACTION_LAND_TRADE_ROUTE',	1,		'Action',	'TECH_CURRENCY',	NULL,					25,			'LandTradeCities',	'Merchant',	NULL,			NULL,				'Any',		NULL,					8,					0,						'CityCiv',		'AS2D_BUILD_UNIT',		NULL,								0,			'UNIT_ACTION_ATLAS_TRADE'	),
('EA_ACTION_SEA_TRADE_ROUTE',			'TXT_KEY_EA_ACTION_SEA_TRADE_ROUTE',	1,		'Action',	'TECH_SAILING',		NULL,					25,			'SeaTradeCities',	'Merchant',	NULL,			NULL,				'Any',		NULL,					8,					0,						'CityCiv',		'AS2D_BUILD_UNIT',		NULL,								0,			'UNIT_ACTION_ATLAS_TRADE'	),
('EA_ACTION_TRADE_MISSION',				'TXT_KEY_EA_ACTION_TRADE_MISSION',		1,		'Action',	NULL,				'POLICY_FREE_TRADE',	100,		'ForeignCapitals',	'Merchant',	NULL,			NULL,				'Foreign',	'EAMOD_TRADE',			25,					0,						'CityCiv',		'AS2D_BUILD_UNIT',		NULL,								17,			'TECH_ATLAS_1'				);

UPDATE EaActions SET CapitalOnly = 1 WHERE Type = 'EA_ACTION_TRADE_MISSION';


--Religious conversion and cult founding
INSERT INTO EaActions (Type,			Description,							GPOnly,	UIType,		TechReq,				PolicyReq,				ReligionFounded,			FinishXP,	AITarget,			GPClass,	GPSubclass,		FoundsSpreadsCult,				City,		GPModType1,				TurnsToComplete,	GoldCostPerBuildTurn,	ProgressHolder,	HumanOnlySound,			PlayAnywhereSound,					IconIndex,	IconAtlas) VALUES
('EA_ACTION_PROSELYTIZE',				'TXT_KEY_EA_ACTION_PROSELYTIZE',		1,		'Action',	NULL,					NULL,					'RELIGION_AZZANDARAYASNA',	25,			'AzzandaraSpread',	'Devout',	'Priest',		NULL,							'Any',		'EAMOD_PROSELYTISM',	8,					0,						'City',			NULL,					'AS2D_EVENT_NOTIFICATION_GOOD',		1,			'EXPANSION_UNIT_ACTION_ATLAS'	),
('EA_ACTION_ANTIPROSELYTIZE',			'TXT_KEY_EA_ACTION_PROSELYTIZE',		1,		'Action',	NULL,					NULL,					'RELIGION_ANRA',			25,			'AnraSpread',		'Devout',	'FallenPriest',	NULL,							'Any',		'EAMOD_PROSELYTISM',	8,					0,						'City',			NULL,					'AS2D_EVENT_NOTIFICATION_VERY_BAD',	1,			'EXPANSION_UNIT_ACTION_ATLAS'	),
('EA_ACTION_RITUAL_LEAVES',				'TXT_KEY_EA_ACTION_RITUAL_LEAVES',		1,		'Build',	NULL,					NULL,					'RELIGION_THE_WEAVE_OF_EA',	25,			'AllCities',		'Devout',	'Druid',		'RELIGION_CULT_OF_LEAVES',		'Any',		'EAMOD_RITUALISM',		8,					0,						'City',			NULL,					'AS2D_EVENT_NOTIFICATION_GOOD',		2,			'BW_ATLAS_2'					),
('EA_ACTION_RITUAL_EQUUS',				'TXT_KEY_EA_ACTION_RITUAL_EQUUS',		1,		'Build',	NULL,					NULL,					'RELIGION_THE_WEAVE_OF_EA',	25,			'AllCities',		'Devout',	'Druid',		'RELIGION_CULT_OF_EPONA',		'Any',		'EAMOD_RITUALISM',		8,					0,						'City',			NULL,					'AS2D_EVENT_NOTIFICATION_GOOD',		2,			'BW_ATLAS_2'					),
('EA_ACTION_RITUAL_CLEANSING',			'TXT_KEY_EA_ACTION_RITUAL_CLEANSING',	1,		'Build',	NULL,					NULL,					'RELIGION_THE_WEAVE_OF_EA',	25,			'AllCities',		'Devout',	'Druid',		'RELIGION_CULT_OF_PURE_WATERS',	'Any',		'EAMOD_RITUALISM',		8,					0,						'City',			NULL,					'AS2D_EVENT_NOTIFICATION_GOOD',		2,			'BW_ATLAS_2'					),
('EA_ACTION_RITUAL_AEGIR',				'TXT_KEY_EA_ACTION_RITUAL_AEGIR',		1,		'Build',	NULL,					NULL,					'RELIGION_THE_WEAVE_OF_EA',	25,			'AllCities',		'Devout',	'Druid',		'RELIGION_CULT_OF_AEGIR',		'Any',		'EAMOD_RITUALISM',		8,					0,						'City',			NULL,					'AS2D_EVENT_NOTIFICATION_GOOD',		2,			'BW_ATLAS_2'					),
('EA_ACTION_RITUAL_BAKKHEIA',			'TXT_KEY_EA_ACTION_RITUAL_BAKKHEIA',	1,		'Build',	NULL,					NULL,					'RELIGION_THE_WEAVE_OF_EA',	25,			'AllCities',		'Devout',	'Druid',		'RELIGION_CULT_OF_BAKKHEIA',	'Any',		'EAMOD_RITUALISM',		8,					0,						'City',			NULL,					'AS2D_EVENT_NOTIFICATION_GOOD',		2,			'BW_ATLAS_2'					);

UPDATE EaActions SET OrGPSubclass = 'Paladin' WHERE Type = 'EA_ACTION_PROSELYTIZE';
UPDATE EaActions SET OrGPSubclass = 'Eidolon' WHERE Type = 'EA_ACTION_ANTIPROSELYTIZE';



-----------------------------------------------------------------------------------------
--Spells (MUST come last!)
-----------------------------------------------------------------------------------------
-- These are EaActions but treated in a special way: All non-target prereqs are only "learn" prereqs
-- The spell is always castable if it is known and target is valid and player has sufficient mana or divine favor.

--Arcane
INSERT INTO EaActions (Type,			SpellClass,	GPModType1,				TechReq,						City,	AITarget,			AICombatRole,	TurnsToComplete,	FixedFaith,	HumanVisibleFX,	IconIndex,	IconAtlas) VALUES

('EA_SPELL_MAGIC_MISSILE',				'Arcane',	'EAMOD_EVOCATION',		'TECH_THAUMATURGY',				NULL,	NULL,				'Any',			1,					0,			NULL,			7,			'TECH_ATLAS_2'			),
('EA_SPELL_BLIGHT',						'Arcane',	'EAMOD_TRANSMUTATION',	'TECH_MALEFICIUM',				'Not',	'NIMBY',			NULL,			5,					0,			1,				9,			'TECH_ATLAS_2'			),
('EA_SPELL_HEX',						'Arcane',	'EAMOD_NECROMANCY',		'TECH_MALEFICIUM',				NULL,	NULL,				'Any',			1,					0,			1,				9,			'TECH_ATLAS_2'			);

--Divine
INSERT INTO EaActions (Type,			SpellClass,	GPModType1,				TechReq,						City,	AITarget,			AICombatRole,	FallenAltSpell,		TurnsToComplete,	FixedFaith,	HumanVisibleFX,	IconIndex,	IconAtlas) VALUES
('EA_SPELL_HEAL',						'Divine',	'EAMOD_CONJURATION',	NULL,							NULL,	NULL,				'Any',			'EA_SPELL_HURT',	1,					0,			1,				3,			'UNIT_ACTION_ATLAS'		),
('EA_SPELL_BLESS',						'Divine',	'EAMOD_CONJURATION',	'TECH_DIVINE_LITURGY',			NULL,	NULL,				'Any',			'EA_SPELL_CURSE',	1,					0,			1,				38,			'BW_ATLAS_1'			),
('EA_SPELL_PROTECTION_FROM_EVIL',		'Divine',	'EAMOD_CONJURATION',	'TECH_DIVINE_LITURGY',			NULL,	NULL,				'Any',			'EA_SPELL_EVIL_EYE',1,					0,			1,				38,			'BW_ATLAS_1'			),

--fallen
('EA_SPELL_HURT',						'Divine',	'EAMOD_NECROMANCY',		NULL,							NULL,	NULL,				'Any',			'IsFallen',			1,					0,			1,				9,			'TECH_ATLAS_2'			),
('EA_SPELL_CURSE',						'Divine',	'EAMOD_NECROMANCY',		'TECH_MALEFICIUM',				NULL,	NULL,				'Any',			'IsFallen',			1,					0,			1,				9,			'TECH_ATLAS_2'			),
('EA_SPELL_EVIL_EYE',					'Divine',	'EAMOD_NECROMANCY',		'TECH_MALEFICIUM',				NULL,	NULL,				'Any',			'IsFallen',			1,					0,			1,				9,			'TECH_ATLAS_2'			),

--druid only learned
('EA_SPELL_EAS_BLESSING',				'Divine',	'EAMOD_TRANSMUTATION',	NULL,							'Not',	'NearbyLivTerrain',	NULL,			NULL,				5,					0,			1,				10,			'EXPANSION_BW_ATLAS_2'	);


--druid cult spells (learned from ritual)
INSERT INTO EaActions (Type,			SpellClass,	GPModType1,				PantheismCult,					City,	AITarget,			AICombatRole,		TurnsToComplete,	FixedFaith,	HumanVisibleFX,	IconIndex,	IconAtlas) VALUES
('EA_SPELL_BLOOM',						'Divine',	'EAMOD_TRANSMUTATION',	'RELIGION_CULT_OF_LEAVES',		'Not',	'NearbyNonFeature',	NULL,				5,					0,			1,				10,			'EXPANSION_BW_ATLAS_2'		),
('EA_SPELL_RIDE_LIKE_THE_WIND',			'Divine',	'EAMOD_CONJURATION',	'RELIGION_CULT_OF_EPONA',		NULL,	NULL,				'Any',				1,					0,			1,				9,			'EXPANSION_SCEN_UNIT_ATLAS'	),
('EA_SPELL_PURIFY',						'Divine',	'EAMOD_CONJURATION',	'RELIGION_CULT_OF_PURE_WATERS',	NULL,	NULL,				'Any',				1,					0,			1,				1,			'NW_ATLAS_DLC'				),
('EA_SPELL_FAIR_WINDS',					'Divine',	'EAMOD_CONJURATION',	'RELIGION_CULT_OF_AEGIR',		NULL,	'OwnNavalUnits',	NULL,				1,					0,			1,				3,			'EXPANSION_SCEN_TECH_ATLAS'	),
('EA_SPELL_REVELRY',					'Divine',	'EAMOD_CONJURATION',	'RELIGION_CULT_OF_BAKKHEIA',	'Own',	'OwnClosestCity',	NULL,				1000,				0,			1,				44,			'BW_ATLAS_1'				);


--Build out the table for dependent strings
UPDATE EaActions SET Description = 'TXT_KEY_' || Type, Help = 'TXT_KEY_' || Type || '_HELP' WHERE Type GLOB 'EA_SPELL_*';
UPDATE EaActions SET GPOnly = 1, ApplyTowerTempleMod = 1, UIType = 'Build' WHERE Type GLOB 'EA_SPELL_*';		--need spell UI
UPDATE EaActions SET ProgressHolder = 'Person' WHERE Type GLOB 'EA_SPELL_*' AND TurnsToComplete > 1;




UPDATE EaActions SET PolicyTrumpsTechReq = 'POLICY_WITCHCRAFT' WHERE Type IN ('EA_SPELL_HEX');
UPDATE EaActions SET GPModType2 = 'EAMOD_DEVOTION' WHERE SpellClass = 'Divine';

UPDATE EaActions SET PolicyReq = 'POLICY_PANTHEISM' WHERE Type = 'EA_SPELL_EAS_BLESSING';
UPDATE EaActions SET FreeSpellSubclass = 'Priest' WHERE Type = 'EA_SPELL_HEAL';
UPDATE EaActions SET FreeSpellSubclass = 'FallenPriest' WHERE Type = 'EA_SPELL_HURT';


UPDATE EaActions SET ProgressHolder = 'Person' WHERE ProgressHolder IS NULL AND TurnsToComplete > 1;		--needs to be something

-----------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------
--UPDATE EaActions SET TechReq = NULL;
--UPDATE EaActions SET AndTechReq = NULL;
--UPDATE EaActions SET PolicyReq = NULL;
--UPDATE EaActions SET PantheismCult = NULL;
--UPDATE EaActions SET TechReq = NULL WHERE Type = 'EA_ACTION_TRADE_ROUTE';
--UPDATE EaActions SET BuildingReq = NULL, AITarget = 'OwnClosestCity' WHERE Type GLOB 'EA_ACTION_TOME_*';

--AutoplayDebug
--UPDATE EaActions SET TechReq = 'TECH_NEVER' WHERE Type IN ('EA_ACTION_PROSELYTIZE', 'EA_ACTION_ANTIPROSELYTIZE', 'EA_ACTION_PROPHECY_MITHRA',
--'EA_ACTION_PROPHECY_MA', 'EA_ACTION_PROPHECY_VA', 'EA_ACTION_PROPHECY_ANRA', 'EA_ACTION_PROPHECY_AESHEMA', 'EA_ACTION_WORSHIP');

-----------------------------------------------------------------------------------------
-- Subtables
-----------------------------------------------------------------------------------------




INSERT INTO EaDebugTableCheck(FileName) SELECT 'EaActions.sql';