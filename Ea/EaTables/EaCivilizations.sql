
--This file defines EaCivilizations, which are not exactly the same as Civ5 civilizations.
--Real Civ5 Civilizations are built entirely by SQL using data from this file (so Civilizations.sql must run after this file).


CREATE TABLE EaCivs (	'ID' INTEGER PRIMARY KEY AUTOINCREMENT,	
						'Type' TEXT NOT NULL UNIQUE,
						'EaCivString' TEXT DEFAULT NULL,
						'Description' TEXT DEFAULT NULL,			-- will be same in Civilizations table
						'ShortDescription' TEXT DEFAULT NULL,		-- will be same in Civilizations table
						'Adjective' TEXT DEFAULT NULL,				-- will be same in Civilizations table
						'CivilopediaTag' TEXT DEFAULT NULL,			-- will be same in Civilizations table
						'Help' TEXT DEFAULT NULL,	
						'Quote'	TEXT DEFAULT NULL,
						'SpecialTriggerText' TEXT DEFAULT NULL,	-- use only for extra Lua trigger
						'DefaultPlayerColor' TEXT DEFAULT NULL,
						'PopupText' TEXT DEFAULT NULL,
						'PopupImage' TEXT DEFAULT NULL,
						'CapitalName' TEXT DEFAULT NULL,
						'IconAtlas' TEXT DEFAULT NULL,
						'PortraitIndex' INTEGER DEFAULT 0,
						--Prereqs (any civ can also have Lua Req and/or Do functions; these are in EaCivNaming.lua and not listed here)
						'KnownTech' TEXT DEFAULT NULL,
						'AndKnownTech' TEXT DEFAULT NULL,
						'AdoptedPolicy' TEXT DEFAULT NULL,
						'OrAdoptedPolicy1' TEXT DEFAULT NULL,
						'OrAdoptedPolicy2' TEXT DEFAULT NULL,
						'AndAdoptedPolicy' TEXT DEFAULT NULL,
						'BuildingType' TEXT DEFAULT NULL,
						'UnitClass' TEXT DEFAULT NULL,
						'OrUnitClass' TEXT DEFAULT NULL,		--note: used for race variations; or's are NOT shown in UI
						'OrUnitClass2' TEXT DEFAULT NULL,
						'CapitalNearbyResourceType' TEXT DEFAULT NULL,
						'CapitalNearbyResourceNumber' INTEGER DEFAULT NULL,
						'ImprovedResType' TEXT DEFAULT NULL,
						'OrImprovedResType' TEXT DEFAULT NULL,
						'ImprovedResNumber' INTEGER DEFAULT NULL,
						'ImprovementType' TEXT DEFAULT NULL,
						'OrImprovementType' TEXT DEFAULT NULL,
						'ImprovementNumber' INTEGER DEFAULT NULL,
						--effects (all civs have an automatically generated trait in Traits table in Civilizations.sql; add trait effectS there)
						'FoundingGPClass' TEXT DEFAULT NULL,	
						'FoundingGPSubclass' TEXT DEFAULT NULL,	
						'FoundingGPType' TEXT DEFAULT NULL,			--class or subclass must be defined
						'FavoredGPClass' TEXT DEFAULT NULL,	
						'GainPolicy' TEXT DEFAULT NULL,				--either normal policy or "hidden policies" that drive many effects (this is the most common effect)
						'GainCapitalBuilding' TEXT DEFAULT NULL,
						'PopResourceNearCapital' TEXT DEFAULT NULL,
						--AI
						'AIMercHire' INTEGER DEFAULT 0);			-- -100 for supplier; +value is gold treasury needed before civ considers hiring


----------------------------------------------------------------------------------------------------
-- Civ "naming" traits (tier 1) - priority to 1st if conditions met simultaniously
----------------------------------------------------------------------------------------------------

--INSERT INTO EaCivs (Type,		Description,						CivAdjective,						Tier,	Race)
--SELECT 'EACIV_TIRINNANOC',	'TXT_KEY_EA_CIV_THE_FAY',	'TXT_KEY_EA_CIV_THE_FAY',	1,		'EARACE_FAY';


-- special triggers


