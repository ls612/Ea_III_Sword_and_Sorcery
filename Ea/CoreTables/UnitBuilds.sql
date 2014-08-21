
-- Contains Builds and BuildFeatures

-----------------------------------------------------------------------------------------
-- Builds
-----------------------------------------------------------------------------------------

ALTER TABLE Builds ADD COLUMN 'DisallowTech' TEXT DEFAULT NULL;
ALTER TABLE Builds ADD COLUMN 'PrereqPolicy' TEXT DEFAULT NULL;
ALTER TABLE Builds ADD COLUMN 'DisallowPolicy' TEXT DEFAULT NULL;


DELETE FROM Builds WHERE Type NOT IN ('BUILD_ROAD','BUILD_RAILROAD', 'BUILD_REPAIR', 'BUILD_REMOVE_ROUTE');

INSERT INTO Builds (Type,		PrereqTech,						DisallowTech,			PrereqPolicy,		DisallowPolicy,		Time,	ImprovementType,					Description,							Help,										Recommendation,								EntityEvent,				HotKey,	CtrlDownAlt,	CtrlDown,	AltDown,	HotKeyPriority,	OrderPriority,	IconIndex,	IconAtlas			) VALUES
--shared
('BUILD_SCRUB_BLIGHT',			NULL,							NULL,					NULL,				NULL,				NULL,	NULL,								'TXT_KEY_EA_BUILD_SCRUB_BLIGHT',		'TXT_KEY_EA_BUILD_SCRUB_BLIGHT_HELP',		'TXT_KEY_EA_BUILD_SCRUB_BLIGHT_REC',		'ENTITY_EVENT_IRRIGATE',	'KB_L',	0,				0,			0,			0,				98,				59,			'UNIT_ACTION_ATLAS'	),
('BUILD_LUMBERMILL_2',			'TECH_MILLING',					NULL,					NULL,				NULL,				700,	'IMPROVEMENT_LUMBERMILL_2',			'TXT_KEY_EA_BUILD_LUMBERMILL',			NULL,										'TXT_KEY_EA_BUILD_LUMBERMILL_REC',			'ENTITY_EVENT_BUILD',		'KB_L',	0,				0,			0,			0,				98,				28,			'UNIT_ACTION_ATLAS'	),
('BUILD_POLDER',				'TECH_ALLOW_POLDER',			NULL,					NULL,				NULL,				700,	'IMPROVEMENT_POLDER',				'TXT_KEY_EA_BUILD_POLDER',				NULL,										'TXT_KEY_EA_BUILD_POLDER_REC',				'ENTITY_EVENT_IRRIGATE',	'KB_L',	0,				0,			0,			0,				98,				21,			'UNIT_ACTION_ATLAS'	),
('BUILD_BOWYERS_CAMP',			'TECH_ARCHERY',					NULL,					NULL,				NULL,				700,	'IMPROVEMENT_BOWYERS_CAMP',			'TXT_KEY_EA_BUILD_BOWYERS_CAMP',		NULL,										'TXT_KEY_EA_BUILD_BOWYERS_CAMP_REC',		'ENTITY_EVENT_BUILD',		'KB_L',	0,				0,			0,			0,				98,				32,			'UNIT_ACTION_ATLAS'	),
('BUILD_GATHERERS_HUT',			NULL,							NULL,					NULL,				NULL,				700,	'IMPROVEMENT_GATHERERS_HUT',		'TXT_KEY_EA_BUILD_GATHERERS_HUT',		NULL,										'TXT_KEY_EA_BUILD_GATHERERS_HUT_REC',		'ENTITY_EVENT_BUILD',		'KB_L',	0,				0,			0,			0,				98,				32,			'UNIT_ACTION_ATLAS'	),

