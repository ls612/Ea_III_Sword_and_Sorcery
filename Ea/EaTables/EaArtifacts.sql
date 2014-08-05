
CREATE TABLE EaArtifacts ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,
						'Type' TEXT NOT NULL UNIQUE,
						'Description' TEXT DEFAULT NULL,
						'ItemClass' TEXT DEFAULT NULL,
						'EaAction' TEXT DEFAULT NULL,
						'IconIndex' INTEGER DEFAULT NULL,
						'IconAtlas' TEXT DEFAULT NULL);
						--Items can move around and may be associated with a plot (if in city or dropped somewhere), a GP or a non-GP unit
						--gArtifacts[ID] = nil or {mod, iPlayer, locationType, locationIndex}, where locationType = "iPlot", "iPerson", or "iUnit"
						--note: if Players[iPlayer]:GetUnitByID(iUnit) == nil then artifact will become lost for a while

--Tomes
INSERT INTO EaArtifacts (Type,			Description,									ItemClass,	EaAction) VALUES
('EA_ARTIFACT_TOME_OF_EQUUS',			'TXT_KEY_EA_ARTIFACT_TOME_OF_EQUUS',			'Tome',		'EA_ACTION_TOME_OF_EQUUS'			),
('EA_ARTIFACT_TOME_OF_BEASTS',			'TXT_KEY_EA_ARTIFACT_TOME_OF_BEASTS',			'Tome',		'EA_ACTION_TOME_OF_BEASTS'			),
('EA_ARTIFACT_TOME_OF_THE_LEVIATHAN',	'TXT_KEY_EA_ARTIFACT_TOME_OF_THE_LEVIATHAN',	'Tome',		'EA_ACTION_TOME_OF_THE_LEVIATHAN'	),
('EA_ARTIFACT_TOME_OF_HARVESTS',		'TXT_KEY_EA_ARTIFACT_TOME_OF_HARVESTS',			'Tome',		'EA_ACTION_TOME_OF_HARVESTS'		),
('EA_ARTIFACT_TOME_OF_TOMES',			'TXT_KEY_EA_ARTIFACT_TOME_OF_TOMES',			'Tome',		'EA_ACTION_TOME_OF_TOMES'			),
('EA_ARTIFACT_TOME_OF_AESTHETICS',		'TXT_KEY_EA_ARTIFACT_TOME_OF_AESTHETICS',		'Tome',		'EA_ACTION_TOME_OF_AESTHETICS'		),
('EA_ARTIFACT_TOME_OF_AXIOMS',			'TXT_KEY_EA_ARTIFACT_TOME_OF_AXIOMS',			'Tome',		'EA_ACTION_TOME_OF_AXIOMS'			),
('EA_ARTIFACT_TOME_OF_FORM',			'TXT_KEY_EA_ARTIFACT_TOME_OF_FORM',				'Tome',		'EA_ACTION_TOME_OF_FORM'			),
('EA_ARTIFACT_TOME_OF_METALLURGY',		'TXT_KEY_EA_ARTIFACT_TOME_OF_METALLURGY',		'Tome',		'EA_ACTION_TOME_OF_METALLURGY'		),

('EA_ARTIFACT_CORPUS_HERMETICUM',		'TXT_KEY_EA_ARTIFACT_CORPUS_HERMETICUM',		'Tome',		'EA_ACTION_CORPUS_HERMETICUM'		),
('EA_ARTIFACT_NECRONOMICON',			'TXT_KEY_EA_ARTIFACT_NECRONOMICON',				'Tome',		'EA_ACTION_NECRONOMICON'			),
('EA_ARTIFACT_ARS_GOETIA',				'TXT_KEY_EA_ARTIFACT_ARS_GOETIA',				'Tome',		'EA_ACTION_ARS_GOETIA'				),
('EA_ARTIFACT_BOOK_OF_EIBON',			'TXT_KEY_EA_ARTIFACT_BOOK_OF_EIBON',			'Tome',		'EA_ACTION_BOOK_OF_EIBON'			);

UPDATE EaArtifacts SET IconIndex = (SELECT IconIndex FROM EaActions WHERE EaArtifact = EaArtifacts.Type);
UPDATE EaArtifacts SET IconAtlas = (SELECT IconAtlas FROM EaActions WHERE EaArtifact = EaArtifacts.Type);
--UPDATE EaArtifacts SET Description = (SELECT Description FROM EaActions WHERE EaArtifact = EaArtifacts.Type);