-- tech triggers
INSERT INTO EaCivs (Type,	PopupImage,									DefaultPlayerColor,		KnownTech,					FavoredGPClass,	GainPolicy,						GainCapitalBuilding) VALUES
('EACIV_HIPPUS',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_CHINA',	'TECH_HORSEBACK_RIDING',	'Merchant',		'POLICY_MERCENARIES',			NULL							),
('EACIV_IKKOS',				'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_EGYPT',	'TECH_HORSEBACK_RIDING',	'Warrior',		NULL,							'BUILDING_IKKOS'				),
('EACIV_AB',				'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_ENGLAND',	'TECH_ELEPHANT_TRAINING',	NULL,			NULL,							'BUILDING_AB'					),
('EACIV_FIR_BOLG',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_FRANCE',	'TECH_ANIMAL_HUSBANDRY',	NULL,			'POLICY_EACIV_FIR_BOLG',		NULL							),
('EACIV_CRUITHNI',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_GERMANY',	'TECH_TRACKING_TRAPPING',	NULL,			'POLICY_EACIV_CRUITHNI',		NULL							),
('EACIV_CRECY',				'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_GREECE',	'TECH_ARCHERY',				'Warrior',		'POLICY_EACIV_CRECY',			NULL							),
('EACIV_DAGGOO',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_INDIA',	'TECH_HARPOONS',			NULL,			NULL,							'BUILDING_DAGGOO'				),
('EACIV_FOMHOIRE',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_JAPAN',	'TECH_SAILING',				NULL,			NULL,							'BUILDING_FOMHOIRE'				),
('EACIV_PARAKHORA',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_OTTOMAN',	'TECH_MILLING',				NULL,			NULL,							'BUILDING_CAPITAL_PARAKHORA'	),
('EACIV_NEITH',				'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_OTTOMAN',	'TECH_WEAVING',				'Merchant',		NULL,							NULL							),	--*
('EACIV_ELEUTHERIOS',		'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_ARABIA',	'TECH_ZYMURGY',				'Merchant',		'POLICY_EACIV_ELEUTHERIOS',		NULL							),
('EACIV_NINKASI',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_PERSIA',	'TECH_ZYMURGY',				'Artist',		NULL,							NULL							),
('EACIV_GIRNAR',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_ROME',		'TECH_IRRIGATION',			NULL,			NULL,							NULL							),	--do something with G&K dutch improv
('EACIV_ALDEBAR',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_RUSSIA',	'TECH_CALENDAR',			NULL,			'POLICY_EACIV_ALDEBAR',			NULL							),
('EACIV_ANAPHORA',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_AZTEC',	'TECH_DIVINE_LITURGY',		'Devout',		NULL,							NULL							),
('EACIV_ISALLIN',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_SIAM',		'TECH_DIVINE_LITURGY',		NULL,			'POLICY_EACIV_ISALLIN',			NULL							),
('EACIV_STYGIA',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_BYZANTIUM','TECH_MALEFICIUM',			'Thaumaturge',	NULL,							NULL							),
('EACIV_MORIQUENDI',		'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_AMERICA',	'TECH_MALEFICIUM',			'Thaumaturge',	NULL,							NULL							),	--*
('EACIV_LEMURIA',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_AMERICA',	'TECH_THAUMATURGY',			'Thaumaturge',	NULL,							NULL							),	--*
('EACIV_AXAGORIA',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_CARTHAGE',	'TECH_PHILOSOPHY',			'Sage',			'POLICY_EACIV_AXAGORIA',		NULL							),
('EACIV_IACCHIA',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_ETHIOPIA',	'TECH_DRAMA',				'Artist',		'POLICY_EACIV_IACCHIA',			NULL							),
('EACIV_LAGAD',				'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_MAYA',		'TECH_MATHEMATICS',			'Sage',			NULL,							NULL							),
('EACIV_MAMONAS',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_NETHERLANDS','TECH_COINAGE',			'Merchant',		NULL,							'BUILDING_MAMONAS'				),
('EACIV_SOPHRONIA',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_SWEDEN',	'TECH_MASONRY',				'Engineer',		'POLICY_EACIV_SOPHRONIA',		NULL							),
('EACIV_LUCHTAIN',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_SPAIN',	'TECH_MASONRY',				'Engineer',		'POLICY_EACIV_LUCHTAIN',		NULL							),
('EACIV_VINCA',				'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_ASSYRIA',	'TECH_BRONZE_WORKING',		'Warrior',		NULL,							NULL							),
('EACIV_GOBANN',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_BRAZIL',	'TECH_BRONZE_WORKING',		'Warrior',		NULL,							NULL							);
--('EACIV_UR',				'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_INDONESIA','TECH_DEEP_MINING',			NULL,			NULL,							NULL							),
--('EACIV_ORKAHAUGR',			'testbackground_1.17_856x700.dds',			'PLAYERCOLOR_MOROCCO',	'TECH_DEEP_ROADS',			NULL,			'POLICY_EACIV_ORKAHAUGR',		NULL							);

UPDATE EaCivs SET AdoptedPolicy = 'POLICY_COMMERCE', AIMercHire = -100 WHERE Type = 'EACIV_HIPPUS';
UPDATE EaCivs SET CapitalNearbyResourceType = 'RESOURCE_WINE', CapitalNearbyResourceNumber = 2 WHERE Type = 'EACIV_ELEUTHERIOS';
UPDATE EaCivs SET CapitalNearbyResourceType = 'RESOURCE_INCENSE', CapitalNearbyResourceNumber = 2 WHERE Type = 'EACIV_ANAPHORA';
UPDATE EaCivs SET PopResourceNearCapital = 'RESOURCE_YEW' WHERE Type = 'EACIV_CRECY';	
UPDATE EaCivs SET PopResourceNearCapital = 'RESOURCE_STONE' WHERE Type IN ('EACIV_SOPHRONIA', 'EACIV_LUCHTAIN');
UPDATE EaCivs SET PopResourceNearCapital = 'RESOURCE_STONE', FoundingGPClass = 'Engineer', FoundingGPType = 'EAPERSON_SOPHRONISCUS' WHERE Type = 'EACIV_SOPHRONIA';	
UPDATE EaCivs SET PopResourceNearCapital = 'RESOURCE_STONE', FoundingGPClass = 'Engineer', FoundingGPType = 'EAPERSON_LUCHTA' WHERE Type = 'EACIV_LUCHTAIN';	
UPDATE EaCivs SET FoundingGPClass = 'Engineer', FoundingGPType = 'EAPERSON_GOIBNIU' WHERE Type = 'EACIV_GOBANN';	


-- policy triggers
INSERT INTO EaCivs (Type,	PopupImage,								DefaultPlayerColor,		AdoptedPolicy,				FoundingGPClass,	FoundingGPSubclass,	FoundingGPType,	FavoredGPClass,	GainPolicy,					GainCapitalBuilding) VALUES
('EACIV_REYNES',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_ARABIA',	'POLICY_ARISTOCRACY',		NULL,				NULL,				NULL,			NULL,			NULL,						NULL						),	--*
('EACIV_BJARMALAND',		'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_AZTEC',	'POLICY_GUILDS',			NULL,				NULL,				NULL,			NULL,			NULL,						NULL						),	--*
('EACIV_KAZA',				'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_CHINA',	'POLICY_CIVIL_SERVICE',		NULL,				NULL,				NULL,			NULL,			'POLICY_EACIV_KAZA',		NULL						),
('EACIV_EOGANACHTA',		'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_EGYPT',	'POLICY_ARISTOCRACY',		NULL,				NULL,				NULL,			NULL,			NULL,						NULL						),	--*
('EACIV_SKOGR',				'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_ENGLAND',	'POLICY_ANIMAL_LORE',		NULL,				'Druid',			NULL,			'Devout',		NULL,						NULL						),
('EACIV_BANBA',				'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_FRANCE',	'POLICY_ANIMAL_LORE',		NULL,				'Druid',			NULL,			'Devout',		NULL,						NULL						),	--*
('EACIV_ERIU',				'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_GERMANY',	'POLICY_WOODS_LORE',		NULL,				'Druid',			NULL,			'Devout',		NULL,						NULL						),
('EACIV_FODLA',				'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_GREECE',	'POLICY_EARTH_LORE',		NULL,				'Druid',			NULL,			'Devout',		NULL,						NULL						),	--*
('EACIV_YESOD',				'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_PORTUGAL',	'POLICY_WAY_OF_THE_WISE',	'Devout',			'Priest',			NULL,			'Devout',		NULL,						'BUILDING_CAPITAL_YESOD'	),
('EACIV_NETZACH',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_SHOSHONE',	'POLICY_MYSTICISM',			'Devout',			'Priest',			NULL,			'Devout',		NULL,						'BUILDING_CAPITAL_NETZACH'	),
('EACIV_HOD',				'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_POLAND',	'POLICY_PRIESTHOOD',		'Devout',			'Priest',			NULL,			'Devout',		'POLICY_EACIV_HOD',			NULL						),
('EACIV_O',					'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_INDIA',	'POLICY_ARCANE_TRADITION',	'Thaumaturge',		'Wizard',			NULL,			'Thaumaturge',	NULL,						NULL						),	--*
('EACIV_MU',				'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_MOROCCO',	'POLICY_ARCANE_TRADITION',	'Thaumaturge',		'Wizard',			NULL,			'Thaumaturge',	NULL,						NULL						),	--*
('EACIV_GRAEAE',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_JAPAN',	'POLICY_WITCHCRAFT',		'Thaumaturge',		'Witch',			NULL,			'Thaumaturge',	NULL,						NULL						),
('EACIV_NEZELIBA',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_OTTOMAN',	'POLICY_SLAVE_TRADE',		NULL,				NULL,				NULL,			NULL,			NULL,						NULL						),
('EACIV_GAZIYA',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_PERSIA',	'POLICY_SLAVE_RAIDERS',		NULL,				NULL,				NULL,			NULL,			NULL,						NULL						),	--*
('EACIV_NEMEDIA',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_ROME',		'POLICY_DISCIPLINE',		'Warrior',			NULL,				NULL,			'Warrior',		'POLICY_EACIV_NEMEDIA',		NULL						),
('EACIV_MILESIA',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_RUSSIA',	'POLICY_WARCRAFT',			'Warrior',			NULL,				NULL,			'Warrior',		'POLICY_EACIV_NEMEDIA',		NULL						),	--*
('EACIV_ULFHETHNAR',		'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_SIAM',		'POLICY_WARSPIRIT',			'Warrior',			'Berserker',		NULL,			'Warrior',		'POLICY_EACIV_NEMEDIA',		NULL						),	--*
('EACIV_MORRIGNA',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_SONGHAI',	'POLICY_DISCIPLINE',		'Warrior',			NULL,				NULL,			'Warrior',		'POLICY_EACIV_NEMEDIA',		NULL						),	--*
('EACIV_MACHAE',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_AUSTRIA',	'POLICY_WARCRAFT',			'Warrior',			NULL,				NULL,			'Warrior',		'POLICY_EACIV_NEMEDIA',		NULL						),	--*
('EACIV_BODWA',				'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_BYZANTIUM','POLICY_WARSPIRIT',			'Warrior',			'Berserker',		NULL,			'Warrior',		'POLICY_EACIV_NEMEDIA',		NULL						),	--*
--('EACIV_MORD',				'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_AMERICA',	'POLICY_MILITARISM',		'Warrior',			NULL,				NULL,			'Warrior',		'POLICY_EACIV_LOTHIN',		NULL						),
('EACIV_THEANON',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_CARTHAGE',	'POLICY_SCHOLASTICISM',		'Sage',				NULL,				NULL,			'Sage',			NULL,						NULL						),
('EACIV_SAGUENAY',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_CELTS',	'POLICY_FOLKART',			'Artist',			NULL,				NULL,			'Artist',		NULL,						NULL						),	--*
('EACIV_ALBION',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_ETHIOPIA',	'POLICY_FOLKLORE',			'Artist',			NULL,				NULL,			'Artist',		NULL,						NULL						),	--*
('EACIV_TIR_ECNE',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_MAYA',		'POLICY_SCHOLASTICISM',		'Sage',				NULL,				NULL,			'Sage',			NULL,						NULL						),	--*
('EACIV_NOUDONT',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_NETHERLANDS','POLICY_FOLKART',			'Artist',			NULL,				NULL,			'Artist',		NULL,						NULL						),	--*
('EACIV_AES_DANA',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_SWEDEN',	'POLICY_FOLKLORE',			'Artist',			NULL,				NULL,			'Artist',		NULL,						NULL						),
('EACIV_SUDDENE',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_SPAIN',	'POLICY_MERCANTILISM',		'Merchant',			NULL,				NULL,			'Merchant',		NULL,						NULL						),	--*
('EACIV_PARTHOLON',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_BRAZIL',	'POLICY_CULTURAL_DIPLOMACY','Merchant',			NULL,				NULL,			'Merchant',		NULL,						NULL						),
('EACIV_DAL_FIATACH',		'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_INDONESIA','POLICY_MERCANTILISM',		'Merchant',			NULL,				NULL,			'Merchant',		NULL,						NULL						),	--*
('EACIV_DAIRINE',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_MOROCCO',	'POLICY_CULTURAL_DIPLOMACY','Merchant',			NULL,				NULL,			'Merchant',		NULL,						NULL						),	--*
('EACIV_MOR',				'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_POLAND',	'POLICY_MERCENARIES',		'Merchant',			NULL,				NULL,			'Merchant',		'POLICY_EACIV_MOR',			NULL						),	--*
('EACIV_DOKKALFAR',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_PORTUGAL',	'POLICY_DOMINIONISM',		NULL,				NULL,				NULL,			NULL,			NULL,						NULL						),	--*
('EACIV_LJOSALFAR',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_VENICE',	'POLICY_PANTHEISM',			NULL,				NULL,				NULL,			NULL,			NULL,						NULL						),	--*
('EACIV_SEGOYIM',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_ZULU',		'POLICY_PANTHEISM',			NULL,				NULL,				NULL,			NULL,			NULL,						NULL						);	--*

UPDATE EaCivs SET OrAdoptedPolicy1 = 'POLICY_GUILDS', OrAdoptedPolicy2 = 'POLICY_CIVIL_SERVICE'  WHERE Type = 'EACIV_EOGANACHTA';
UPDATE EaCivs SET OrAdoptedPolicy1 = 'POLICY_WOODS_LORE', OrAdoptedPolicy2 = 'POLICY_EARTH_LORE'  WHERE Type = 'EACIV_SKOGR';
UPDATE EaCivs SET OrAdoptedPolicy1 = 'POLICY_SOCIO_ARCANA' WHERE Type = 'EACIV_O';
UPDATE EaCivs SET OrAdoptedPolicy1 = 'POLICY_SOCIO_ARCANA' WHERE Type = 'EACIV_MU';
UPDATE EaCivs SET OrAdoptedPolicy1 = 'POLICY_DEBT_BONDAGE' WHERE Type = 'EACIV_NEZELIBA';
UPDATE EaCivs SET AndAdoptedPolicy = 'POLICY_SLAVERY' WHERE Type = 'EACIV_DOKKALFAR';
UPDATE EaCivs SET AndAdoptedPolicy = 'POLICY_TRADITION' WHERE Type = 'EACIV_LJOSALFAR';
UPDATE EaCivs SET AndAdoptedPolicy = 'POLICY_ARCANA' WHERE Type = 'EACIV_SEGOYIM';

--improvement triggers
INSERT INTO EaCivs (Type,	PopupImage,								DefaultPlayerColor,		ImprovementType,				OrImprovementType,	ImprovementNumber,	FavoredGPClass,	GainPolicy) VALUES
('EACIV_HY_BREASIL',		'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_GERMANY',	'IMPROVEMENT_FISHING_BOATS',	NULL,				3,					'Merchant',		NULL			),
('EACIV_AGARTHA',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_GREECE',	'IMPROVEMENT_MINE',				NULL,				2,					'Engineer',		NULL			);

-- building triggers
INSERT INTO EaCivs (Type,	PopupImage,								DefaultPlayerColor,		BuildingType,			FavoredGPClass,	GainPolicy,					GainCapitalBuilding) VALUES
('EACIV_YS',				'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_VENICE',	'BUILDING_LIBRARY',		'Sage',			'POLICY_EACIV_YS',			NULL						),
('EACIV_TYRE',				'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_ZULU',		'BUILDING_MARKETPLACE',	'Merchant',		NULL,						'BUILDING_CAPITAL_TYRE'		),
('EACIV_GERZAH',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_ARABIA',	'BUILDING_FORGE',		'Engineer',		NULL,						'BUILDING_CAPITAL_GERZAH'	),
('EACIV_PALARE',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_AZTEC',	'BUILDING_FAIR',		'Artist',		'POLICY_EACIV_PALARE',		'BUILDING_CAPITAL_PALARE'	);

-- unit triggers
INSERT INTO EaCivs (Type,	PopupImage,								DefaultPlayerColor,		UnitClass,						OrUnitClass,						OrUnitClass2,					FavoredGPClass,	GainPolicy,					GainCapitalBuilding) VALUES
('EACIV_MAYD',				'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_CHINA',	'UNITCLASS_BIREMES',			NULL,								NULL,							'Merchant',		NULL,						'BUILDING_CAPITAL_HY_BREASIL'	),
('EACIV_SISUKAS',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_EGYPT',	'UNITCLASS_LIGHT_INFANTRY_MAN',	'UNITCLASS_LIGHT_INFANTRY_SIDHE',	'UNITCLASS_LIGHT_INFANTRY_ORC',	'Warrior',		'POLICY_EACIV_SISUKAS',	NULL								),
('EACIV_EBOR',				'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_ENGLAND',	'UNITCLASS_MOUNTED_ELEPHANTS',	NULL,								NULL,							'Warrior',		NULL,						NULL							),
('EACIV_PHRYGES',			'testbackground_1.17_856x700.dds',		'PLAYERCOLOR_FRANCE',	'UNITCLASS_HORSEMEN_MAN',		'UNITCLASS_HORSEMEN_SIDHE',			'UNITCLASS_HORSEMEN_ORC',		'Warrior',		'POLICY_EACIV_PHRYGES',	NULL								);



--Build out table from EaCivString
UPDATE EaCivs SET EaCivString = REPLACE(Type, 'EACIV_', '');
UPDATE EaCivs SET Description = 'TXT_KEY_EA_CIV_' || EaCivString, CapitalName = 'TXT_KEY_EA_CAPITAL_' || EaCivString;
UPDATE EaCivs SET Help = Description || '_HELP', Quote = Description || '_QUOTE';
UPDATE EaCivs SET ShortDescription = Description, Adjective = Description, CivilopediaTag = Description || '_PEDIA';			--TO DO: Add these as separate txt keys


UPDATE EaCivs SET PortraitIndex = 5, IconAtlas = 'EXPANSION_CIV_COLOR_ATLAS';		--until these are added above

CREATE TABLE EaCiv_Races ('EaCivNameType' TEXT NOT NULL, 'EaRace' TEXT NOT NULL);
INSERT INTO EaCiv_Races (EaCivNameType, EaRace) VALUES
('EACIV_HIPPUS',		'EARACE_MAN'),
('EACIV_IKKOS',			'EARACE_MAN'),
('EACIV_IKKOS',			'EARACE_SIDHE'),
('EACIV_AB',			'EARACE_MAN'),
('EACIV_AB',			'EARACE_SIDHE'),
('EACIV_AB',			'EARACE_HELDEOFOL'),
('EACIV_FIR_BOLG',		'EARACE_MAN'),
('EACIV_FIR_BOLG',		'EARACE_SIDHE'),
('EACIV_CRUITHNI',		'EARACE_MAN'),
('EACIV_CRUITHNI',		'EARACE_SIDHE'),
('EACIV_CRUITHNI',		'EARACE_HELDEOFOL'),
('EACIV_CRECY',			'EARACE_MAN'),
('EACIV_CRECY',			'EARACE_SIDHE'),
('EACIV_DAGGOO',		'EARACE_MAN'),
('EACIV_DAGGOO',		'EARACE_SIDHE'),
('EACIV_FOMHOIRE',		'EARACE_MAN'),
('EACIV_FOMHOIRE',		'EARACE_SIDHE'),
('EACIV_PARAKHORA',		'EARACE_MAN'),
('EACIV_NEITH',			'EARACE_MAN'),
('EACIV_NEITH',			'EARACE_SIDHE'),
('EACIV_ELEUTHERIOS',	'EARACE_MAN'),
('EACIV_ELEUTHERIOS',	'EARACE_SIDHE'),
('EACIV_NINKASI',		'EARACE_MAN'),
('EACIV_NINKASI',		'EARACE_SIDHE'),
('EACIV_GIRNAR',		'EARACE_MAN'),
('EACIV_ALDEBAR',		'EARACE_MAN'),
('EACIV_ALDEBAR',		'EARACE_SIDHE'),
('EACIV_ANAPHORA',		'EARACE_MAN'),
('EACIV_ISALLIN',		'EARACE_MAN'),
('EACIV_STYGIA',		'EARACE_MAN'),
('EACIV_STYGIA',		'EARACE_HELDEOFOL'),
('EACIV_MORIQUENDI',	'EARACE_SIDHE'),
('EACIV_LEMURIA',		'EARACE_MAN'),
('EACIV_LEMURIA',		'EARACE_SIDHE'),
('EACIV_AXAGORIA',		'EARACE_MAN'),
('EACIV_AXAGORIA',		'EARACE_SIDHE'),
('EACIV_IACCHIA',		'EARACE_MAN'),
('EACIV_IACCHIA',		'EARACE_SIDHE'),
('EACIV_LAGAD',			'EARACE_MAN'),
('EACIV_LAGAD',			'EARACE_SIDHE'),
('EACIV_MAMONAS',		'EARACE_MAN'),
('EACIV_MAMONAS',		'EARACE_SIDHE'),
('EACIV_SOPHRONIA',		'EARACE_MAN'),
('EACIV_LUCHTAIN',		'EARACE_SIDHE'),
('EACIV_VINCA',			'EARACE_MAN'),
('EACIV_GOBANN',		'EARACE_SIDHE'),
--('EACIV_UR',			'EARACE_MAN'),
--('EACIV_UR',			'EARACE_SIDHE'),
--('EACIV_ORKAHAUGR',		'EARACE_HELDEOFOL'),
('EACIV_REYNES',		'EARACE_MAN'),
('EACIV_BJARMALAND',	'EARACE_MAN'),
('EACIV_KAZA',			'EARACE_MAN'),
('EACIV_EOGANACHTA',	'EARACE_SIDHE'),
('EACIV_SKOGR',			'EARACE_MAN'),
('EACIV_BANBA',			'EARACE_SIDHE'),
('EACIV_ERIU',			'EARACE_SIDHE'),
('EACIV_FODLA',			'EARACE_SIDHE'),
('EACIV_YESOD',			'EARACE_MAN'),
('EACIV_NETZACH',		'EARACE_MAN'),
('EACIV_HOD',			'EARACE_MAN'),
('EACIV_O',				'EARACE_MAN'),
('EACIV_MU',			'EARACE_SIDHE'),
('EACIV_GRAEAE',		'EARACE_MAN'),
('EACIV_GRAEAE',		'EARACE_SIDHE'),
('EACIV_GRAEAE',		'EARACE_HELDEOFOL'),
('EACIV_NEZELIBA',		'EARACE_MAN'),
('EACIV_NEZELIBA',		'EARACE_SIDHE'),
('EACIV_NEZELIBA',		'EARACE_HELDEOFOL'),
('EACIV_GAZIYA',		'EARACE_MAN'),
('EACIV_GAZIYA',		'EARACE_SIDHE'),
('EACIV_GAZIYA',		'EARACE_HELDEOFOL'),
('EACIV_NEMEDIA',		'EARACE_MAN'),
('EACIV_MILESIA',		'EARACE_MAN'),
('EACIV_ULFHETHNAR',	'EARACE_MAN'),
('EACIV_MORRIGNA',		'EARACE_SIDHE'),
('EACIV_MACHAE',		'EARACE_SIDHE'),
('EACIV_BODWA',			'EARACE_SIDHE'),
('EACIV_MORD',			'EARACE_HELDEOFOL'),
('EACIV_THEANON',		'EARACE_MAN'),
('EACIV_SAGUENAY',		'EARACE_MAN'),
('EACIV_ALBION',		'EARACE_MAN'),
('EACIV_TIR_ECNE',		'EARACE_SIDHE'),
('EACIV_NOUDONT',		'EARACE_SIDHE'),
('EACIV_AES_DANA',		'EARACE_SIDHE'),
('EACIV_SUDDENE',		'EARACE_MAN'),
('EACIV_PARTHOLON',		'EARACE_MAN'),
('EACIV_DAL_FIATACH',	'EARACE_SIDHE'),
('EACIV_DAIRINE',		'EARACE_SIDHE'),
('EACIV_MOR',			'EARACE_MAN'),
('EACIV_MOR',			'EARACE_SIDHE'),
('EACIV_DOKKALFAR',		'EARACE_SIDHE'),
('EACIV_LJOSALFAR',		'EARACE_SIDHE'),
('EACIV_SEGOYIM',		'EARACE_SIDHE'),
('EACIV_SEGOYIM',		'EARACE_MAN'),
('EACIV_HY_BREASIL',	'EARACE_MAN'),
('EACIV_HY_BREASIL',	'EARACE_SIDHE'),
('EACIV_AGARTHA',		'EARACE_MAN'),
('EACIV_AGARTHA',		'EARACE_SIDHE'),
('EACIV_YS',			'EARACE_MAN'),
('EACIV_YS',			'EARACE_SIDHE'),
('EACIV_TYRE',			'EARACE_MAN'),
('EACIV_TYRE',			'EARACE_SIDHE'),
('EACIV_GERZAH',		'EARACE_MAN'),
('EACIV_GERZAH',		'EARACE_SIDHE'),
('EACIV_GERZAH',		'EARACE_HELDEOFOL'),
('EACIV_PALARE',		'EARACE_MAN'),
('EACIV_PALARE',		'EARACE_SIDHE'),
('EACIV_MAYD',			'EARACE_MAN'),
('EACIV_MAYD',			'EARACE_SIDHE'),
('EACIV_SISUKAS',		'EARACE_MAN'),
('EACIV_SISUKAS',		'EARACE_SIDHE'),
('EACIV_SISUKAS',		'EARACE_HELDEOFOL'),
('EACIV_EBOR',			'EARACE_MAN'),
('EACIV_EBOR',			'EARACE_SIDHE'),
('EACIV_EBOR',			'EARACE_HELDEOFOL'),
('EACIV_PHRYGES',		'EARACE_MAN'),
('EACIV_PHRYGES',		'EARACE_SIDHE');


CREATE TABLE EaCiv_FavoredTechs ('EaCivType' TEXT NOT NULL, 'TechType' TEXT NOT NULL);
INSERT INTO EaCiv_FavoredTechs (EaCivType, TechType) VALUES
('EACIV_HIPPUS',		'TECH_HORSEBACK_RIDING'	),
('EACIV_HIPPUS',		'TECH_ANIMAL_HUSBANDRY'	),
('EACIV_HIPPUS',		'TECH_COINAGE'			),
('EACIV_HIPPUS',		'TECH_STIRRUPS'			),
('EACIV_HIPPUS',		'TECH_ANIMAL_INDUSTRY'	),
('EACIV_HIPPUS',		'TECH_BANKING'			),
('EACIV_HIPPUS',		'TECH_ANIMAL_BREEDING'	),
('EACIV_HIPPUS',		'TECH_WAR_HORSES'		),
('EACIV_IKKOS',			'TECH_HORSEBACK_RIDING'	),
('EACIV_IKKOS',			'TECH_ANIMAL_HUSBANDRY'	),
('EACIV_IKKOS',			'TECH_STIRRUPS'			),
('EACIV_IKKOS',			'TECH_ANIMAL_INDUSTRY'	),
('EACIV_IKKOS',			'TECH_ANIMAL_BREEDING'	),
('EACIV_IKKOS',			'TECH_WAR_HORSES'		),
('EACIV_AB',			'TECH_ELEPHANT_LABOR'	),
('EACIV_AB',			'TECH_TRACKING_TRAPPING'),
('EACIV_AB',			'TECH_ELEPHANT_TRAINING'),
('EACIV_AB',			'TECH_GAMEKEEPING'		),
('EACIV_AB',			'TECH_ANIMAL_MASTERY'	),
('EACIV_AB',			'TECH_WAR_ELEPHANTS'	),
('EACIV_AB',			'TECH_BEAST_MASTERY'	),
('EACIV_AB',			'TECH_MUMAKIL_RIDING'	),
('EACIV_FIR_BOLG',		'TECH_HORSEBACK_RIDING'	),
('EACIV_FIR_BOLG',		'TECH_ANIMAL_HUSBANDRY'	),
('EACIV_FIR_BOLG',		'TECH_ELEPHANT_LABOR'	),
('EACIV_FIR_BOLG',		'TECH_TRACKING_TRAPPING'),
('EACIV_FIR_BOLG',		'TECH_WEAVING'			),
('EACIV_FIR_BOLG',		'TECH_STIRRUPS'			),
('EACIV_FIR_BOLG',		'TECH_ANIMAL_INDUSTRY'	),
('EACIV_FIR_BOLG',		'TECH_ELEPHANT_TRAINING'),
('EACIV_FIR_BOLG',		'TECH_GAMEKEEPING'		),
('EACIV_FIR_BOLG',		'TECH_FINE_TEXTILES'	),
('EACIV_FIR_BOLG',		'TECH_ANIMAL_BREEDING'	),
('EACIV_CRUITHNI',		'TECH_ELEPHANT_LABOR'	),
('EACIV_CRUITHNI',		'TECH_TRACKING_TRAPPING'),
('EACIV_CRUITHNI',		'TECH_ARCHERY'			),
('EACIV_CRUITHNI',		'TECH_ELEPHANT_TRAINING'),
('EACIV_CRUITHNI',		'TECH_GAMEKEEPING'		),
('EACIV_CRUITHNI',		'TECH_BOWYERS'			),
('EACIV_CRUITHNI',		'TECH_ANIMAL_MASTERY'	),
('EACIV_CRUITHNI',		'TECH_BEAST_MASTERY'	),
('EACIV_CRUITHNI',		'TECH_MUMAKIL_RIDING'	),
('EACIV_CRUITHNI',		'TECH_SONG_OF_LEVIATHAN'),
('EACIV_CRECY',			'TECH_HORSEBACK_RIDING'	),
('EACIV_CRECY',			'TECH_TRACKING_TRAPPING'),
('EACIV_CRECY',			'TECH_ARCHERY'			),
('EACIV_CRECY',			'TECH_MATHEMATICS'		),
('EACIV_CRECY',			'TECH_STIRRUPS'			),
('EACIV_CRECY',			'TECH_GAMEKEEPING'		),
('EACIV_CRECY',			'TECH_BOWYERS'			),
('EACIV_CRECY',			'TECH_MECHANICS'		),
('EACIV_CRECY',			'TECH_MARKSMANSHIP'		),
('EACIV_DAGGOO',		'TECH_TRACKING_TRAPPING'),
('EACIV_DAGGOO',		'TECH_HARPOONS'			),
('EACIV_DAGGOO',		'TECH_SAILING'			),
('EACIV_DAGGOO',		'TECH_CALENDAR'			),
('EACIV_DAGGOO',		'TECH_GAMEKEEPING'		),
('EACIV_DAGGOO',		'TECH_SHIP_BUILDING'	),
('EACIV_DAGGOO',		'TECH_ASTRONOMY'		),
('EACIV_DAGGOO',		'TECH_ANIMAL_MASTERY'	),
('EACIV_DAGGOO',		'TECH_NAVIGATION'		),
('EACIV_DAGGOO',		'TECH_BEAST_MASTERY'	),
('EACIV_DAGGOO',		'TECH_WHALING'			),
('EACIV_DAGGOO',		'TECH_NAVAL_ENGINEERING'),
('EACIV_DAGGOO',		'TECH_SONG_OF_LEVIATHAN'),
('EACIV_FOMHOIRE',		'TECH_HARPOONS'			),
('EACIV_FOMHOIRE',		'TECH_SAILING'			),
('EACIV_FOMHOIRE',		'TECH_MILLING'			),
('EACIV_FOMHOIRE',		'TECH_CALENDAR'			),
('EACIV_FOMHOIRE',		'TECH_MATHEMATICS'		),
('EACIV_FOMHOIRE',		'TECH_SHIP_BUILDING'	),
('EACIV_FOMHOIRE',		'TECH_FORESTRY'			),
('EACIV_FOMHOIRE',		'TECH_ASTRONOMY'		),
('EACIV_FOMHOIRE',		'TECH_ALCHEMY'			),
('EACIV_FOMHOIRE',		'TECH_NAVIGATION'		),
('EACIV_FOMHOIRE',		'TECH_CHEMISTRY'		),
('EACIV_FOMHOIRE',		'TECH_WHALING'			),
('EACIV_FOMHOIRE',		'TECH_NAVAL_ENGINEERING'),
('EACIV_FOMHOIRE',		'TECH_ADV_NAVAL_ENGINEERING'),
('EACIV_PARAKHORA',		'TECH_SAILING'			),
('EACIV_PARAKHORA',		'TECH_MILLING'			),
('EACIV_PARAKHORA',		'TECH_WEAVING'			),
('EACIV_PARAKHORA',		'TECH_ZYMURGY'			),
('EACIV_PARAKHORA',		'TECH_IRRIGATION'		),
('EACIV_PARAKHORA',		'TECH_CALENDAR'			),
('EACIV_PARAKHORA',		'TECH_MATHEMATICS'		),
('EACIV_PARAKHORA',		'TECH_SHIP_BUILDING'	),
('EACIV_PARAKHORA',		'TECH_MASONRY'			),
('EACIV_PARAKHORA',		'TECH_FORESTRY'			),
('EACIV_PARAKHORA',		'TECH_FINE_TEXTILES'	),
('EACIV_PARAKHORA',		'TECH_MECHANICS'		),
('EACIV_PARAKHORA',		'TECH_CONSTRUCTION'		),
('EACIV_PARAKHORA',		'TECH_SANITATION'		),
('EACIV_PARAKHORA',		'TECH_ENGINEERING'		),
('EACIV_NEITH',			'TECH_ANIMAL_HUSBANDRY'	),
('EACIV_NEITH',			'TECH_MILLING'			),
('EACIV_NEITH',			'TECH_WEAVING'			),
('EACIV_NEITH',			'TECH_ZYMURGY'			),
('EACIV_NEITH',			'TECH_IRRIGATION'		),
('EACIV_NEITH',			'TECH_CALENDAR'			),
('EACIV_NEITH',			'TECH_DRAMA'			),
('EACIV_NEITH',			'TECH_MATHEMATICS'		),
('EACIV_NEITH',			'TECH_ANIMAL_INDUSTRY'	),
('EACIV_NEITH',			'TECH_FINE_TEXTILES'	),
('EACIV_NEITH',			'TECH_LITERATURE'		),
('EACIV_NEITH',			'TECH_MUSIC'		),
('EACIV_NEITH',			'TECH_MECHANICS'		),
('EACIV_NEITH',			'TECH_AESTHETICS'		),
('EACIV_NEITH',			'TECH_ENGINEERING'		),
('EACIV_NEITH',			'TECH_MACHINERY'		),
('EACIV_ELEUTHERIOS',	'TECH_MILLING'			),
('EACIV_ELEUTHERIOS',	'TECH_WEAVING'			),
('EACIV_ELEUTHERIOS',	'TECH_ZYMURGY'			),
('EACIV_ELEUTHERIOS',	'TECH_IRRIGATION'		),
('EACIV_ELEUTHERIOS',	'TECH_CALENDAR'			),
('EACIV_ELEUTHERIOS',	'TECH_DRAMA'			),
('EACIV_ELEUTHERIOS',	'TECH_OENOLOGY'			),
('EACIV_ELEUTHERIOS',	'TECH_CROP_ROTATION'	),
('EACIV_ELEUTHERIOS',	'TECH_LITERATURE'		),
('EACIV_ELEUTHERIOS',	'TECH_ALCHEMY'			),
('EACIV_ELEUTHERIOS',	'TECH_ENCHANTMENT'		),
('EACIV_ELEUTHERIOS',	'TECH_CHEMISTRY'		),
('EACIV_ELEUTHERIOS',	'TECH_SANITATION'		),
('EACIV_ELEUTHERIOS',	'TECH_AESTHETICS'		),
('EACIV_ELEUTHERIOS',	'TECH_MEDICINE'			),
('EACIV_NINKASI',		'TECH_MILLING'			),
('EACIV_NINKASI',		'TECH_WEAVING'			),
('EACIV_NINKASI',		'TECH_ZYMURGY'			),
('EACIV_NINKASI',		'TECH_IRRIGATION'		),
('EACIV_NINKASI',		'TECH_CALENDAR'			),
('EACIV_NINKASI',		'TECH_DRAMA'			),
('EACIV_NINKASI',		'TECH_OENOLOGY'			),
('EACIV_NINKASI',		'TECH_MUSIC'		),
('EACIV_NINKASI',		'TECH_ALCHEMY'			),
('EACIV_NINKASI',		'TECH_ENCHANTMENT'		),
('EACIV_NINKASI',		'TECH_CHEMISTRY'		),
('EACIV_NINKASI',		'TECH_ILLUSION'			),
('EACIV_GIRNAR',		'TECH_MILLING'			),
('EACIV_GIRNAR',		'TECH_WEAVING'			),
('EACIV_GIRNAR',		'TECH_ZYMURGY'			),
('EACIV_GIRNAR',		'TECH_IRRIGATION'		),
('EACIV_GIRNAR',		'TECH_CALENDAR'			),
('EACIV_GIRNAR',		'TECH_MATHEMATICS'		),
('EACIV_GIRNAR',		'TECH_MASONRY'			),
('EACIV_GIRNAR',		'TECH_CROP_ROTATION'	),
('EACIV_GIRNAR',		'TECH_MECHANICS'		),
('EACIV_GIRNAR',		'TECH_CONSTRUCTION'		),
('EACIV_GIRNAR',		'TECH_SANITATION'		),
('EACIV_GIRNAR',		'TECH_ENGINEERING'		),
('EACIV_GIRNAR',		'TECH_ARCHITECTURE'		),
('EACIV_ALDEBAR',		'TECH_SAILING'			),
('EACIV_ALDEBAR',		'TECH_MILLING'			),
('EACIV_ALDEBAR',		'TECH_WEAVING'			),
('EACIV_ALDEBAR',		'TECH_ZYMURGY'			),
('EACIV_ALDEBAR',		'TECH_IRRIGATION'		),
('EACIV_ALDEBAR',		'TECH_CALENDAR'			),
('EACIV_ALDEBAR',		'TECH_PHILOSOPHY'		),
('EACIV_ALDEBAR',		'TECH_MATHEMATICS'		),
('EACIV_ALDEBAR',		'TECH_SHIP_BUILDING'	),
('EACIV_ALDEBAR',		'TECH_ASTRONOMY'		),
('EACIV_ALDEBAR',		'TECH_LOGIC'			),
('EACIV_ALDEBAR',		'TECH_LITERATURE'		),
('EACIV_ALDEBAR',		'TECH_MUSIC'		),
('EACIV_ALDEBAR',		'TECH_NAVIGATION'		),
('EACIV_ALDEBAR',		'TECH_METAPHYSICS'		),
('EACIV_ANAPHORA',		'TECH_WEAVING'			),
('EACIV_ANAPHORA',		'TECH_ZYMURGY'			),
('EACIV_ANAPHORA',		'TECH_IRRIGATION'		),
('EACIV_ANAPHORA',		'TECH_CALENDAR'			),
('EACIV_ANAPHORA',		'TECH_DIVINE_LITURGY'	),
('EACIV_ANAPHORA',		'TECH_PHILOSOPHY'		),
('EACIV_ANAPHORA',		'TECH_ASTRONOMY'		),
('EACIV_ANAPHORA',		'TECH_DIVINE_VITALISM'	),
('EACIV_ANAPHORA',		'TECH_LITERATURE'		),
('EACIV_ANAPHORA',		'TECH_HEAVENLY_CYCLES'	),
('EACIV_ANAPHORA',		'TECH_DIVINE_ESSENCE'	),
('EACIV_ANAPHORA',		'TECH_CELESTIAL_KNOWLEDGE'),
('EACIV_ANAPHORA',		'TECH_DIVINE_INTERVENTION'),
('EACIV_ALDEBAR',		'TECH_KNOWLEDGE_OF_HEAVEN'),
('EACIV_ISALLIN',		'TECH_SAILING'			),
('EACIV_ISALLIN',		'TECH_MILLING'			),
('EACIV_ISALLIN',		'TECH_CALENDAR'			),
('EACIV_ISALLIN',		'TECH_DIVINE_LITURGY'	),
('EACIV_ISALLIN',		'TECH_PHILOSOPHY'		),
('EACIV_ISALLIN',		'TECH_SHIP_BUILDING'	),
('EACIV_ISALLIN',		'TECH_ASTRONOMY'		),
('EACIV_ISALLIN',		'TECH_DIVINE_VITALISM'	),
('EACIV_ISALLIN',		'TECH_LITERATURE'		),
('EACIV_ISALLIN',		'TECH_HEAVENLY_CYCLES'	),
('EACIV_ISALLIN',		'TECH_DIVINE_ESSENCE'	),
('EACIV_ISALLIN',		'TECH_CELESTIAL_KNOWLEDGE'),
('EACIV_ISALLIN',		'TECH_DIVINE_INTERVENTION'),
('EACIV_ISALLIN',		'TECH_KNOWLEDGE_OF_HEAVEN'),
('EACIV_STYGIA',		'TECH_MALEFICIUM'		),
('EACIV_STYGIA',		'TECH_THAUMATURGY'		),
('EACIV_STYGIA',		'TECH_PHILOSOPHY'		),
('EACIV_STYGIA',		'TECH_REANIMATION'		),
('EACIV_STYGIA',		'TECH_SORCERY'		),
('EACIV_STYGIA',		'TECH_CONJURATION'		),
('EACIV_STYGIA',		'TECH_TRANSMUTATION'	),
('EACIV_STYGIA',		'TECH_VAMPIRISM'		),
('EACIV_STYGIA',		'TECH_NECROMANCY'		),
('EACIV_STYGIA',		'TECH_SUMMONING'		),
('EACIV_STYGIA',		'TECH_EVOCATION'		),
('EACIV_STYGIA',		'TECH_SOUL_BINDING'		),
('EACIV_STYGIA',		'TECH_INVOCATION'		),
('EACIV_STYGIA',		'TECH_BREACH'			),
('EACIV_STYGIA',		'TECH_ARMAGEDDON_RITUALS'),
('EACIV_MORIQUENDI',	'TECH_MALEFICIUM'		),
('EACIV_MORIQUENDI',	'TECH_THAUMATURGY'		),
('EACIV_MORIQUENDI',	'TECH_PHILOSOPHY'		),
('EACIV_MORIQUENDI',	'TECH_LYCANTHROPY'		),
('EACIV_MORIQUENDI',	'TECH_REANIMATION'		),
('EACIV_MORIQUENDI',	'TECH_SORCERY'		),
('EACIV_MORIQUENDI',	'TECH_CONJURATION'		),
('EACIV_MORIQUENDI',	'TECH_TRANSMUTATION'	),
('EACIV_MORIQUENDI',	'TECH_NECROMANCY'		),
('EACIV_MORIQUENDI',	'TECH_SUMMONING'		),
('EACIV_MORIQUENDI',	'TECH_EVOCATION'		),
('EACIV_MORIQUENDI',	'TECH_SOUL_BINDING'		),
('EACIV_MORIQUENDI',	'TECH_INVOCATION'		),
('EACIV_MORIQUENDI',	'TECH_BREACH'			),
('EACIV_MORIQUENDI',	'TECH_ARMAGEDDON_RITUALS'),
('EACIV_LEMURIA',		'TECH_WEAVING'			),
('EACIV_LEMURIA',		'TECH_ZYMURGY'			),
('EACIV_LEMURIA',		'TECH_THAUMATURGY'		),
('EACIV_LEMURIA',		'TECH_PHILOSOPHY'		),
('EACIV_LEMURIA',		'TECH_DRAMA'			),
('EACIV_LEMURIA',		'TECH_MATHEMATICS'		),
('EACIV_LEMURIA',		'TECH_CONJURATION'		),
('EACIV_LEMURIA',		'TECH_TRANSMUTATION'	),
('EACIV_LEMURIA',		'TECH_LOGIC'			),
('EACIV_LEMURIA',		'TECH_MUSIC'		),
('EACIV_LEMURIA',		'TECH_ALCHEMY'			),
('EACIV_LEMURIA',		'TECH_EVOCATION'		),
('EACIV_LEMURIA',		'TECH_ABJURATION'		),
('EACIV_LEMURIA',		'TECH_SEMIOTICS'		),
('EACIV_LEMURIA',		'TECH_ENCHANTMENT'		),
('EACIV_LEMURIA',		'TECH_INVOCATION'		),
('EACIV_LEMURIA',		'TECH_METAPHYSICS'		),
('EACIV_LEMURIA',		'TECH_ILLUSION'			),
('EACIV_LEMURIA',		'TECH_GREATER_ARCANA'	),
('EACIV_LEMURIA',		'TECH_ESOTERIC_ARCANA'	),
('EACIV_AXAGORIA',		'TECH_CALENDAR'			),
('EACIV_AXAGORIA',		'TECH_PHILOSOPHY'		),
('EACIV_AXAGORIA',		'TECH_MATHEMATICS'		),
('EACIV_AXAGORIA',		'TECH_MASONRY'			),
('EACIV_AXAGORIA',		'TECH_ASTRONOMY'		),
('EACIV_AXAGORIA',		'TECH_LOGIC'			),
('EACIV_AXAGORIA',		'TECH_MUSIC'			),
('EACIV_AXAGORIA',		'TECH_ALCHEMY'			),
('EACIV_AXAGORIA',		'TECH_MECHANICS'		),
('EACIV_AXAGORIA',		'TECH_BANKING'			),
('EACIV_AXAGORIA',		'TECH_SEMIOTICS'		),
('EACIV_AXAGORIA',		'TECH_CHEMISTRY'		),
('EACIV_AXAGORIA',		'TECH_ENGINEERING'		),
('EACIV_AXAGORIA',		'TECH_METAPHYSICS'		),
('EACIV_AXAGORIA',		'TECH_MEDICINE'			),
('EACIV_AXAGORIA',		'TECH_MACHINERY'		),
('EACIV_AXAGORIA',		'TECH_COSMOGONY'		),
('EACIV_AXAGORIA',		'TECH_STEAM_POWER'		),
('EACIV_AXAGORIA',		'TECH_TRANSCENDENTAL_THOUGHT'),
('EACIV_IACCHIA',		'TECH_WEAVING'			),
('EACIV_IACCHIA',		'TECH_ZYMURGY'			),
('EACIV_IACCHIA',		'TECH_PHILOSOPHY'		),
('EACIV_IACCHIA',		'TECH_DRAMA'			),
('EACIV_IACCHIA',		'TECH_MATHEMATICS'		),
('EACIV_IACCHIA',		'TECH_LITERATURE'		),
('EACIV_IACCHIA',		'TECH_MUSIC'			),

--TO DO


('EACIV_GRAEAE',		'TECH_MALEFICIUM'		),
('EACIV_GRAEAE',		'TECH_LYCANTHROPY'		),
('EACIV_GRAEAE',		'TECH_REANIMATION'		),
('EACIV_GRAEAE',		'TECH_SORCERY'		),
('EACIV_GRAEAE',		'TECH_THAUMATURGY'		),
('EACIV_GRAEAE',		'TECH_CONJURATION'		),
('EACIV_GRAEAE',		'TECH_TRANSMUTATION'	),
('EACIV_GRAEAE',		'TECH_ENCHANTMENT'		),
('EACIV_GRAEAE',		'TECH_ALCHEMY'			);

CREATE TABLE EaCiv_EnabledPolicies ('EaCivType' TEXT NOT NULL, 'PolicyType' TEXT NOT NULL, 'GridX' INTEGER, 'GridY' INTEGER);
INSERT INTO EaCiv_EnabledPolicies (EaCivType, PolicyType, GridX, GridY) VALUES
('EACIV_ELEUTHERIOS',	'POLICY_PASTORALISTS',	1,	1),
('EACIV_GRAEAE',		'POLICY_MYSTICS',		5,	1),
('EACIV_GRAEAE',		'POLICY_DIVINATORS',	5,	2),
('EACIV_GRAEAE',		'POLICY_CONJURORS',		1,	1),
('EACIV_GRAEAE',		'POLICY_ENCHANTERS',	3,	1),
('EACIV_GRAEAE',		'POLICY_HERBALISTS',	1,	2),
('EACIV_GRAEAE',		'POLICY_ALCHEMISTS',	3,	2),
('EACIV_GRAEAE',		'POLICY_POTION_MAKERS',	3,	3);


INSERT INTO EaDebugTableCheck(FileName) SELECT 'EaCivilizations.sql';