--Non-Pan only
('BUILD_FARM',					'TECH_AGRICULTURE',				NULL,					NULL,				'POLICY_PANTHEISM',	700,	'IMPROVEMENT_FARM',					'TXT_KEY_EA_BUILD_FARM',				NULL,										NULL,										'ENTITY_EVENT_IRRIGATE',	'KB_I',	0,				0,			0,			0,				97,				21,			'UNIT_ACTION_ATLAS'	),
('BUILD_FARM_2',				'TECH_AGRICULTURE',				NULL,					NULL,				'POLICY_PANTHEISM',	700,	'IMPROVEMENT_FARM_2',				'TXT_KEY_EA_BUILD_FARM',				NULL,										NULL,										'ENTITY_EVENT_IRRIGATE',	'KB_I',	0,				0,			0,			0,				97,				21,			'UNIT_ACTION_ATLAS'	),
('BUILD_MINE',					'TECH_MINING',					NULL,					NULL,				'POLICY_PANTHEISM',	700,	'IMPROVEMENT_MINE',					'TXT_KEY_EA_BUILD_MINE',				NULL,										NULL,										'ENTITY_EVENT_MINE',		'KB_N',	0,				0,			0,			0,				96,				22,			'UNIT_ACTION_ATLAS'	),
('BUILD_MINE_2',				'TECH_MINING',					NULL,					NULL,				'POLICY_PANTHEISM',	700,	'IMPROVEMENT_MINE_2',				'TXT_KEY_EA_BUILD_MINE',				NULL,										NULL,										'ENTITY_EVENT_MINE',		'KB_N',	0,				0,			0,			0,				96,				22,			'UNIT_ACTION_ATLAS'	),
('BUILD_PASTURE',				'TECH_DOMESTICATION',			NULL,					NULL,				'POLICY_PANTHEISM',	700,	'IMPROVEMENT_PASTURE',				'TXT_KEY_EA_BUILD_PASTURE',				NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				29,			'UNIT_ACTION_ATLAS'	),
('BUILD_QUARRY',				'TECH_MASONRY',					NULL,					NULL,				'POLICY_PANTHEISM',	800,	'IMPROVEMENT_QUARRY',				'TXT_KEY_EA_BUILD_QUARRY',				NULL,										NULL,										'ENTITY_EVENT_MINE',		'KB_Q',	0,				0,			0,			0,				98,				26,			'UNIT_ACTION_ATLAS'	),
('BUILD_E_PLANTATION',			'TECH_CALENDAR',				NULL,					NULL,				'POLICY_PANTHEISM',	600,	'IMPROVEMENT_E_PLANTATION',			'TXT_KEY_EA_BUILD_E_PLANTATION',		NULL,										NULL,										'ENTITY_EVENT_IRRIGATE',	'KB_P',	0,				0,			0,			0,				98,				27,			'UNIT_ACTION_ATLAS'	),
('BUILD_VINEYARD',				'TECH_ZYMURGY',					NULL,					NULL,				'POLICY_PANTHEISM',	700,	'IMPROVEMENT_VINEYARD',				'TXT_KEY_EA_BUILD_VINEYARD',			NULL,										NULL,										'ENTITY_EVENT_IRRIGATE',	'KB_W',	0,				0,			0,			0,				98,				27,			'UNIT_ACTION_ATLAS'	),
('BUILD_T_PLANTATION',			'TECH_WEAVING',					NULL,					NULL,				'POLICY_PANTHEISM',	600,	'IMPROVEMENT_T_PLANTATION',			'TXT_KEY_EA_BUILD_T_PLANTATION',		NULL,										NULL,										'ENTITY_EVENT_IRRIGATE',	'KB_P',	0,				0,			0,			0,				98,				27,			'UNIT_ACTION_ATLAS'	),
('BUILD_ORCHARD',				'TECH_IRRIGATION',				NULL,					NULL,				'POLICY_PANTHEISM',	600,	'IMPROVEMENT_ORCHARD',				'TXT_KEY_EA_BUILD_ORCHARD',				NULL,										NULL,										'ENTITY_EVENT_IRRIGATE',	'KB_P',	0,				0,			0,			0,				98,				27,			'UNIT_ACTION_ATLAS'	),
('BUILD_LUMBERMILL',			'TECH_MILLING',					NULL,					NULL,				'POLICY_PANTHEISM',	700,	'IMPROVEMENT_LUMBERMILL',			'TXT_KEY_EA_BUILD_LUMBERMILL',			NULL,										'TXT_KEY_EA_BUILD_LUMBERMILL_REC',			'ENTITY_EVENT_BUILD',		'KB_L',	0,				0,			0,			0,				98,				28,			'UNIT_ACTION_ATLAS'	),
('BUILD_WELL',					'TECH_ALCHEMY',					NULL,					NULL,				'POLICY_PANTHEISM',	700,	'IMPROVEMENT_WELL',					'TXT_KEY_EA_BUILD_WELL',				NULL,										'TXT_KEY_EA_BUILD_WELL_REC',				'ENTITY_EVENT_BUILD',		'KB_L',	0,				0,			0,			0,				98,				33,			'UNIT_ACTION_ATLAS'	),
('BUILD_SLASH_BURN_FOREST',		NULL,							'TECH_BRONZE_WORKING',	NULL,				'POLICY_PANTHEISM',	NULL,	NULL,								'TXT_KEY_EA_BUILD_SLASH_BURN_FOREST',	'TXT_KEY_EA_BUILD_REMOVE_FEATURE_HELP',		'TXT_KEY_EA_BUILD_REMOVE_FEATURE_HELP',		'ENTITY_EVENT_CHOP',		'KB_C',	0,				0,			1,			0,				50,				38,			'UNIT_ACTION_ATLAS'	),
('BUILD_SLASH_BURN_JUNGLE',		'TECH_BRONZE_WORKING',			'TECH_IRON_WORKING',	NULL,				'POLICY_PANTHEISM',	NULL,	NULL,								'TXT_KEY_EA_BUILD_SLASH_BURN_JUNGLE',	'TXT_KEY_EA_BUILD_REMOVE_FEATURE_HELP',		'TXT_KEY_EA_BUILD_REMOVE_FEATURE_HELP',		'ENTITY_EVENT_CHOP',		'KB_C',	0,				0,			1,			0,				50,				38,			'UNIT_ACTION_ATLAS'	),
('BUILD_CHOP_FOREST',			'TECH_BRONZE_WORKING',			NULL,					NULL,				'POLICY_PANTHEISM',	NULL,	NULL,								'TXT_KEY_EA_BUILD_CHOP_FOREST',			'TXT_KEY_EA_BUILD_REMOVE_FEATURE_HELP',		'TXT_KEY_EA_BUILD_REMOVE_FEATURE_HELP',		'ENTITY_EVENT_CHOP',		'KB_C',	0,				0,			1,			0,				50,				31,			'UNIT_ACTION_ATLAS'	),
('BUILD_CHOP_JUNGLE',			'TECH_IRON_WORKING',			NULL,					NULL,				'POLICY_PANTHEISM',	NULL,	NULL,								'TXT_KEY_EA_BUILD_CHOP_JUNGLE',			'TXT_KEY_EA_BUILD_REMOVE_FEATURE_HELP',		'TXT_KEY_EA_BUILD_REMOVE_FEATURE_HELP',		'ENTITY_EVENT_CHOP',		'KB_C',	0,				0,			1,			0,				50,				31,			'UNIT_ACTION_ATLAS'	),
('BUILD_REMOVE_MARSH',			'TECH_MASONRY',					NULL,					NULL,				'POLICY_PANTHEISM',	NULL,	NULL,								'TXT_KEY_EA_BUILD_REMOVE_MARSH',		'TXT_KEY_EA_BUILD_REMOVE_FEATURE_HELP',		'TXT_KEY_EA_BUILD_REMOVE_FEATURE_HELP',		'ENTITY_EVENT_CHOP',		'KB_C',	0,				0,			1,			0,				50,				38,			'UNIT_ACTION_ATLAS'	),