CREATE TABLE EaArtifacts_TomeTechs ('ArtifactType' TEXT, 'TechType' TEXT, 'Change' FLOAT);
INSERT INTO EaArtifacts_TomeTechs (ArtifactType, TechType, Change) VALUES
('EA_ARTIFACT_TOME_OF_EQUUS',			'TECH_DOMESTICATION',		-2		),	
('EA_ARTIFACT_TOME_OF_EQUUS',			'TECH_HORSEBACK_RIDING',	-2		),	
('EA_ARTIFACT_TOME_OF_EQUUS',			'TECH_ANIMAL_HUSBANDRY',	-2		),	
('EA_ARTIFACT_TOME_OF_EQUUS',			'TECH_STIRRUPS',			-2		),	
('EA_ARTIFACT_TOME_OF_EQUUS',			'TECH_ANIMAL_INDUSTRY',		-2		),	
('EA_ARTIFACT_TOME_OF_EQUUS',			'TECH_ANIMAL_BREEDING',		-2		),	
('EA_ARTIFACT_TOME_OF_EQUUS',			'TECH_WAR_HORSES',			-2		),

('EA_ARTIFACT_TOME_OF_BEASTS',			'TECH_DOMESTICATION',		-1.5	),
('EA_ARTIFACT_TOME_OF_BEASTS',			'TECH_HUNTING',				-1.5	),
('EA_ARTIFACT_TOME_OF_BEASTS',			'TECH_ELEPHANT_LABOR',		-1.5	),
('EA_ARTIFACT_TOME_OF_BEASTS',			'TECH_TRACKING_TRAPPING',	-1.5	),
('EA_ARTIFACT_TOME_OF_BEASTS',			'TECH_ELEPHANT_TRAINING',	-1.5	),
('EA_ARTIFACT_TOME_OF_BEASTS',			'TECH_GAMEKEEPING',			-1.5	),
('EA_ARTIFACT_TOME_OF_BEASTS',			'TECH_ANIMAL_MASTERY',		-1.5	),
('EA_ARTIFACT_TOME_OF_BEASTS',			'TECH_WAR_ELEPHANTS',		-1.5	),
('EA_ARTIFACT_TOME_OF_BEASTS',			'TECH_BEAST_MASTERY',		-1.5	),
('EA_ARTIFACT_TOME_OF_BEASTS',			'TECH_MUMAKIL_RIDING',		-1.5	),

('EA_ARTIFACT_TOME_OF_THE_LEVIATHAN',	'TECH_HUNTING',				-1.5	),
('EA_ARTIFACT_TOME_OF_THE_LEVIATHAN',	'TECH_FISHING',				-1.5	),
('EA_ARTIFACT_TOME_OF_THE_LEVIATHAN',	'TECH_HARPOONS',			-1.5	),
('EA_ARTIFACT_TOME_OF_THE_LEVIATHAN',	'TECH_SAILING',				-1.5	),
('EA_ARTIFACT_TOME_OF_THE_LEVIATHAN',	'TECH_SHIP_BUILDING',		-1.5	),
('EA_ARTIFACT_TOME_OF_THE_LEVIATHAN',	'TECH_NAVIGATION',			-1.5	),
('EA_ARTIFACT_TOME_OF_THE_LEVIATHAN',	'TECH_BEAST_MASTERY',		-1.5	),
('EA_ARTIFACT_TOME_OF_THE_LEVIATHAN',	'TECH_WHALING',				-1.5	),
--('EA_ARTIFACT_TOME_OF_THE_LEVIATHAN',	'TECH_SONG_OF_LEVIATHAN',	-1.5	),

