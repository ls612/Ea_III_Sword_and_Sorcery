--Contains Civilizations, Leaders, and subtables
--This file must load after EaCivilizations.sql, Units.sql and EaPeople.sql!!!!
--Data from these files are used to build Civilizations, Leaders and Traits
--Only Traits effects are modified below

-----------------------------------------------------------------------------------------
-- Civilizations
-----------------------------------------------------------------------------------------
ALTER TABLE Civilizations ADD COLUMN 'EaCivString' TEXT DEFAULT NULL;
ALTER TABLE Civilizations ADD COLUMN 'EaRace' TEXT DEFAULT NULL;
ALTER TABLE Civilizations ADD COLUMN 'EaRaceSelectionText' TEXT DEFAULT NULL;	--only the first civs with non-NULL values appear in civ selection screen
ALTER TABLE Civilizations ADD COLUMN 'EaCivName' TEXT DEFAULT NULL;
ALTER TABLE Civilizations ADD COLUMN 'EaCivTrait' TEXT DEFAULT NULL;
ALTER TABLE Civilizations ADD COLUMN 'EaRaceTrait' TEXT DEFAULT NULL;

DELETE FROM Civilizations WHERE Type NOT IN ('CIVILIZATION_MINOR', 'CIVILIZATION_BARBARIAN');	--, 'CIVILIZATION_AMERICA', 'CIVILIZATION_ARABIA', 'CIVILIZATION_CHINA', 'CIVILIZATION_EGYPT', 'CIVILIZATION_ENGLAND', 'CIVILIZATION_GERMANY');	--, 'CIVILIZATION_GREECE');

CREATE TABLE TempBaseKeepList AS SELECT Type FROM Civilizations;		--minor and barbs

UPDATE Civilizations SET ID = ID + 100;

INSERT INTO Civilizations (ID, Type,	EaCivString,	EaRace,				Description,				EaRaceSelectionText,			DefaultPlayerColor		) VALUES
(0,	'CIVILIZATION_GENERIC_MAN',			'GENERIC',		'EARACE_MAN',		'TXT_KEY_EA_MAN',			'TXT_KEY_EA_TRAIT_MAN',			'PLAYERCOLOR_AMERICA'	),
(1,	'CIVILIZATION_GENERIC_SIDHE',		'GENERIC',		'EARACE_SIDHE',		'TXT_KEY_EA_SIDHE',			'TXT_KEY_EA_TRAIT_SIDHE',		'PLAYERCOLOR_IROQUOIS'	),
(2,	'CIVILIZATION_GENERIC_HELDEOFOL',	'GENERIC',		'EARACE_HELDEOFOL',	'TXT_KEY_EA_HELDEOFOL',		NULL,							'PLAYERCOLOR_HUNS'		),
(3,	'CIVILIZATION_THE_FAY',				'THE_FAY',		'EARACE_FAY',		'TXT_KEY_EA_CIV_THE_FAY',	NULL,							'PLAYERCOLOR_BARBARIAN'	),
(4,	'CIVILIZATION_ANIMALS',				'ANIMALS',		NULL,				'TXT_KEY_EA_CIV_ANIMALS',	NULL,							'PLAYERCOLOR_BARBARIAN'	);