--Pantheistic only (build on features without removal)
('BUILD_FARM_PAN',				'TECH_AGRICULTURE',				NULL,					'POLICY_PANTHEISM',	NULL,				700,	'IMPROVEMENT_FARM_2',				'TXT_KEY_EA_BUILD_FARM',				NULL,										NULL,										'ENTITY_EVENT_IRRIGATE',	'KB_I',	0,				0,			0,			0,				97,				21,			'UNIT_ACTION_ATLAS'	),
('BUILD_MINE_PAN',				'TECH_MINING',					NULL,					'POLICY_PANTHEISM',	NULL,				700,	'IMPROVEMENT_MINE_2',				'TXT_KEY_EA_BUILD_MINE',				NULL,										NULL,										'ENTITY_EVENT_MINE',		'KB_N',	0,				0,			0,			0,				96,				22,			'UNIT_ACTION_ATLAS'	),
('BUILD_PASTURE_PAN',			'TECH_DOMESTICATION',			NULL,					'POLICY_PANTHEISM',	NULL,				700,	'IMPROVEMENT_PASTURE',				'TXT_KEY_EA_BUILD_PASTURE',				NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				29,			'UNIT_ACTION_ATLAS'	),
('BUILD_QUARRY_PAN',			'TECH_MASONRY',					NULL,					'POLICY_PANTHEISM',	NULL,				800,	'IMPROVEMENT_QUARRY',				'TXT_KEY_EA_BUILD_QUARRY',				NULL,										NULL,										'ENTITY_EVENT_MINE',		'KB_Q',	0,				0,			0,			0,				98,				26,			'UNIT_ACTION_ATLAS'	),
('BUILD_E_PLANTATION_PAN',		'TECH_CALENDAR',				NULL,					'POLICY_PANTHEISM',	NULL,				600,	'IMPROVEMENT_E_PLANTATION',			'TXT_KEY_EA_BUILD_E_PLANTATION',		NULL,										NULL,										'ENTITY_EVENT_IRRIGATE',	'KB_P',	0,				0,			0,			0,				98,				27,			'UNIT_ACTION_ATLAS'	),
('BUILD_VINEYARD_PAN',			'TECH_ZYMURGY',					NULL,					'POLICY_PANTHEISM',	NULL,				700,	'IMPROVEMENT_VINEYARD',				'TXT_KEY_EA_BUILD_VINEYARD',			NULL,										NULL,										'ENTITY_EVENT_IRRIGATE',	'KB_W',	0,				0,			0,			0,				98,				27,			'UNIT_ACTION_ATLAS'	),
('BUILD_T_PLANTATION_PAN',		'TECH_WEAVING',					NULL,					'POLICY_PANTHEISM',	NULL,				600,	'IMPROVEMENT_T_PLANTATION',			'TXT_KEY_EA_BUILD_T_PLANTATION',		NULL,										NULL,										'ENTITY_EVENT_IRRIGATE',	'KB_P',	0,				0,			0,			0,				98,				27,			'UNIT_ACTION_ATLAS'	),
('BUILD_ORCHARD_PAN',			'TECH_IRRIGATION',				NULL,					'POLICY_PANTHEISM',	NULL,				600,	'IMPROVEMENT_ORCHARD',				'TXT_KEY_EA_BUILD_ORCHARD',				NULL,										NULL,										'ENTITY_EVENT_IRRIGATE',	'KB_P',	0,				0,			0,			0,				98,				27,			'UNIT_ACTION_ATLAS'	),
('BUILD_WELL_PAN',				'TECH_ALCHEMY',					NULL,					'POLICY_PANTHEISM',	NULL,				700,	'IMPROVEMENT_WELL',					'TXT_KEY_EA_BUILD_WELL',				NULL,										'TXT_KEY_EA_BUILD_WELL_REC',				'ENTITY_EVENT_BUILD',		'KB_L',	0,				0,			0,			0,				98,				33,			'UNIT_ACTION_ATLAS'	),