('EA_ARTIFACT_TOME_OF_HARVESTS',		'TECH_AGRICULTURE',			-2		),
('EA_ARTIFACT_TOME_OF_HARVESTS',		'TECH_MILLING',				-2		),
('EA_ARTIFACT_TOME_OF_HARVESTS',		'TECH_WEAVING',				-2		),
('EA_ARTIFACT_TOME_OF_HARVESTS',		'TECH_ZYMURGY',				-2		),
('EA_ARTIFACT_TOME_OF_HARVESTS',		'TECH_IRRIGATION',			-2		),
('EA_ARTIFACT_TOME_OF_HARVESTS',		'TECH_CALENDAR',			-2		),
('EA_ARTIFACT_TOME_OF_HARVESTS',		'TECH_FORESTRY',			-2		),
('EA_ARTIFACT_TOME_OF_HARVESTS',		'TECH_FINE_TEXTILES',		-2		),
('EA_ARTIFACT_TOME_OF_HARVESTS',		'TECH_OENOLOGY',			-2		),
('EA_ARTIFACT_TOME_OF_HARVESTS',		'TECH_CROP_ROTATION',		-2		),

('EA_ARTIFACT_TOME_OF_AESTHETICS',		'TECH_WRITING',				-2		),
('EA_ARTIFACT_TOME_OF_AESTHETICS',		'TECH_PHILOSOPHY',			-2		),
('EA_ARTIFACT_TOME_OF_AESTHETICS',		'TECH_DRAMA',				-2		),
('EA_ARTIFACT_TOME_OF_AESTHETICS',		'TECH_MATHEMATICS',			-2		),
('EA_ARTIFACT_TOME_OF_AESTHETICS',		'TECH_LITERATURE',			-2		),
('EA_ARTIFACT_TOME_OF_AESTHETICS',		'TECH_MUSIC',				-2		),
('EA_ARTIFACT_TOME_OF_AESTHETICS',		'TECH_AESTHETICS',			-2		),
--('EA_ARTIFACT_TOME_OF_AESTHETICS',		'TECH_ETHEREAL_ARCHITECTURE',-2		),

('EA_ARTIFACT_TOME_OF_AXIOMS',			'TECH_WRITING',				-2		),
('EA_ARTIFACT_TOME_OF_AXIOMS',			'TECH_CURRENCY',			-2		),
('EA_ARTIFACT_TOME_OF_AXIOMS',			'TECH_MATHEMATICS',			-2		),
('EA_ARTIFACT_TOME_OF_AXIOMS',			'TECH_ASTRONOMY',			-2		),
('EA_ARTIFACT_TOME_OF_AXIOMS',			'TECH_ALCHEMY',				-2		),
('EA_ARTIFACT_TOME_OF_AXIOMS',			'TECH_MECHANICS',			-2		),
('EA_ARTIFACT_TOME_OF_AXIOMS',			'TECH_CHEMISTRY',			-2		),
('EA_ARTIFACT_TOME_OF_AXIOMS',			'TECH_MEDICINE',			-2		),
('EA_ARTIFACT_TOME_OF_AXIOMS',			'TECH_MACHINERY',			-2		),
('EA_ARTIFACT_TOME_OF_AXIOMS',			'TECH_STEAM_POWER',			-2		),

('EA_ARTIFACT_TOME_OF_FORM',			'TECH_MINING',				-2		),
('EA_ARTIFACT_TOME_OF_FORM',			'TECH_MASONRY',				-2		),
('EA_ARTIFACT_TOME_OF_FORM',			'TECH_CONSTRUCTION',		-2		),
('EA_ARTIFACT_TOME_OF_FORM',			'TECH_SANITATION',			-2		),
('EA_ARTIFACT_TOME_OF_FORM',			'TECH_ENGINEERING',			-2		),
('EA_ARTIFACT_TOME_OF_FORM',			'TECH_METAL_CASTING',		-2		),
('EA_ARTIFACT_TOME_OF_FORM',			'TECH_ARCHITECTURE',		-2		),
('EA_ARTIFACT_TOME_OF_FORM',			'TECH_MACHINERY',			-2		),
--('EA_ARTIFACT_TOME_OF_FORM',			'TECH_ETHEREAL_ARCHITECTURE',-2		),

('EA_ARTIFACT_TOME_OF_METALLURGY',		'TECH_MINING',				-2		),
('EA_ARTIFACT_TOME_OF_METALLURGY',		'TECH_COINAGE',				-2		),
('EA_ARTIFACT_TOME_OF_METALLURGY',		'TECH_BRONZE_WORKING',		-2		),
('EA_ARTIFACT_TOME_OF_METALLURGY',		'TECH_DEEP_MINING',			-2		),
('EA_ARTIFACT_TOME_OF_METALLURGY',		'TECH_IRON_WORKING',		-2		),
('EA_ARTIFACT_TOME_OF_METALLURGY',		'TECH_METAL_CASTING',		-2		),
('EA_ARTIFACT_TOME_OF_METALLURGY',		'TECH_STEEL_WORKING',		-2		),
('EA_ARTIFACT_TOME_OF_METALLURGY',		'TECH_ELEMENTAL_FORGING',	-2		),
('EA_ARTIFACT_TOME_OF_METALLURGY',		'TECH_MITHRIL_WORKING',		-2		),