--note: These four IDs are hardcoded in EaSetupFunctions.lua! (FrontEnd can't reference tables so needs hard-coded IDs)


--Build out the table from EaCivs and EaCiv_Races
INSERT INTO Civilizations (Type, Description, ShortDescription, Adjective, CivilopediaTag, EaCivName, EaRace, EaCivString, DefaultPlayerColor)
SELECT REPLACE(Type, 'EACIV_', 'CIVILIZATION_') || REPLACE(EaRace, 'EARACE_', '_'), Description, ShortDescription, Adjective, CivilopediaTag, Type, EaRace, EaCivString, DefaultPlayerColor
FROM EaCivs, EaCiv_Races ON Type = EaCivNameType;

--Note to self: make sure all civs have DefaultPlayerColor and that there is some variety (or else CTD!)

UPDATE Civilizations SET ID = ID + 1000 WHERE Type IN ('CIVILIZATION_MINOR', 'CIVILIZATION_BARBARIAN');

--Build out the table from EaCivString
UPDATE Civilizations SET Description = 'TXT_KEY_EA_CIV_' || EaCivString WHERE Description IS NULL;
UPDATE Civilizations SET ShortDescription = Description || '_SHORT', Adjective = Description || '_ADJ', CivilopediaTag = Description || '_PEDIA' WHERE ShortDescription IS NULL;


UPDATE Civilizations SET EaCivTrait = 'TRAIT_' || EaCivString, EaRaceTrait = REPLACE(EaRace, 'EARACE_', 'TRAIT_') WHERE Type NOT IN (SELECT Type FROM TempBaseKeepList);

UPDATE Civilizations SET ArtDefineTag = 'BLANKLEADER_Scene', ArtStyleType = 'ARTSTYLE_EUROPEAN', ArtStyleSuffix = '_EURO', ArtStylePrefix = 'EUROPEAN', PortraitIndex = 5, IconAtlas = 'EXPANSION_CIV_COLOR_ATLAS', AlphaIconAtlas = 'EXPANSION_CIV_ALPHA_ATLAS', MapImage = 'EaGameSetupImage.dds', DawnOfManAudio = 'AS2D_DOM_SPEECH_UNITED_STATES', SoundtrackTag = 'MAN' WHERE EaRace = 'EARACE_MAN';
UPDATE Civilizations SET ArtDefineTag = 'BLANKLEADER_Scene', ArtStyleType = 'ARTSTYLE_ASIAN', ArtStyleSuffix = '_ASIA', ArtStylePrefix = 'ASIAN', PortraitIndex = 3, IconAtlas = 'EXPANSION_CIV_COLOR_ATLAS', AlphaIconAtlas = 'EXPANSION_CIV_ALPHA_ATLAS', MapImage = 'EaGameSetupImage.dds', DawnOfManAudio = 'AS2D_DOM_SPEECH_UNITED_STATES', SoundtrackTag = 'SIDHE' WHERE EaRace = 'EARACE_SIDHE';
UPDATE Civilizations SET ArtDefineTag = 'BLANKLEADER_Scene', ArtStyleType = 'ARTSTYLE_ASIAN', ArtStyleSuffix = '_ASIA', ArtStylePrefix = 'ASIAN', PortraitIndex = 3, IconAtlas = 'EXPANSION_CIV_COLOR_ATLAS', AlphaIconAtlas = 'EXPANSION_CIV_ALPHA_ATLAS', MapImage = 'EaGameSetupImage.dds', DawnOfManAudio = 'AS2D_DOM_SPEECH_UNITED_STATES', SoundtrackTag = 'SIDHE' WHERE EaRace = 'EARACE_HELDEOFOL';

UPDATE Civilizations SET DawnOfManQuote = 'TXT_KEY_CIV5_DAWN_UNITEDSTATES_TEXT', DawnOfManImage = 'DOM_Washington.dds' WHERE Type NOT IN (SELECT Type FROM TempBaseKeepList);

--below line CTDs on start; Civ5 seems to need all of these to be 'selectable' to work, so disabled selection in UI and override random slots using PRNG
--UPDATE Civilizations SET Playable = 0, AIPlayable = 0 WHERE Type NOT IN ('CIVILIZATION_GENERIC_MAN', 'CIVILIZATION_GENERIC_SIDHE');

--Fixinator
CREATE TABLE IDRemapper ( id INTEGER PRIMARY KEY AUTOINCREMENT, Type TEXT );
INSERT INTO IDRemapper (Type) SELECT Type FROM Civilizations ORDER BY ID;
UPDATE Civilizations SET ID =	( SELECT IDRemapper.id-1 FROM IDRemapper WHERE Civilizations.Type = IDRemapper.Type);
DROP TABLE IDRemapper;

DELETE FROM Civilization_Religions;
DELETE FROM Civilization_SpyNames;
DELETE FROM Civilization_Start_Along_Ocean;
DELETE FROM Civilization_Start_Along_River;
DELETE FROM Civilization_Start_Place_First_Along_Ocean;

CREATE TABLE Civilization_Traits (	'CivilizationType' TEXT,
									'TraitType' TEXT,
									FOREIGN KEY (CivilizationType) REFERENCES Civilizations(Type),
									FOREIGN KEY (TraitType) REFERENCES Traits(Type)		);


INSERT INTO Civilization_Traits (CivilizationType, TraitType)
SELECT DISTINCT Type, EaRaceTrait FROM Civilizations WHERE EaRaceTrait IS NOT NULL UNION ALL
SELECT DISTINCT Type, EaCivTrait FROM Civilizations WHERE EaCivTrait IS NOT NULL;



DELETE FROM Civilization_Leaders WHERE CivilizationType NOT IN (SELECT Type FROM TempBaseKeepList);

INSERT INTO Civilization_Leaders (CivilizationType, LeaderheadType)
SELECT Type, 'LEADER_NO_LDR_MAN' FROM Civilizations WHERE EaRace = 'EARACE_MAN' UNION ALL				--These are only starting leaders. They will change in-game!
SELECT Type, 'LEADER_NO_LDR_SIDHE' FROM Civilizations WHERE EaRace = 'EARACE_SIDHE' UNION ALL
SELECT Type, 'LEADER_NO_LDR_HELDEOFOL' FROM Civilizations WHERE EaRace = 'EARACE_HELDEOFOL' UNION ALL
SELECT Type, 'LEADER_FAND' FROM Civilizations WHERE EaRace = 'EARACE_FAY' ;


DELETE FROM Civilization_DisableTechs;			
INSERT INTO Civilization_DisableTechs (CivilizationType, TechType)
SELECT Type, 'TECH_DIVINE_LITURGY' FROM Civilizations WHERE EaRace IN ('EARACE_SIDHE', 'EARACE_HELDEOFOL') UNION ALL
SELECT Type, 'TECH_UNDERDARK_PATHS' FROM Civilizations WHERE EaRace != 'EARACE_HELDEOFOL' AND EaCivString NOT IN ('UR', 'GENERIC');


DELETE FROM Civilization_BuildingClassOverrides;
INSERT INTO Civilization_BuildingClassOverrides (CivilizationType, BuildingClassType, BuildingType) VALUES
('CIVILIZATION_MINOR',		'BUILDINGCLASS_WARRENS',		NULL	),
('CIVILIZATION_BARBARIAN',	'BUILDINGCLASS_PALACE',			NULL	);
--All wonders for barbs and minor
--Orc exlusions
--any civ overrides

CREATE TABLE Temp_Civilization_BuildingClassOverrides (EaRace, BuildingClassType, BuildingType);
INSERT INTO Temp_Civilization_BuildingClassOverrides (EaRace, BuildingClassType, BuildingType) VALUES
('EARACE_MAN',			'BUILDINGCLASS_WARRENS',		NULL					),		--min 2 / civ here to prevent base civ selection screen crash (but doesn't matter for modded screen)
('EARACE_MAN',			'BUILDINGCLASS_MOUNDS',			NULL					),
('EARACE_SIDHE',		'BUILDINGCLASS_WARRENS',		NULL					),
('EARACE_HELDEOFOL',	'BUILDINGCLASS_CASTLE',			'BUILDING_STRONGHOLD'	),
('EARACE_HELDEOFOL',	'BUILDINGCLASS_MOUNDS',			NULL					),
('EARACE_HELDEOFOL',	'BUILDINGCLASS_MONUMENT',		NULL					),
('EARACE_HELDEOFOL',	'BUILDINGCLASS_MARKETPLACE',	NULL					),
('EARACE_HELDEOFOL',	'BUILDINGCLASS_LIBRARY',		NULL					),
('EARACE_HELDEOFOL',	'BUILDINGCLASS_FAIR',			NULL					),
('EARACE_HELDEOFOL',	'BUILDINGCLASS_STONE_WORKS',	NULL					);		--Deal with The Fay later; doesn't really matter what they build

INSERT INTO Civilization_BuildingClassOverrides (CivilizationType, BuildingClassType, BuildingType)
SELECT Type, BuildingClassType, BuildingType FROM Civilizations, Temp_Civilization_BuildingClassOverrides USING (EaRace);
DROP TABLE Temp_Civilization_BuildingClassOverrides;


DELETE FROM Civilization_UnitClassOverrides;
--Minor
INSERT INTO Civilization_UnitClassOverrides (CivilizationType, UnitClassType, UnitType) VALUES
('CIVILIZATION_MINOR', 'UNITCLASS_SCOUTS_MAN',			NULL	),
('CIVILIZATION_MINOR', 'UNITCLASS_SCOUTS_SIDHE',		NULL	),
('CIVILIZATION_MINOR', 'UNITCLASS_SCOUTS_ORC',			NULL	),
('CIVILIZATION_MINOR', 'UNITCLASS_SETTLERS_MAN',		NULL	),
('CIVILIZATION_MINOR', 'UNITCLASS_SETTLERS_SIDHE',		NULL	),
('CIVILIZATION_MINOR', 'UNITCLASS_SETTLERS_ORC',		NULL	),
('CIVILIZATION_MINOR', 'UNITCLASS_CARAVAN',				NULL	),
('CIVILIZATION_MINOR', 'UNITCLASS_CARGO_SHIP',			NULL	);

INSERT INTO Civilization_UnitClassOverrides (CivilizationType, UnitClassType, UnitType)
SELECT 'CIVILIZATION_MINOR', Class, NULL FROM Units WHERE EaNoTrain IS NOT NULL;

--Normal Majors
INSERT INTO Civilization_UnitClassOverrides (CivilizationType, UnitClassType, UnitType)
SELECT Civilizations.Type, Units.Class, NULL FROM Civilizations, Units WHERE EaNoTrain IS NOT NULL AND Civilizations.EaRace IN ('EARACE_MAN', 'EARACE_SIDHE', 'EARACE_HELDEOFOL');

--Fay and Animals can't train any units! - all spawns by Lua
INSERT INTO Civilization_UnitClassOverrides (CivilizationType, UnitType, UnitClassType)
SELECT 'CIVILIZATION_THE_FAY', NULL, Type FROM UnitClasses UNION ALL
SELECT 'CIVILIZATION_ANIMALS', NULL, Type FROM UnitClasses;	

--Barbs can't train any units (spawns by Lua), but are allowed Slaves for capture
INSERT INTO Civilization_UnitClassOverrides (CivilizationType, UnitType, UnitClassType)
SELECT 'CIVILIZATION_BARBARIAN', NULL, Type FROM UnitClasses WHERE Type NOT GLOB 'UNITCLASS_SLAVES_*';

DELETE FROM Civilization_CityNames;
--Generics and fake names
INSERT INTO Civilization_CityNames (CivilizationType, CityName) VALUES
('CIVILIZATION_THE_FAY',		'TXT_KEY_EA_CITY_REPORT_AS_BUG_1'),
('CIVILIZATION_ANIMALS',		'TXT_KEY_EA_CITY_REPORT_AS_BUG_2'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_1'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_2'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_3'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_4'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_5'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_6'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_7'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_8'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_9'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_10'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_11'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_12'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_13'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_14'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_15'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_16'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_17'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_18'),
('CIVILIZATION_GENERIC_MAN',	'TXT_KEY_EA_FIRST_CITY_MAN_19'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_1'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_2'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_3'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_4'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_5'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_6'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_7'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_8'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_9'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_10'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_11'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_12'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_13'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_14'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_15'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_16'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_17'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_18'),
('CIVILIZATION_GENERIC_SIDHE',	'TXT_KEY_EA_FIRST_CITY_SIDHE_19'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_1'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_2'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_3'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_4'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_5'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_6'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_7'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_8'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_9'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_10'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_11'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_12'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_13'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_14'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_15'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_16'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_17'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_18'),
('CIVILIZATION_GENERIC_HELDEOFOL',	'TXT_KEY_EA_FIRST_CITY_HELDEOFOL_19');


--Next, Capitals (these are from EaCivs table)
--INSERT INTO Civilization_CityNames (CivilizationType, CityName)
--SELECT Civilizations.Type, CapitalName FROM Civilizations, EaCivs USING (EaCivString);

--Next, civ-specific city lists, if any (enter here)
CREATE TABLE Temp_Civilization_CityNames (EaCivString, CityName);
INSERT INTO Temp_Civilization_CityNames (EaCivString, CityName) VALUES
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_1'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_2'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_3'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_4'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_5'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_6'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_7'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_8'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_9'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_10'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_11'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_12'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_13'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_14'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_15'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_16'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_17'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_18'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_19'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_20'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_21'),
('HIPPUS',	'TXT_KEY_EACITY_HIPPUS_22');

INSERT INTO Civilization_CityNames (CivilizationType, CityName)
SELECT Type, CityName FROM Civilizations, Temp_Civilization_CityNames USING (EaCivString) ORDER BY RANDOM();
DROP TABLE Temp_Civilization_CityNames;

--Now city names by race (order will be randomized)
CREATE TABLE Temp_Civilization_CityNames (EaRace, CityName);
INSERT INTO Temp_Civilization_CityNames (EaRace, CityName) VALUES
('EARACE_MAN', 'TXT_KEY_EACITY_AEKIN'			),
('EARACE_MAN', 'TXT_KEY_EACITY_ALGRON'			),
('EARACE_MAN', 'TXT_KEY_EACITY_BILSCIRNI'		),
('EARACE_MAN', 'TXT_KEY_EACITY_BOL'				),
('EARACE_MAN', 'TXT_KEY_EACITY_BRALUNDI'		),
('EARACE_MAN', 'TXT_KEY_EACITY_BRANDEYIO'		),
('EARACE_MAN', 'TXT_KEY_EACITY_BRAVELLI'		),
('EARACE_MAN', 'TXT_KEY_EACITY_BRUNAVAGOM'		),
('EARACE_MAN', 'TXT_KEY_EACITY_DUNEYRR'			),
('EARACE_MAN', 'TXT_KEY_EACITY_DURATHROR'		),
('EARACE_MAN', 'TXT_KEY_EACITY_EICTHYRNIR'		),
('EARACE_MAN', 'TXT_KEY_EACITY_FENSOLOM'		),
('EARACE_MAN', 'TXT_KEY_EACITY_FIMBULTHUL'		),
('EARACE_MAN', 'TXT_KEY_EACITY_FIONI'			),
('EARACE_MAN', 'TXT_KEY_EACITY_FIORM'			),
('EARACE_MAN', 'TXT_KEY_EACITY_GEIRVIMUL'		),
('EARACE_MAN', 'TXT_KEY_EACITY_GIMLE'			),
('EARACE_MAN', 'TXT_KEY_EACITY_GIPUL'			),
('EARACE_MAN', 'TXT_KEY_EACITY_GJOLL'			),
('EARACE_MAN', 'TXT_KEY_EACITY_GLASIR'			),
('EARACE_MAN', 'TXT_KEY_EACITY_GLITNIR'			),
('EARACE_MAN', 'TXT_KEY_EACITY_GOMUL'			),
('EARACE_MAN', 'TXT_KEY_EACITY_GOPUL'			),
('EARACE_MAN', 'TXT_KEY_EACITY_GUNNAR'			),
('EARACE_MAN', 'TXT_KEY_EACITY_GRATH'			),
('EARACE_MAN', 'TXT_KEY_EACITY_GROTTI'			),
('EARACE_MAN', 'TXT_KEY_EACITY_GUNNTHORIN'		),
('EARACE_MAN', 'TXT_KEY_EACITY_GUNNTHRO'		),
('EARACE_MAN', 'TXT_KEY_EACITY_HETHINSEYIO'		),
('EARACE_MAN', 'TXT_KEY_EACITY_HLESEY'			),
('EARACE_MAN', 'TXT_KEY_EACITY_HLYMDOLOM'		),
('EARACE_MAN', 'TXT_KEY_EACITY_HOLL'			),
('EARACE_MAN', 'TXT_KEY_EACITY_HOTUN'			),
('EARACE_MAN', 'TXT_KEY_EACITY_HRITH'			),
('EARACE_MAN', 'TXT_KEY_EACITY_HRONN'			),
('EARACE_MAN', 'TXT_KEY_EACITY_HVERGELMI'		),
('EARACE_MAN', 'TXT_KEY_EACITY_IFING'			),
('EARACE_MAN', 'TXT_KEY_EACITY_KERLAUGAR'		),
('EARACE_MAN', 'TXT_KEY_EACITY_KORMT'			),
('EARACE_MAN', 'TXT_KEY_EACITY_LEIPT'			),
('EARACE_MAN', 'TXT_KEY_EACITY_LYR'				),
('EARACE_MAN', 'TXT_KEY_EACITY_MANI'			),
('EARACE_MAN', 'TXT_KEY_EACITY_NOATUN'			),
('EARACE_MAN', 'TXT_KEY_EACITY_NOT'				),
('EARACE_MAN', 'TXT_KEY_EACITY_NYT'				),
('EARACE_MAN', 'TXT_KEY_EACITY_OKOLNIR'			),
('EARACE_MAN', 'TXT_KEY_EACITY_ORMT'			),
('EARACE_MAN', 'TXT_KEY_EACITY_ORVASUND'		),
('EARACE_MAN', 'TXT_KEY_EACITY_OSKOPNIR'		),
('EARACE_MAN', 'TXT_KEY_EACITY_RATHSEY'			),
('EARACE_MAN', 'TXT_KEY_EACITY_RIN'				),
('EARACE_MAN', 'TXT_KEY_EACITY_RINNANDI'		),
('EARACE_MAN', 'TXT_KEY_EACITY_ROTHULSVOLLOM'	),
('EARACE_MAN', 'TXT_KEY_EACITY_RUTH'			),
('EARACE_MAN', 'TXT_KEY_EACITY_SAEKIN'			),
('EARACE_MAN', 'TXT_KEY_EACITY_SAEMORN'			),
('EARACE_MAN', 'TXT_KEY_EACITY_SAEVARSTATH'		),
('EARACE_MAN', 'TXT_KEY_EACITY_SAMSEY'			),
('EARACE_MAN', 'TXT_KEY_EACITY_SESSRYMNIR'		),
('EARACE_MAN', 'TXT_KEY_EACITY_SIGARSHOLM'		),
('EARACE_MAN', 'TXT_KEY_EACITY_SITH'			),
('EARACE_MAN', 'TXT_KEY_EACITY_SKORUSTROND'		),
('EARACE_MAN', 'TXT_KEY_EACITY_SLITH'			),
('EARACE_MAN', 'TXT_KEY_EACITY_SOGN'			),
('EARACE_MAN', 'TXT_KEY_EACITY_SOGUNES'			),
('EARACE_MAN', 'TXT_KEY_EACITY_SOLHEIMAR'		),
('EARACE_MAN', 'TXT_KEY_EACITY_STAFNSNESI'		),
('EARACE_MAN', 'TXT_KEY_EACITY_STROND'			),
('EARACE_MAN', 'TXT_KEY_EACITY_SVARANGS'		),
('EARACE_MAN', 'TXT_KEY_EACITY_SVOL'			),
('EARACE_MAN', 'TXT_KEY_EACITY_SYLG'			),
('EARACE_MAN', 'TXT_KEY_EACITY_THJOTHNUMA'		),
('EARACE_MAN', 'TXT_KEY_EACITY_THOL'			),
('EARACE_MAN', 'TXT_KEY_EACITY_THOLLEY'			),
('EARACE_MAN', 'TXT_KEY_EACITY_THORSNESI'		),
('EARACE_MAN', 'TXT_KEY_EACITY_THRYMGJOL'		),
('EARACE_MAN', 'TXT_KEY_EACITY_THYN'			),
('EARACE_MAN', 'TXT_KEY_EACITY_TRONEUEYR'		),
('EARACE_MAN', 'TXT_KEY_EACITY_ULFDALIR'		),
('EARACE_MAN', 'TXT_KEY_EACITY_ULFSIAR'			),
('EARACE_MAN', 'TXT_KEY_EACITY_UNAVAGOM'		),
('EARACE_MAN', 'TXT_KEY_EACITY_VALGRIND'		),
('EARACE_MAN', 'TXT_KEY_EACITY_VAM'				),
('EARACE_MAN', 'TXT_KEY_EACITY_VATHGELMIR'		),
('EARACE_MAN', 'TXT_KEY_EACITY_VEGSVIN'			),
('EARACE_MAN', 'TXT_KEY_EACITY_VESTRSALIR'		),
('EARACE_MAN', 'TXT_KEY_EACITY_VIGRITH'			),
('EARACE_MAN', 'TXT_KEY_EACITY_VIN'				),
('EARACE_MAN', 'TXT_KEY_EACITY_VINO'			),
('EARACE_MAN', 'TXT_KEY_EACITY_VITHI'			),
('EARACE_MAN', 'TXT_KEY_EACITY_VON'				),
('EARACE_MAN', 'TXT_KEY_EACITY_VOND'			),
('EARACE_MAN', 'TXT_KEY_EACITY_YDALIR'			),
('EARACE_MAN', 'TXT_KEY_EACITY_YLG'				),

('EARACE_SIDHE', 'TXT_KEY_EACITY_ARD_LEMNACHT'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_ARD_NA_RIAG'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_ATH_CLIATH'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_ATH_CLIATH_MEDRAIGE'),
('EARACE_SIDHE', 'TXT_KEY_EACITY_ATH_FADAT'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_ATH_LUAIN'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_BELACH_CONGLAIS'	),
('EARACE_SIDHE', 'TXT_KEY_EACITY_BAIREND_CHERMAIN'	),
('EARACE_SIDHE', 'TXT_KEY_EACITY_BEND_ETAIR'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_BELACH_DURGEIN'	),
('EARACE_SIDHE', 'TXT_KEY_EACITY_BELACH_GABRAN'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_BOAND'				),
('EARACE_SIDHE', 'TXT_KEY_EACITY_CARMUN'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_CARN_AMALGAID'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_CARN_CONAILL'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_CARN_FERADAIG'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_CARN_FRAICH'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_CARN_HUI_NEIT'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_CEILBE'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_CEIS_CHORAIND'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_CEND_FEBRAT'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_CNOGBA'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_CROTTA_CLIACH'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_CURRECH_LIFE'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_DUIBLIND'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_DUMA_SELGA'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_DUN_CRIMTHAIND'	),
('EARACE_SIDHE', 'TXT_KEY_EACITY_DUN_GABAIL'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_EO_MUGNA'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_EO_ROSSA'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_FIND_LOCH_CERA'	),
('EARACE_SIDHE', 'TXT_KEY_EACITY_FINDGLAIS'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_FORNOCHT'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_INBER_BUADA'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_LAIRGE'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_LIAMUIN'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_LOCH_CE'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_LOCH_CON'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_LOCH_DACHAECH'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_LOCH_DECHET'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_LOCH_DERGDERC'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_LOCH_ERNE'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_LOCH_GARMAN'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_LOCH_LEIN'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_LOCH_NEILL'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_LOCH_RI'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_LOCH_RIACH'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_LUIMNECH'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_MAG_MUGNA'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_MAG_RAIGNE'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_MAG_FEMIN'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_MAG_FEA'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_MAG_FERA'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_MAG_LUIRG'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_MAG_MUCRIME'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_MAG_MUIRISCE'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_MAG_N_AI'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_MAG_N_AIDNI'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_MAG_TIBRA'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_MAISTIU'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_MEDRAIGN'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_MOENMAG'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_NAS'				),
('EARACE_SIDHE', 'TXT_KEY_EACITY_RATH_CNAMROSSA'	),
('EARACE_SIDHE', 'TXT_KEY_EACITY_RATH_CRUACHAN'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_ROIRIU'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_SINANN'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_SLIAB_GAM'			),
('EARACE_SIDHE', 'TXT_KEY_EACITY_SLIAB_MAIRGE'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_SLIAB_N_ECHTGA'	),
('EARACE_SIDHE', 'TXT_KEY_EACITY_SLIAB_MISS'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_SLIGE_DALA'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_SRUB_BRAIN'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_TEMAIR_LUACHRA'	),
('EARACE_SIDHE', 'TXT_KEY_EACITY_TIPRA_SEN_GARMNA'	),
('EARACE_SIDHE', 'TXT_KEY_EACITY_TOND_CLIDNA'		),
('EARACE_SIDHE', 'TXT_KEY_EACITY_TURLOCH_SILINDE'	);

--add these in random order
INSERT INTO Civilization_CityNames (CivilizationType, CityName) SELECT Type, CityName FROM Civilizations, Temp_Civilization_CityNames USING (EaRace) WHERE EaCivString NOT IN ('GENERIC', 'THE_FAY') ORDER BY RANDOM();
DROP TABLE Temp_Civilization_CityNames;


DELETE FROM Civilization_FreeBuildingClasses;
INSERT INTO Civilization_FreeBuildingClasses (CivilizationType, BuildingClassType)
SELECT Type, 'BUILDINGCLASS_PALACE' FROM Civilizations WHERE Type != 'CIVILIZATION_BARBARIAN';


DELETE FROM Civilization_FreeTechs;
INSERT INTO Civilization_FreeTechs (CivilizationType, TechType) VALUES
('CIVILIZATION_GENERIC_SIDHE', 'TECH_HUNTING'		),
('CIVILIZATION_GENERIC_SIDHE', 'TECH_WRITING'		),
('CIVILIZATION_GENERIC_HELDEOFOL', 'TECH_MINING'		),
('CIVILIZATION_GENERIC_HELDEOFOL', 'TECH_DEEP_MINING'	);

DELETE FROM Civilization_FreeUnits;
INSERT INTO Civilization_FreeUnits (CivilizationType, UnitClassType, Count, UnitAIType) VALUES
('CIVILIZATION_GENERIC_MAN',		'UNITCLASS_SETTLERS_MAN',	1, 'UNITAI_SETTLE'	),
('CIVILIZATION_GENERIC_MAN',		'UNITCLASS_WARRIORS_MAN',	1, 'UNITAI_EXPLORE'	),
('CIVILIZATION_GENERIC_SIDHE',		'UNITCLASS_SETTLERS_SIDHE', 1, 'UNITAI_SETTLE'	),
('CIVILIZATION_GENERIC_SIDHE',		'UNITCLASS_WARRIORS_SIDHE', 1, 'UNITAI_EXPLORE'	),
('CIVILIZATION_GENERIC_HELDEOFOL',	'UNITCLASS_SETTLERS_ORC',	1, 'UNITAI_SETTLE'	),
('CIVILIZATION_GENERIC_HELDEOFOL',	'UNITCLASS_WARRIORS_ORC',	1, 'UNITAI_EXPLORE'	),
('CIVILIZATION_MINOR',				'UNITCLASS_SETTLERS_MINOR', 1, 'UNITAI_SETTLE'	);

DELETE FROM Civilization_Start_Region_Priority;
INSERT INTO Civilization_Start_Region_Priority (CivilizationType, RegionType) VALUES
('CIVILIZATION_GENERIC_SIDHE',		'REGION_FOREST'	),
('CIVILIZATION_GENERIC_HELDEOFOL',	'REGION_HILLS'	),
('CIVILIZATION_GENERIC_HELDEOFOL',	'REGION_JUNGLE'	);

DELETE FROM Civilization_Start_Region_Avoid;
INSERT INTO Civilization_Start_Region_Avoid (CivilizationType, RegionType) VALUES
('CIVILIZATION_GENERIC_MAN',	'REGION_JUNGLE'	),
('CIVILIZATION_GENERIC_MAN',	'REGION_FOREST'	);


-----------------------------------------------------------------------------------------
-- Leaders
-----------------------------------------------------------------------------------------
-- Leaders and their personality subtables converted over from EaPeople. The only Leader not from EaPeople is LEADER_BARBARIAN.
-- The first 3 leaders are dummy "No Leader" types, followed by LEADER_FAND of The Fay. So 
--	player:GetLeaderType() < GameInfoTypes.LEADER_FAND
-- means that player has no leader at this time.
-- 

ALTER TABLE Leaders ADD COLUMN 'EaPerson' TEXT DEFAULT NULL;
ALTER TABLE Leaders ADD COLUMN 'EaRace' TEXT DEFAULT NULL;

DELETE FROM Leaders WHERE Type != 'LEADER_BARBARIAN';


INSERT INTO Leaders (Type, EaPerson, Description, Civilopedia,	CivilopediaTag,				EaRace,	VictoryCompetitiveness, WonderCompetitiveness, MinorCivCompetitiveness, Boldness, DiploBalance, WarmongerHate, WorkAgainstWillingness, WorkWithWillingness, DenounceWillingness, DoFWillingness, Loyalty, Neediness, Forgiveness, Chattiness, Meanness)
SELECT LeaderType, Type, Description, Description||'_PEDIA',  Description||'_PEDIA_TAG',	Race,	VictComp,				WondComp,			   MinorComp,				Boldness, DiploBal,		WarHate,	   WorkAgnst,			   WorkWith,			Denounce,			 DoFWill,		 Loyalty, Neediness, Forgive,	  Chatty,	  Meanness
FROM EaPeople;

UPDATE Leaders SET ArtDefineTag = 'BLANKLEADER_Scene.xml', PortraitIndex = 23,	IconAtlas = 'CIV_COLOR_ATLAS';

--fixinator
CREATE TABLE IDRemapper ( id INTEGER PRIMARY KEY AUTOINCREMENT, Type TEXT );
INSERT INTO IDRemapper (Type) SELECT Type FROM Leaders ORDER BY ID;
UPDATE Leaders SET ID =	( SELECT IDRemapper.id-1 FROM IDRemapper WHERE Leaders.Type = IDRemapper.Type);
DROP TABLE IDRemapper;

DELETE FROM Leader_MajorCivApproachBiases WHERE LeaderType != 'LEADER_BARBARIAN';
INSERT INTO Leader_MajorCivApproachBiases (LeaderType, MajorCivApproachType, Bias)
SELECT LeaderType, 'MAJOR_CIV_APPROACH_WAR', MjWar FROM EaPeople UNION ALL
SELECT LeaderType, 'MAJOR_CIV_APPROACH_HOSTILE', MjHstl FROM EaPeople UNION ALL
SELECT LeaderType, 'MAJOR_CIV_APPROACH_DECEPTIVE', MjDcpt FROM EaPeople UNION ALL
SELECT LeaderType, 'MAJOR_CIV_APPROACH_GUARDED', MjGrdd FROM EaPeople UNION ALL
SELECT LeaderType, 'MAJOR_CIV_APPROACH_AFRAID', MjAfrd FROM EaPeople UNION ALL
SELECT LeaderType, 'MAJOR_CIV_APPROACH_FRIENDLY', MjFdly FROM EaPeople UNION ALL
SELECT LeaderType, 'MAJOR_CIV_APPROACH_NEUTRAL', MjNtrl FROM EaPeople ;


DELETE FROM Leader_MinorCivApproachBiases WHERE LeaderType != 'LEADER_BARBARIAN';
INSERT INTO Leader_MinorCivApproachBiases (LeaderType, MinorCivApproachType, Bias)
SELECT LeaderType, 'MINOR_CIV_APPROACH_IGNORE', MnIgnr FROM EaPeople UNION ALL
SELECT LeaderType, 'MINOR_CIV_APPROACH_FRIENDLY', MnFdly FROM EaPeople UNION ALL
SELECT LeaderType, 'MINOR_CIV_APPROACH_PROTECTIVE', MnProt FROM EaPeople UNION ALL
SELECT LeaderType, 'MINOR_CIV_APPROACH_CONQUEST', MnConq FROM EaPeople UNION ALL
SELECT LeaderType, 'MINOR_CIV_APPROACH_BULLY', MnBlly FROM EaPeople ;


DELETE FROM Leader_Flavors WHERE LeaderType != 'LEADER_BARBARIAN';
INSERT INTO Leader_Flavors (LeaderType, FlavorType, Flavor)
SELECT LeaderType, 'FLAVOR_OFFENSE', FOff FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_DEFENSE', FDef FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_CITY_DEFENSE', FCtDf FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_MILITARY_TRAINING', FMlTn FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_RECON', FRecon FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_RANGED', FRngd FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_MOBILE', FMbl FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_NAVAL', FNav FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_NAVAL_RECON', FNvRec FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_NAVAL_GROWTH', FNvGrw FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_NAVAL_TILE_IMPROVEMENT', FNvImp FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_AIR', FAir FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_EXPANSION', FExp FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_GROWTH', FGrw FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_TILE_IMPROVEMENT', FImp FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_INFRASTRUCTURE', FInf FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_PRODUCTION', FPrd FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_GOLD', FGld FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_SCIENCE', FSci FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_CULTURE', FClt FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_HAPPINESS', FHap FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_GREAT_PEOPLE', FGP FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_WONDER', FWnd FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_RELIGION', FRlg FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_DIPLOMACY', FDip FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_SPACESHIP', FSShp FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_WATER_CONNECTION', FWtCn FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_NUKE', FNuk FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_USE_NUKE', FUNuk FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_ESPIONAGE', FEsp FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_ANTIAIR', FAntA FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_AIR_CARRIER', FAirC FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_I_LAND_TRADE_ROUTE', FArch FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_I_SEA_TRADE_ROUTE', FLTr FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_ARCHAEOLOGY', FSTr FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_I_TRADE_ORIGIN', FTrOri FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_I_TRADE_DESTINATION', FTrDes FROM EaPeople UNION ALL
SELECT LeaderType, 'FLAVOR_AIRLIFT', FALift FROM EaPeople ;

DELETE FROM Leader_Traits;		--All Traits now attached to Civilizations, but this table will still work if we want a trait for a leader...

--Add sounds for each leader by race (ScriptID hardcoded by LeaderType)
INSERT INTO Audio_2DSounds (ScriptID, SoundID)
SELECT REPLACE(Type, 'EAPERSON_', 'AS2D_LEADER_MUSIC_') || '_PEACE', 'SND_LEADER_MUSIC_MAN_PEACE' FROM EaPeople WHERE Race = 'EARACE_MAN' UNION ALL
SELECT REPLACE(Type, 'EAPERSON_', 'AS2D_LEADER_MUSIC_') || '_WAR', 'SND_LEADER_MUSIC_MAN_WAR' FROM EaPeople WHERE Race = 'EARACE_MAN' UNION ALL
SELECT REPLACE(Type, 'EAPERSON_', 'AS2D_LEADER_MUSIC_') || '_PEACE', 'SND_LEADER_MUSIC_SIDHE_PEACE' FROM EaPeople WHERE Race IN ('EARACE_SIDHE', 'EARACE_FAY') UNION ALL
SELECT REPLACE(Type, 'EAPERSON_', 'AS2D_LEADER_MUSIC_') || '_WAR', 'SND_LEADER_MUSIC_SIDHE_WAR' FROM EaPeople WHERE Race IN ('EARACE_SIDHE', 'EARACE_FAY') UNION ALL
SELECT REPLACE(Type, 'EAPERSON_', 'AS2D_LEADER_MUSIC_') || '_PEACE', 'SND_LEADER_MUSIC_HELDEOFOL_PEACE' FROM EaPeople WHERE Race = 'EARACE_ORC' UNION ALL
SELECT REPLACE(Type, 'EAPERSON_', 'AS2D_LEADER_MUSIC_') || '_WAR', 'SND_LEADER_MUSIC_HELDEOFOL_WAR' FROM EaPeople WHERE Race = 'EARACE_ORC' ;

UPDATE Audio_2DSounds SET SoundType = 'GAME_MUSIC', MinVolume = 40, MaxVolume = 40, IsMusic = 1 WHERE ScriptID GLOB 'AS2D_LEADER_MUSIC_*';



INSERT INTO EaDebugTableCheck(FileName) SELECT 'Civilizations.sql';