--GP plot builds (PrereqTech does nothing here except add to tech tree UI)
('BUILD_STANHENCG',				NULL,							NULL,					'POLICY_PANTHEISM',	NULL,				2500,	'IMPROVEMENT_STANHENCG',			'TXT_KEY_EA_BUILD_STANHENCG',			NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				2,			'BW_ATLAS_2'				),
('BUILD_PYRAMID',				'TECH_MASONRY',					NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_PYRAMID',				'TXT_KEY_EA_BUILD_PYRAMID',				NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				0,			'BW_ATLAS_2'				),
('BUILD_GREAT_LIBRARY',			'TECH_PHILOSOPHY',				NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_GREAT_LIBRARY',		'TXT_KEY_EA_BUILD_GREAT_LIBRARY',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				1,			'BW_ATLAS_2'				),
('BUILD_ACADEMY_PHILOSOPHY',	'TECH_PHILOSOPHY',				NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_ACADEMY_PHILOSOPHY',	'TXT_KEY_EA_BUILD_ACADEMY_PHILOSOPHY',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				1,			'BW_ATLAS_2'				),
('BUILD_ACADEMY_LOGIC',			'TECH_LOGIC',					NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_ACADEMY_LOGIC',		'TXT_KEY_EA_BUILD_ACADEMY_LOGIC',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				1,			'BW_ATLAS_2'				),
('BUILD_ACADEMY_SEMIOTICS',		'TECH_SEMIOTICS',				NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_ACADEMY_SEMIOTICS',	'TXT_KEY_EA_BUILD_ACADEMY_SEMIOTICS',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				1,			'BW_ATLAS_2'				),
('BUILD_ACADEMY_METAPHYSICS',	'TECH_METAPHYSICS',				NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_ACADEMY_METAPHYSICS',	'TXT_KEY_EA_BUILD_ACADEMY_METAPHYSICS',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				1,			'BW_ATLAS_2'				),
('BUILD_ACADEMY_TRANS_THOUGHT',	'TECH_TRANSCENDENTAL_THOUGHT',	NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_ACADEMY_TRANS_THOUGHT','TXT_KEY_EA_BUILD_ACADEMY_TRANS_THOUGHT',NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				1,			'BW_ATLAS_2'				),
('BUILD_ARCANE_TOWER',			'TECH_THAUMATURGY',				NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_ARCANE_TOWER',			'TXT_KEY_EA_BUILD_ARCANE_TOWER',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				3,			'UNIT_ACTION_ATLAS_EXP2'	),
('BUILD_TEMPLE_AZZANDARA_1',	'TECH_DIVINE_LITURGY',			NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_AZZANDARA_1',	'TXT_KEY_EA_BUILD_TEMPLE_AZZANDARA_1',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_AZZANDARA_2',	'TECH_DIVINE_VITALISM',			NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_AZZANDARA_2',	'TXT_KEY_EA_BUILD_TEMPLE_AZZANDARA_2',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_AZZANDARA_3',	'TECH_DIVINE_ESSENCE',			NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_AZZANDARA_3',	'TXT_KEY_EA_BUILD_TEMPLE_AZZANDARA_3',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_AZZANDARA_4',	'TECH_HEAVENLY_CYCLES',			NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_AZZANDARA_4',	'TXT_KEY_EA_BUILD_TEMPLE_AZZANDARA_4',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_AZZANDARA_5',	'TECH_CELESTIAL_KNOWLEDGE',		NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_AZZANDARA_5',	'TXT_KEY_EA_BUILD_TEMPLE_AZZANDARA_5',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_AZZANDARA_6',	'TECH_DIVINE_INTERVENTION',		NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_AZZANDARA_6',	'TXT_KEY_EA_BUILD_TEMPLE_AZZANDARA_6',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_AZZANDARA_7',	'TECH_KNOWLEDGE_OF_HEAVEN',		NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_AZZANDARA_7',	'TXT_KEY_EA_BUILD_TEMPLE_AZZANDARA_7',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_AHRIMAN_1',		'TECH_MALEFICIUM',				NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_AHRIMAN_1',		'TXT_KEY_EA_BUILD_TEMPLE_AHRIMAN_1',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_AHRIMAN_2',		'TECH_REANIMATION',				NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_AHRIMAN_2',		'TXT_KEY_EA_BUILD_TEMPLE_AHRIMAN_2',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_AHRIMAN_3',		'TECH_SORCERY',					NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_AHRIMAN_3',		'TXT_KEY_EA_BUILD_TEMPLE_AHRIMAN_3',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_AHRIMAN_4',		'TECH_NECROMANCY',				NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_AHRIMAN_4',		'TXT_KEY_EA_BUILD_TEMPLE_AHRIMAN_4',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_AHRIMAN_5',		'TECH_SUMMONING',				NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_AHRIMAN_5',		'TXT_KEY_EA_BUILD_TEMPLE_AHRIMAN_5',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_AHRIMAN_6',		'TECH_SOUL_BINDING',			NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_AHRIMAN_6',		'TXT_KEY_EA_BUILD_TEMPLE_AHRIMAN_6',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_AHRIMAN_7',		'TECH_INVOCATION',				NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_AHRIMAN_7',		'TXT_KEY_EA_BUILD_TEMPLE_AHRIMAN_7',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_AHRIMAN_8',		'TECH_BREACH',					NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_AHRIMAN_8',		'TXT_KEY_EA_BUILD_TEMPLE_AHRIMAN_8',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_AHRIMAN_9',		'TECH_ARMAGEDDON_RITUALS',		NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_AHRIMAN_9',		'TXT_KEY_EA_BUILD_TEMPLE_AHRIMAN_9',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_FAGUS',			NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_FAGUS',			'TXT_KEY_EA_BUILD_TEMPLE_FAGUS',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_ABELLIO',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_ABELLIO',		'TXT_KEY_EA_BUILD_TEMPLE_ABELLIO',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_BUXENUS',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_BUXENUS',		'TXT_KEY_EA_BUILD_TEMPLE_BUXENUS',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_ROBOR',			NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_ROBOR',			'TXT_KEY_EA_BUILD_TEMPLE_ROBOR',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_ABNOAB',			NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_ABNOAB',		'TXT_KEY_EA_BUILD_TEMPLE_ABNOAB',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_EPONA',			NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_EPONA',			'TXT_KEY_EA_BUILD_TEMPLE_EPONA',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_ATEPOMARUS',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_ATEPOMARUS',	'TXT_KEY_EA_BUILD_TEMPLE_ATEPOMARUS',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_SABAZIOS',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_SABAZIOS',		'TXT_KEY_EA_BUILD_TEMPLE_SABAZIOS',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_AVETA',			NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_AVETA',			'TXT_KEY_EA_BUILD_TEMPLE_AVETA',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_CONDATIS',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_CONDATIS',		'TXT_KEY_EA_BUILD_TEMPLE_CONDATIS',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_ABANDINUS',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_ABANDINUS',		'TXT_KEY_EA_BUILD_TEMPLE_ABANDINUS',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_ADSULLATA',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_ADSULLATA',		'TXT_KEY_EA_BUILD_TEMPLE_ADSULLATA',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_ICAUNUS',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_ICAUNUS',		'TXT_KEY_EA_BUILD_TEMPLE_ICAUNUS',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_BELISAMA',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_BELISAMA',		'TXT_KEY_EA_BUILD_TEMPLE_BELISAMA',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_CLOTA',			NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_CLOTA',			'TXT_KEY_EA_BUILD_TEMPLE_CLOTA',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_SABRINA',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_SABRINA',		'TXT_KEY_EA_BUILD_TEMPLE_SABRINA',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_SEQUANA',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_SEQUANA',		'TXT_KEY_EA_BUILD_TEMPLE_SEQUANA',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_VERBEIA',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_VERBEIA',		'TXT_KEY_EA_BUILD_TEMPLE_VERBEIA',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_BORVO',			NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_BORVO',			'TXT_KEY_EA_BUILD_TEMPLE_BORVO',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_AEGIR',			NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_AEGIR',			'TXT_KEY_EA_BUILD_TEMPLE_AEGIR',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_BARINTHUS',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_BARINTHUS',		'TXT_KEY_EA_BUILD_TEMPLE_BARINTHUS',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_LIBAN',			NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_LIBAN',			'TXT_KEY_EA_BUILD_TEMPLE_LIBAN',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_FIMAFENG',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_FIMAFENG',		'TXT_KEY_EA_BUILD_TEMPLE_FIMAFENG',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_ELDIR',			NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_ELDIR',			'TXT_KEY_EA_BUILD_TEMPLE_ELDIR',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_RITONA',			NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_RITONA',		'TXT_KEY_EA_BUILD_TEMPLE_RITONA',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_BAKKHOS',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_BAKKHOS',		'TXT_KEY_EA_BUILD_TEMPLE_BAKKHOS',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_PAN',			NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_PAN',			'TXT_KEY_EA_BUILD_TEMPLE_PAN',			NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_SILENUS',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_SILENUS',		'TXT_KEY_EA_BUILD_TEMPLE_SILENUS',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_ERECURA',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_ERECURA',		'TXT_KEY_EA_BUILD_TEMPLE_ERECURA',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_VOSEGUS',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_VOSEGUS',		'TXT_KEY_EA_BUILD_TEMPLE_VOSEGUS',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_NANTOSUELTA',	NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_NANTOSUELTA',	'TXT_KEY_EA_BUILD_TEMPLE_NANTOSUELTA',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_DIS_PATER',		NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_DIS_PATER',		'TXT_KEY_EA_BUILD_TEMPLE_DIS_PATER',	NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_NERGAL',			NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_NERGAL',		'TXT_KEY_EA_BUILD_TEMPLE_NERGAL',		NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_WADD',			NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_WADD',			'TXT_KEY_EA_BUILD_TEMPLE_WADD',			NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_ABGAL',			NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_ABGAL',			'TXT_KEY_EA_BUILD_TEMPLE_ABGAL',			NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				),
('BUILD_TEMPLE_NESR',			NULL,							NULL,					NULL,				NULL,				2500,	'IMPROVEMENT_TEMPLE_NESR',			'TXT_KEY_EA_BUILD_TEMPLE_NESR',			NULL,										NULL,										'ENTITY_EVENT_BUILD',		'KB_P',	0,				0,			0,			0,				98,				37,			'BW_ATLAS_1'				);

--Note: dll expects railroad to have higher ID than road

/*
--GP builds (all non-consuming)
--Note: all PrereqTech need to be set to "TECH_ALLOW_..." types for AI control. Tech/policy reqs are in EaActions and stated in Help for UI
INSERT INTO Builds (Type,			PrereqTech,						Time,	ImprovementType,				Description,							Help,										Recommendation,								EntityEvent,				HotKey,	CtrlDownAlt,	CtrlDown,	AltDown,	HotKeyPriority,	OrderPriority,	IconIndex,	IconAtlas,		EaUnique)  VALUES
('BUILD_ANGKOR_WAT',			'TECH_ENGINEERING',				500,	'IMPROVEMENT_ANGKOR_WAT',		'TXT_KEY_EA_BUILD_ANGKOR_WAT',			'TXT_KEY_EA_BUILD_ANGKOR_WAT_HELP',			'TXT_KEY_EA_BUILD_ANGKOR_WAT_REC',			'ENTITY_EVENT_MINE',		'KB_L',	0,				0,			0,			0,				96,				9,			'BW_ATLAS_2',	'EABUILD_ANGKOR_WAT'			),
('BUILD_BIG_BEN',				'TECH_MACHINERY',				500,	'IMPROVEMENT_BIG_BEN',			'TXT_KEY_EA_BUILD_BIG_BEN',				'TXT_KEY_EA_BUILD_BIG_BEN_HELP',			'TXT_KEY_EA_BUILD_BIG_BEN_REC',				'ENTITY_EVENT_MINE',		'KB_L',	0,				0,			0,			0,				96,				19,			'BW_ATLAS_2',	'EABUILD_BIG_BEN'				),
('BUILD_BRANDENBURG_GATE',	'TECH_ENGINEERING',				500,	'IMPROVEMENT_BRANDENBURG_GATE',	'TXT_KEY_EA_BUILD_BRANDENBURG_GATE',	'TXT_KEY_EA_BUILD_BRANDENBURG_GATE_HELP',	'TXT_KEY_EA_BUILD_BRANDENBURG_GATE_REC',	'ENTITY_EVENT_MINE',		'KB_L',	0,				0,			0,			0,				96,				20,			'BW_ATLAS_2',	'EABUILD_BRANDENBURG_GATE'		),
('BUILD_CHICHEN_ITZA',		'TECH_MASONRY',					500,	'IMPROVEMENT_CHICHEN_ITZA',		'TXT_KEY_EA_BUILD_CHICHEN_ITZA',		'TXT_KEY_EA_BUILD_CHICHEN_ITZA_HELP',		'TXT_KEY_EA_BUILD_CHICHEN_ITZA_REC',		'ENTITY_EVENT_MINE',		'KB_L',	0,				0,			0,			0,				96,				12,			'BW_ATLAS_2',	'EABUILD_CHICHEN_ITZA'			),
('BUILD_CHRISTO_REDENTOR',	NULL,							500,	'IMPROVEMENT_CHRISTO_REDENTOR',	'TXT_KEY_EA_BUILD_CHRISTO_REDENTOR',	'TXT_KEY_EA_BUILD_CHRISTO_REDENTOR_HELP',	'TXT_KEY_EA_BUILD_CHRISTO_REDENTOR_REC',	'ENTITY_EVENT_MINE',		'KB_L',	0,				0,			0,			0,				96,				24,			'BW_ATLAS_2',	'EABUILD_CHRISTO_REDENTOR'		),
('BUILD_COLOSSUS',			'TECH_BRONZE_WORKING',			500,	'IMPROVEMENT_COLOSSUS',			'TXT_KEY_EA_BUILD_COLOSSUS',			'TXT_KEY_EA_BUILD_COLOSSUS_HELP',			'TXT_KEY_EA_BUILD_COLOSSUS_REC',			'ENTITY_EVENT_MINE',		'KB_L',	0,				0,			0,			0,				96,				4,			'BW_ATLAS_2',	'EABUILD_COLOSSUS'				),
('BUILD_FORBIDDEN_CITY',		NULL,							500,	'IMPROVEMENT_FORBIDDEN_CITY',	'TXT_KEY_EA_BUILD_FORBIDDEN_CITY',		'TXT_KEY_EA_BUILD_FORBIDDEN_CITY_HELP',		'TXT_KEY_EA_BUILD_FORBIDDEN_CITY_REC',		'ENTITY_EVENT_MINE',		'KB_L',	0,				0,			0,			0,				96,				14,			'BW_ATLAS_2',	'EABUILD_FORBIDDEN_CITY'		),
('BUILD_GREAT_LIGHTHOUSE',	'TECH_SAILING',					500,	'IMPROVEMENT_GREAT_LIGHTHOUSE',	'TXT_KEY_EA_BUILD_GREAT_LIGHTHOUSE',	'TXT_KEY_EA_BUILD_GREAT_LIGHTHOUSE_HELP',	'TXT_KEY_EA_BUILD_GREAT_LIGHTHOUSE_REC',	'ENTITY_EVENT_MINE',		'KB_A',	0,				0,			0,			0,				96,				5,			'BW_ATLAS_2',	'EABUILD_GREAT_LIBRARY'			),
('BUILD_HAGIA_SOPHIA',		NULL,							500,	'IMPROVEMENT_HAGIA_SOPHIA',		'TXT_KEY_EA_BUILD_HAGIA_SOPHIA',		'TXT_KEY_EA_BUILD_HAGIA_SOPHIA_HELP',		'TXT_KEY_EA_BUILD_HAGIA_SOPHIA_REC',		'ENTITY_EVENT_MINE',		'KB_L',	0,				0,			0,			0,				96,				8,			'BW_ATLAS_2',	'EABUILD_HAGIA_SOPHIA'			),
('BUILD_HANGING_GARDENS',		'TECH_IRRIGATION',				500,	'IMPROVEMENT_HANGING_GARDENS',	'TXT_KEY_EA_BUILD_HANGING_GARDENS',		'TXT_KEY_EA_BUILD_HANGING_GARDENS_HELP',	'TXT_KEY_EA_BUILD_HANGING_GARDENS_REC',		'ENTITY_EVENT_MINE',		'KB_L',	0,				0,			0,			0,				96,				3,			'BW_ATLAS_2',	'EABUILD_HANGING_GARDENS'		),
('BUILD_HIMEJI_CASTLE',		NULL,							500,	'IMPROVEMENT_HIMEJI_CASTLE',	'TXT_KEY_EA_BUILD_HIMEJI_CASTLE',		'TXT_KEY_EA_BUILD_HIMEJI_CASTLE_HELP',		'TXT_KEY_EA_BUILD_HIMEJI_CASTLE_REC',		'ENTITY_EVENT_MINE',		'KB_L',	0,				0,			0,			0,				96,				15,			'BW_ATLAS_2',	'EABUILD_HIMEJI_CASTLE'			),
('BUILD_KREMLIN',				NULL,							500,	'IMPROVEMENT_KREMLIN',			'TXT_KEY_EA_BUILD_KREMLIN',				'TXT_KEY_EA_BUILD_KREMLIN_HELP',			'TXT_KEY_EA_BUILD_KREMLIN_REC',				'ENTITY_EVENT_MINE',		'KB_L',	0,				0,			0,			0,				96,				13,			'BW_ATLAS_2',	'EABUILD_KREMLIN'				),
('BUILD_NOTREDAME',			'TECH_ARCHITECTURE',			500,	'IMPROVEMENT_NOTREDAME',		'TXT_KEY_EA_BUILD_NOTREDAME',			'TXT_KEY_EA_BUILD_NOTREDAME_HELP',			'TXT_KEY_EA_BUILD_NOTREDAME_REC',			'ENTITY_EVENT_MINE',		'KB_L',	0,				0,			0,			0,				96,				10,			'BW_ATLAS_2',	'EABUILD_NOTREDAME'				),
('BUILD_PORCELAIN_TOWER',		'TECH_ARCHITECTURE',			500,	'IMPROVEMENT_PORCELAIN_TOWER',	'TXT_KEY_EA_BUILD_PORCELAIN_TOWER',		'TXT_KEY_EA_BUILD_PORCELAIN_TOWER_HELP',	'TXT_KEY_EA_BUILD_PORCELAIN_TOWER_REC',		'ENTITY_EVENT_MINE',		'KB_L',	0,				0,			0,			0,				96,				16,			'BW_ATLAS_2',	'EABUILD_PORCELAIN_TOWER'		),
('BUILD_PYRAMID',				'TECH_MASONRY',					500,	'IMPROVEMENT_PYRAMID',			'TXT_KEY_EA_BUILD_PYRAMID',				'TXT_KEY_EA_BUILD_PYRAMID_HELP',			'TXT_KEY_EA_BUILD_PYRAMID_REC',				'ENTITY_EVENT_MINE',		'KB_L',	0,				0,			0,			0,				96,				0,			'BW_ATLAS_2',	'EABUILD_PYRAMID'				),
('BUILD_SISTINE_CHAPEL',		'TECH_ARCHITECTURE',			500,	'IMPROVEMENT_SISTINE_CHAPEL',	'TXT_KEY_EA_BUILD_SISTINE_CHAPEL',		'TXT_KEY_EA_BUILD_SISTINE_CHAPEL_HELP',		'TXT_KEY_EA_BUILD_SISTINE_CHAPEL_REC',		'ENTITY_EVENT_MINE',		'KB_L',	0,				0,			0,			0,				96,				17,			'BW_ATLAS_2',	'EABUILD_SISTINE_CHAPEL'		),
('BUILD_STONEHENGE',			NULL,							500,	'IMPROVEMENT_STONEHENGE',		'TXT_KEY_EA_BUILD_STONEHENGE',			'TXT_KEY_EA_BUILD_STONEHENGE_HELP',			'TXT_KEY_EA_BUILD_STONEHENGE_REC',			'ENTITY_EVENT_MINE',		'KB_L',	0,				0,			0,			0,				96,				2,			'BW_ATLAS_2',	'EABUILD_STONEHENGE'			),
('BUILD_SYDNEY_OPERA_HOUSE',	'TECH_AESTHETICS',				500,	'IMPROVEMENT_SYDNEY_OPERA_HOUSE','TXT_KEY_EA_BUILD_SYDNEY_OPERA_HOUSE',	'TXT_KEY_EA_BUILD_SYDNEY_OPERA_HOUSE_HELP',	'TXT_KEY_EA_BUILD_SYDNEY_OPERA_HOUSE_REC',	'ENTITY_EVENT_MINE',		'KB_L',	0,				0,			0,			0,				96,				27,			'BW_ATLAS_2',	'EABUILD_SYDNEY_OPERA_HOUSE'	);
--add taj mahal
*/

UPDATE Builds SET ShowInTechTree = 0 WHERE Type IN ('BUILD_FARM', 'BUILD_MINE', 'BUILD_LUMBERMILL');

UPDATE Builds SET PrereqTech = 'TECH_MASONRY' WHERE Type = 'BUILD_ROAD';
UPDATE Builds SET PrereqTech = 'TECH_STEAM_POWER' WHERE Type = 'BUILD_RAILROAD';
--UPDATE Builds SET Repair=1 WHERE Type='BUILD_REPAIR';
--UPDATE Builds SET RemoveRoute=1 WHERE Type='BUILD_REMOVE_ROUTE';

--fixinator
CREATE TABLE IDRemapper ( id INTEGER PRIMARY KEY AUTOINCREMENT, Type TEXT );
INSERT INTO IDRemapper (Type) SELECT Type FROM Builds ORDER BY ID;
UPDATE Builds SET ID =	( SELECT IDRemapper.id-1 FROM IDRemapper WHERE Builds.Type = IDRemapper.Type);
DROP TABLE IDRemapper;

--TO DO: Bait & switch improvement to entice AI to slash/burn?

DELETE FROM BuildFeatures;
INSERT INTO BuildFeatures (BuildType, FeatureType,		PrereqTech,				Time,	Production,	Remove) VALUES
--feature removal only (only blight removal open for pantheistic)
('BUILD_SCRUB_BLIGHT',			'FEATURE_BLIGHT',		NULL,					400,	0,			1	),
('BUILD_SLASH_BURN_FOREST',		'FEATURE_FOREST',		NULL,					400,	0,			1	),
('BUILD_SLASH_BURN_JUNGLE',		'FEATURE_JUNGLE',		'TECH_BRONZE_WORKING',	700,	0,			1	),
('BUILD_CHOP_FOREST',			'FEATURE_FOREST',		'TECH_BRONZE_WORKING',	400,	10,			1	),
('BUILD_CHOP_JUNGLE',			'FEATURE_JUNGLE',		'TECH_IRON_WORKING',	700,	10,			1	),
('BUILD_REMOVE_MARSH',			'FEATURE_MARSH',		'TECH_MASONRY',			600,	0,			1	),

--build on feature enabled by tech 
('BUILD_LUMBERMILL',			'FEATURE_JUNGLE',		'TECH_FORESTRY',		200,	0,			0	),	--does this work?
--('BUILD_FARM',				'FEATURE_MARSH',		'TECH_IRRIGATION',		600,	0,			0	),

--feature removal with improvement (non-pantheistic)
('BUILD_FARM',					'FEATURE_FOREST',		NULL,					400,	10,			1	),	--techs based on slash-burn
('BUILD_FARM',					'FEATURE_JUNGLE',		'TECH_BRONZE_WORKING',	700,	10,			1	),
('BUILD_FARM',					'FEATURE_MARSH',		'TECH_MASONRY',			600,	0,			1	),
('BUILD_FARM_2',				'FEATURE_FOREST',		NULL,					400,	10,			1	),
('BUILD_FARM_2',				'FEATURE_JUNGLE',		'TECH_BRONZE_WORKING',	700,	10,			1	),
('BUILD_FARM_2',				'FEATURE_MARSH',		'TECH_MASONRY',			600,	0,			1	),
('BUILD_PASTURE',				'FEATURE_FOREST',		NULL,					400,	10,			1	),
('BUILD_PASTURE',				'FEATURE_JUNGLE',		'TECH_BRONZE_WORKING',	700,	10,			1	),
('BUILD_PASTURE',				'FEATURE_MARSH',		'TECH_MASONRY',			600,	0,			1	),
('BUILD_VINEYARD',				'FEATURE_FOREST',		NULL,					400,	10,			1	),
('BUILD_VINEYARD',				'FEATURE_JUNGLE',		'TECH_BRONZE_WORKING',	700,	10,			1	),
('BUILD_VINEYARD',				'FEATURE_MARSH',		'TECH_MASONRY',			600,	0,			1	),
('BUILD_E_PLANTATION',			'FEATURE_FOREST',		NULL,					400,	10,			1	),
('BUILD_E_PLANTATION',			'FEATURE_JUNGLE',		'TECH_BRONZE_WORKING',	700,	10,			1	),
('BUILD_E_PLANTATION',			'FEATURE_MARSH',		'TECH_MASONRY',			600,	0,			1	),
('BUILD_T_PLANTATION',			'FEATURE_FOREST',		NULL,					400,	10,			1	),
('BUILD_T_PLANTATION',			'FEATURE_JUNGLE',		'TECH_BRONZE_WORKING',	700,	10,			1	),
('BUILD_T_PLANTATION',			'FEATURE_MARSH',		'TECH_MASONRY',			600,	0,			1	),
('BUILD_ORCHARD',				'FEATURE_FOREST',		NULL,					400,	10,			1	),
('BUILD_ORCHARD',				'FEATURE_JUNGLE',		'TECH_BRONZE_WORKING',	700,	10,			1	),
('BUILD_ORCHARD',				'FEATURE_MARSH',		'TECH_MASONRY',			600,	0,			1	),
('BUILD_QUARRY',				'FEATURE_FOREST',		NULL,					400,	10,			1	),
('BUILD_QUARRY',				'FEATURE_JUNGLE',		'TECH_BRONZE_WORKING',	700,	10,			1	),
('BUILD_QUARRY',				'FEATURE_MARSH',		'TECH_MASONRY',			600,	0,			1	),
('BUILD_MINE',					'FEATURE_FOREST',		NULL,					600,	10,			1	),
('BUILD_MINE',					'FEATURE_JUNGLE',		'TECH_BRONZE_WORKING',	600,	10,			1	),
('BUILD_MINE',					'FEATURE_MARSH',		'TECH_MASONRY',			600,	0,			1	),
('BUILD_MINE_2',				'FEATURE_FOREST',		NULL,					600,	10,			1	),
('BUILD_MINE_2',				'FEATURE_JUNGLE',		'TECH_BRONZE_WORKING',	600,	10,			1	),
('BUILD_MINE_2',				'FEATURE_MARSH',		'TECH_MASONRY',			600,	0,			1	),
('BUILD_WELL',					'FEATURE_FOREST',		NULL,					600,	10,			1	),
('BUILD_WELL',					'FEATURE_JUNGLE',		'TECH_BRONZE_WORKING',	600,	10,			1	),
('BUILD_WELL',					'FEATURE_MARSH',		'TECH_MASONRY',			600,	0,			1	);

INSERT INTO EaDebugTableCheck(FileName) SELECT 'UnitBuilds.sql';