('EA_ARTIFACT_CORPUS_HERMETICUM',		'TECH_DIVINE_LITURGY',		-2		),
('EA_ARTIFACT_CORPUS_HERMETICUM',		'TECH_DIVINE_VITALISM',		-2		),
('EA_ARTIFACT_CORPUS_HERMETICUM',		'TECH_HEAVENLY_CYCLES',		-2		),
('EA_ARTIFACT_CORPUS_HERMETICUM',		'TECH_DIVINE_ESSENCE',		-2		),
('EA_ARTIFACT_CORPUS_HERMETICUM',		'TECH_CELESTIAL_KNOWLEDGE',	-2		),
('EA_ARTIFACT_CORPUS_HERMETICUM',		'TECH_DIVINE_INTERVENTION',	-2		),
('EA_ARTIFACT_CORPUS_HERMETICUM',		'TECH_KNOWLEDGE_OF_HEAVEN',	-2		),

('EA_ARTIFACT_NECRONOMICON',			'TECH_MALEFICIUM',			-2		),
('EA_ARTIFACT_NECRONOMICON',			'TECH_REANIMATION',			-2		),
--('EA_ARTIFACT_NECRONOMICON',			'TECH_VAMPIRISM',			-2		),
('EA_ARTIFACT_NECRONOMICON',			'TECH_NECROMANCY',			-2		),
('EA_ARTIFACT_NECRONOMICON',			'TECH_SOUL_BINDING',		-2		),
('EA_ARTIFACT_NECRONOMICON',			'TECH_ARMAGEDDON_RITUALS',	-2		),

('EA_ARTIFACT_ARS_GOETIA',				'TECH_MALEFICIUM',			-2		),
('EA_ARTIFACT_ARS_GOETIA',				'TECH_THAUMATURGY',			-2		),
--('EA_ARTIFACT_ARS_GOETIA',			'TECH_LYCANTHROPY',			-2		),
('EA_ARTIFACT_ARS_GOETIA',				'TECH_SORCERY',				-2		),
('EA_ARTIFACT_ARS_GOETIA',				'TECH_SUMMONING',			-2		),
('EA_ARTIFACT_ARS_GOETIA',				'TECH_BREACH',				-2		),
('EA_ARTIFACT_ARS_GOETIA',				'TECH_ARMAGEDDON_RITUALS',	-2		),

('EA_ARTIFACT_BOOK_OF_EIBON',			'TECH_THAUMATURGY',			-2		),
('EA_ARTIFACT_BOOK_OF_EIBON',			'TECH_CONJURATION',			-2		),
('EA_ARTIFACT_BOOK_OF_EIBON',			'TECH_TRANSMUTATION',		-2		),
('EA_ARTIFACT_BOOK_OF_EIBON',			'TECH_EVOCATION',			-2		),
('EA_ARTIFACT_BOOK_OF_EIBON',			'TECH_ABJURATION',			-2		),
--('EA_ARTIFACT_BOOK_OF_EIBON',			'TECH_ILLUSION',			-2		),
--('EA_ARTIFACT_BOOK_OF_EIBON',			'TECH_ENCHANTMENT',			-2		),
('EA_ARTIFACT_BOOK_OF_EIBON',			'TECH_INVOCATION',			-2		),
--('EA_ARTIFACT_BOOK_OF_EIBON',			'TECH_GREATER_ILLUSION',	-2		),
('EA_ARTIFACT_BOOK_OF_EIBON',			'TECH_GREATER_ARCANA',		-2		),
--('EA_ARTIFACT_BOOK_OF_EIBON',			'TECH_PHANTASMAGORIA',		-2		),
('EA_ARTIFACT_BOOK_OF_EIBON',			'TECH_ESOTERIC_ARCANA',		-2		);

-- Tome of Confusion with +mod?!

INSERT INTO EaDebugTableCheck(FileName) SELECT 'EaArtifacts.sql';