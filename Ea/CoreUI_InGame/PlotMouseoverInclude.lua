
--Paz notes: Updated for BNW (not carefully)

--Paz add
include("EaTextUtils")

MapModData.gT =  MapModData.gT or {}
local gT = MapModData.gT
local OBSERVER_TEAM = GameDefines.MAX_MAJOR_CIVS - 1

--we do some customization by player
local g_iActivePlayer = Game.GetActivePlayer()
local g_activePlayer = Players[g_iActivePlayer]
local g_iActiveTeam = g_activePlayer:GetTeam()
local g_activeTeam = Teams[g_iActiveTeam]
local function OnActivePlayerChanged(iActivePlayer, iPrevActivePlayer)
	g_iActivePlayer = iActivePlayer
	g_activePlayer = Players[g_iActivePlayer]
	g_iActiveTeam = g_activePlayer:GetTeam()
	g_activeTeam = Teams[g_iActiveTeam]
end
Events.GameplaySetActivePlayer.Add(OnActivePlayerChanged)
--end Paz add

-------------------------------------------------
-- Memoize a few localization string lookups 
-- since we use these so often.
-------------------------------------------------
local LocaleLookup = Locale.Lookup;
function Memoize_TableDescriptionByType(tableName)
	local memoizeData = {};
	local dbTable = GameInfo[tableName];
	
	return function(type)
		local text = memoizeData[type];
		if(text == nil) then
			text =  LocaleLookup(dbTable[type].Description);
			memoizeData[type] = text;
		end
		
		return text;
	end
end

local memoize_LocaleLookupData = {};
function Memoize_LocaleLookup(key)
	local text = memoize_LocaleLookupData[key];
	if(text == nil) then
		text = LocaleLookup(key);
		memoize_LocaleLookupData[key] = text;
	end
	
	return text;
end

local GetFeatureText = Memoize_TableDescriptionByType("Features");
local GetTerrainText = Memoize_TableDescriptionByType("Terrains");
local GetImprovementText = Memoize_TableDescriptionByType("Improvements");
local GetRouteText = Memoize_TableDescriptionByType("Routes");

-------------------------------------------------
-------------------------------------------------
function GetCivStateQuestString(plot, bShortVersion)
	local resultStr = "";
	--[[Paz: modified below
	local iActivePlayer = Game.GetActivePlayer();
	local iActiveTeam = Game.GetActiveTeam();
	local pTeam = Teams[iActiveTeam];
	]]
	local iActivePlayer = g_iActivePlayer
	local iActiveTeam = g_iActiveTeam
	local pTeam = g_activeTeam
	--end Paz modified
	
	for iPlayerLoop = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS-1, 1 do	
		pOtherPlayer = Players[iPlayerLoop];
		iOtherTeam = pOtherPlayer:GetTeam();
			
		if( pOtherPlayer:IsMinorCiv() and iActiveTeam ~= iOtherTeam and pOtherPlayer:IsAlive() and pTeam:IsHasMet( iOtherTeam ) ) then
			
			-- Does the player have a quest to kill a barb camp here?
			if (pOtherPlayer:IsMinorCivActiveQuestForPlayer(iActivePlayer, MinorCivQuestTypes.MINOR_CIV_QUEST_KILL_CAMP)) then
				local iQuestData1 = pOtherPlayer:GetQuestData1(iActivePlayer, MinorCivQuestTypes.MINOR_CIV_QUEST_KILL_CAMP);
				local iQuestData2 = pOtherPlayer:GetQuestData2(iActivePlayer, MinorCivQuestTypes.MINOR_CIV_QUEST_KILL_CAMP);
				if (iQuestData1 == plot:GetX() and iQuestData2 == plot:GetY()) then
					if (bShortVersion) then
						resultStr =  "[COLOR_POSITIVE_TEXT]" .. Memoize_LocaleLookup("TXT_KEY_CITY_STATE_BARB_QUEST_SHORT") .. "[ENDCOLOR]";
					else
						if (resultStr ~= "") then
							resultStr = resultStr .. "[NEWLINE]";
						end
						
						resultStr = resultStr .. "[COLOR_POSITIVE_TEXT]" .. Locale.ConvertTextKey("TXT_KEY_CITY_STATE_BARB_QUEST_LONG",  pOtherPlayer:GetCivilizationShortDescriptionKey()) .. "[ENDCOLOR]";
					end
				end
			end
			
		end
	end		

	--Paz add: tack on plot effects (Glyphs, Runes and Wards)
	local effectID, effectStength, iEffectPlayer, iCaster = plot:GetPlotEffectData()
	local bOwnEffect = iActivePlayer == iEffectPlayer
	local bObserver = iActiveTeam == OBSERVER_TEAM
	local revealedPlotEffects = (not bObserver) and gT.gPlayers[g_iActivePlayer].revealedPlotEffects
	if effectID ~= -1 and (bOwnEffect or bObserver or revealedPlotEffects[plot:GetPlotIndex()]) then	--show it
		--"Explosive Runes (Yours)"
		local effectInfo = GameInfo.EaPlotEffects[effectID]
		local effectStr = Locale.Lookup(effectInfo.Description)
		local txtColorTag = effectInfo.TextColor
		local ownerStr
		if bOwnEffect then
			ownerStr = "Yours"
		else
			ownerStr = Locale.Lookup(PreGame.GetCivilizationShortDescription(iEffectPlayer))
		end
		if (resultStr ~= "") then
			resultStr = resultStr .. "[NEWLINE]"
		end
		resultStr = resultStr .. txtColorTag .. effectStr .. " (" .. ownerStr .. "; " .. effectStength .. ")[ENDCOLOR]"
	end
	--end Paz add
	
	return resultStr;
end

-------------------------------------------------
-------------------------------------------------
function GetNatureString(plot)
	--print("PazDebug PlotMouseoverInclude GetNatureString")
	local natureStr = "";
	
	local bFirst = true;
	
	local iFeature = plot:GetFeatureType();
	
	-- Some Features are handled in a special manner, since they always have the same terrain type under it
	if (IsFeatureSpecial(iFeature)) then
		if (bFirst) then
			bFirst = false;
		else
			natureStr = natureStr .. ", ";
		end
		
		local convertedKey = GetFeatureText(plot:GetFeatureType());
		natureStr = natureStr .. convertedKey;

		--Paz add: Living Terrain strength
		if iFeature == GameInfoTypes.FEATURE_JUNGLE or iFeature == GameInfoTypes.FEATURE_MARSH then
			local improvementID = plot:GetImprovementType()
			if improvementID == -1 or (improvementID ~= GameInfoTypes.IMPROVEMENT_FARM and improvementID ~= GameInfoTypes.IMPROVEMENT_LUMBERMILL) or plot:IsImprovementPillaged() then
				natureStr = natureStr .. " (" .. plot:GetLivingTerrainStrength() .. ")"
			end
		end
		--end Paz add
		
	-- Not a jungle
	else
		
		local bMountain = false;
		
		-- Feature
		if (iFeature > -1) then
			if (bFirst) then
				bFirst = false;
			else
				natureStr = natureStr .. ", ";
			end
			
			-- Block terrian type below
			if (GameInfo.Features[plot:GetFeatureType()].NaturalWonder) then
				bMountain = true;
			end
			
			local convertedKey = GetFeatureText(plot:GetFeatureType());
			natureStr = natureStr .. convertedKey;

			--Paz add: Living Terrain strength
			if iFeature == GameInfoTypes.FEATURE_FOREST then
				if plot:GetImprovementType() ~= GameInfoTypes.IMPROVEMENT_LUMBERMILL or plot:IsImprovementPillaged() then
					natureStr = natureStr .. " (" .. plot:GetLivingTerrainStrength() .. ")"
				end
			end
			--end Paz add
			
		-- No Feature
		else
			
			-- Mountain
			if (plot:IsMountain()) then
				if (bFirst) then
					bFirst = false;
				else
					natureStr = natureStr .. ", ";
				end
				
				bMountain = true;
				
				natureStr = natureStr .. Memoize_LocaleLookup( "TXT_KEY_PLOTROLL_MOUNTAIN" );
			end
			
		end
			
		-- Terrain
		if (not bMountain) then
			if (bFirst) then
				bFirst = false;
			else
				natureStr = natureStr .. ", ";
			end
			
			local convertedKey;
			
			-- Lake?
			if (plot:IsLake()) then
				convertedKey = Memoize_LocaleLookup( "TXT_KEY_PLOTROLL_LAKE" );
			else
				convertedKey = GetTerrainText(plot:GetTerrainType());		
			end
			
			natureStr = natureStr .. convertedKey;
		end
	end	-- End Feature hack
	
	-- Hills
	if (plot:IsHills()) then
		if (bFirst) then
			bFirst = false;
		else
			natureStr = natureStr .. ", ";
		end
		
		natureStr = natureStr .. Memoize_LocaleLookup( "TXT_KEY_PLOTROLL_HILL" );
	end

	-- River
	if (plot:IsRiver()) then
		if (bFirst) then
			bFirst = false;
		else
			natureStr = natureStr .. ", ";
		end
		
		natureStr = natureStr .. Memoize_LocaleLookup( "TXT_KEY_PLOTROLL_RIVER" );
	end
	
	return natureStr;
	
end


-------------------------------------------------
-------------------------------------------------
function IsFeatureSpecial(iFeature)
	
	if (iFeature == GameInfoTypes["FEATURE_JUNGLE"]) then
		return true;
	elseif (iFeature == GameInfoTypes["FEATURE_MARSH"]) then
		return true;
	elseif (iFeature == GameInfoTypes["FEATURE_OASIS"]) then
		return true;
	elseif (iFeature == GameInfoTypes["FEATURE_ICE"]) then
		return true;
	end
	
	return false;
	
end


-------------------------------------------------
-------------------------------------------------
function GetResourceString(plot, bLongForm)
	--print("PazDebug PlotMouseoverInclude GetResourceString")
	local improvementStr = "";
	
	local iActiveTeam = Game.GetActiveTeam();
	local pTeam = Teams[iActiveTeam];

	--Paz add
	if MapModData.bAutoplay then
		iActiveTeam = -1		--very hacky but it works
	end
	--end Paz add
	
	if (plot:GetResourceType(iActiveTeam) >= 0) then
		local resourceType = plot:GetResourceType(iActiveTeam);
		--Paz add
		if resourceType == GameInfoTypes.RESOURCE_BLIGHT then return "" end
		--end Paz add

		local pResource = GameInfo.Resources[resourceType];
		
		if (plot:GetNumResource() > 1) then
			improvementStr = improvementStr .. plot:GetNumResource() .. " ";
		end
		
		--Paz modified to line below: local convertedKey = Memoize_LocaleLookup(pResource.Description);	
		local convertedKey = pResource.EaMapName and Memoize_LocaleLookup(pResource.EaMapName) or Memoize_LocaleLookup(pResource.Description)
	
		improvementStr = improvementStr .. pResource.IconString .. " " .. convertedKey;
		
		-- Resource Hookup info
		local iTechCityTrade = GameInfoTypes[pResource.TechCityTrade];
		if (iTechCityTrade ~= nil) then
			if (iTechCityTrade ~= -1 and not pTeam:GetTeamTechs():HasTech(iTechCityTrade)) then

				local techName = GameInfo.Technologies[iTechCityTrade].Description;
				if (bLongForm) then
					improvementStr = improvementStr .. " " .. Locale.ConvertTextKey( "TXT_KEY_PLOTROLL_REQUIRES_TECH_TO_USE", techName );
				else
					improvementStr = improvementStr .. " " .. Locale.ConvertTextKey( "TXT_KEY_PLOTROLL_REQUIRES_TECH", techName );
				end
			end
		end
	end
	
	return improvementStr;
	
end


-------------------------------------------------
-------------------------------------------------
function GetImprovementString(plot)


	local improvementStr = "";
	
	local iActiveTeam = Game.GetActiveTeam();
	local pTeam = Teams[iActiveTeam];

	local iImprovementType = plot:GetRevealedImprovementType(iActiveTeam, bIsDebug);
	--Paz add
	if MapModData.bAutoplay then
		iImprovementType = plot:GetImprovementType()
	end
	--end Paz add

	if (iImprovementType >= 0 and iImprovementType ~= GameInfoTypes.IMPROVEMENT_BLIGHT) then		--Paz added IMPROVEMENT_BLIGHT condition
		--[[Paz modified below
		if (improvementStr ~= "") then
			improvementStr = improvementStr .. ", ";
		end
		local convertedKey = Locale.ConvertTextKey(GameInfo.Improvements[iImprovementType].Description);		
		improvementStr = improvementStr .. convertedKey;
		]]
		if iImprovementType == GameInfoTypes.IMPROVEMENT_BARBARIAN_CAMP then
			local encampmentID = gT.gWorld.encampments[plot:GetPlotIndex()]
			if encampmentID then
				local eaEncampmentInfo = GameInfo.EaEncampments[encampmentID]
				improvementStr = Locale.ConvertTextKey(eaEncampmentInfo.Description)
			else
				print("!!!! WARNING: Barb camp is not registered in gWorld.encampments; iPlot = " .. plot:GetPlotIndex())
				improvementStr = GetImprovementText(iImprovementType)
			end
		elseif iImprovementType == GameInfoTypes.IMPROVEMENT_ARCANE_TOWER then
			improvementStr = plot:GetScriptData()	
		elseif iImprovementType == GameInfoTypes.IMPROVEMENT_RUINS then
			improvementStr = plot:GetScriptData() .. " (Ruins)"		
		else
			improvementStr = GetImprovementText(iImprovementType)
		end
		--end Paz modified

		if plot:IsImprovementPillaged() then
			improvementStr = improvementStr .." " .. Memoize_LocaleLookup("TXT_KEY_PLOTROLL_PILLAGED")
		end
	end

	local iRouteType = plot:GetRevealedRouteType(iActiveTeam, bIsDebug);
	--Paz add
	if MapModData.bAutoplay then
		iRouteType = plot:GetRouteType()
	end
	--end Paz add
	if (iRouteType > -1) then
		if (improvementStr ~= "") then
			improvementStr = improvementStr .. ", ";
		end
		local convertedKey = GetRouteText(iRouteType);		
		improvementStr = improvementStr .. convertedKey;
		--improvementStr = improvementStr .. "Road";
		
		if (plot:IsRoutePillaged()) then
			improvementStr = improvementStr .. " " .. Memoize_LocaleLookup("TXT_KEY_PLOTROLL_PILLAGED")
		end
	end
	
	return improvementStr;

end


-------------------------------------------------
-------------------------------------------------
function GetUnitsString(plot)

	local strUnitText = "";

	local iActiveTeam = Game.GetActiveTeam();
	local pTeam = Teams[iActiveTeam];
	local bIsDebug = Game.IsDebugMode();
	local bFirstEntry = true;
	
	-- Loop through all units
	local numUnits = plot:GetNumUnits();
	for i = 0, numUnits do
		
		local unit = plot:GetUnit(i);
		if (unit ~= nil and not unit:IsInvisible(iActiveTeam, bIsDebug)) then

			if (bFirstEntry) then
				bFirstEntry = false;
			else
				strUnitText = strUnitText .. "[NEWLINE]";
			end

			local strength = 0;
			strength = unit:GetBaseCombatStrength();

			--[[Paz modified below	
			local pPlayer = Players[unit:GetOwner()];
			
			-- Player using nickname
			if (pPlayer:GetNickName() ~= nil and pPlayer:GetNickName() ~= "") then
				strUnitText = strUnitText .. Locale.ConvertTextKey("TXT_KEY_MULTIPLAYER_UNIT_TT", pPlayer:GetNickName(), pPlayer:GetCivilizationAdjectiveKey(), unit:GetNameKey());
			-- Use civ short description
			else
				if(unit:HasName()) then
					local desc = Locale.ConvertTextKey("TXT_KEY_PLOTROLL_UNIT_DESCRIPTION_CIV", pPlayer:GetCivilizationAdjectiveKey(), unit:GetNameKey());
					strUnitText = strUnitText .. string.format("%s (%s)", unit:GetNameNoDesc(), desc); 
				else
					strUnitText = strUnitText .. Locale.ConvertTextKey("TXT_KEY_PLOTROLL_UNIT_DESCRIPTION_CIV", pPlayer:GetCivilizationAdjectiveKey(), unit:GetNameKey());
				end
			end
			]]

			strUnitText = strUnitText .. GetEaUnitFullName(unit)


			--end Paz modified
			
			local unitTeam = unit:GetTeam();
			if iActiveTeam == unitTeam then
				strUnitText = "[COLOR_WHITE]" .. strUnitText .. "[ENDCOLOR]";
			elseif pTeam:IsAtWar(unitTeam) then
				strUnitText = "[COLOR_NEGATIVE_TEXT]" .. strUnitText .. "[ENDCOLOR]";
			else
				strUnitText = "[COLOR_POSITIVE_TEXT]" .. strUnitText .. "[ENDCOLOR]";
			end
			
			-- Debug stuff
			if (OptionsManager:IsDebugMode()) then
				strUnitText = strUnitText .. " ("..tostring(unit:GetOwner()).." - " .. tostring(unit:GetID()) .. ")";
			end
			
			-- Combat strength
			if (strength > 0) then
				strUnitText = strUnitText .. ", [ICON_STRENGTH]" .. unit:GetBaseCombatStrength();
			end
			
			-- Hit Points
			if (unit:GetDamage() > 0) then
				strUnitText = strUnitText .. ", " .. Locale.ConvertTextKey("TXT_KEY_PLOTROLL_UNIT_HP", GameDefines["MAX_HIT_POINTS"] - unit:GetDamage());
			end
			
			-- Embarked?
			if (unit:IsEmbarked()) then
				strUnitText = strUnitText .. ", " .. Memoize_LocaleLookup( "TXT_KEY_PLOTROLL_EMBARKED" );
			end
			
			-- Building something?
			--if (unit:GetBuildType() ~= -1) then
				--strUnitText = strUnitText .. ", " .. Locale.ConvertTextKey(GameInfo.Builds[unit:GetBuildType()].Description);
			--end
		end			
	end	
	
	return strUnitText;
	
end


-------------------------------------------------
-------------------------------------------------
function GetOwnerString(plot)

	local strOwner = "";
	
	local iActiveTeam = Game.GetActiveTeam();
	local pTeam = Teams[iActiveTeam];
	local bIsDebug = Game.IsDebugMode();
	
	-- City here?
	if (plot:IsCity()) then
		
		local pCity = plot:GetPlotCity();
		if (pCity ~= nil) then
			local iCityOwner = pCity:GetOwner();
			local pCityOwner = Players[iCityOwner];
			if (pCityOwner ~= nil) then
				if (pCityOwner:IsMinorCiv()) then
					local strCivName = pCityOwner:GetCivilizationShortDescriptionKey();
					strOwner = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_OF", strCivName);
				else
					local strAdjectiveKey = pCityOwner:GetCivilizationAdjectiveKey();
					local strCityName = pCity:GetName()
					strOwner = Locale.ConvertTextKey("TXT_KEY_CITY_OF", strAdjectiveKey, strCityName);
				end	
			end
		end
		
	-- No city, see if this plot is just owned
	else
		
		-- Plot owner
		local iOwner = plot:GetRevealedOwner(iActiveTeam, bIsDebug);
		
		if (iOwner >= 0) then
			local pPlayer = Players[iOwner];
			
			-- Player using nickname
			if (pPlayer:GetNickName() ~= nil and pPlayer:GetNickName() ~= "") then
				strOwner = Locale.ConvertTextKey("TXT_KEY_PLOTROLL_OWNED_PLAYER", pPlayer:GetNickName());
			-- Use civ short description
			else
				strOwner = Locale.ConvertTextKey("TXT_KEY_PLOTROLL_OWNED_CIV", pPlayer:GetCivilizationShortDescriptionKey());
			end
				local iActiveTeam = Game.GetActiveTeam();
				local plotTeam = pPlayer:GetTeam();
				if iActiveTeam == plotTeam then
					strOwner = "[COLOR_WHITE]" .. strOwner .. "[ENDCOLOR]";
				elseif pTeam:IsAtWar(plotTeam) then
					strOwner = "[COLOR_NEGATIVE_TEXT]" .. strOwner .. "[ENDCOLOR]";
				else
					strOwner = "[COLOR_POSITIVE_TEXT]" .. strOwner .. "[ENDCOLOR]";
				end
		end
	end


	
	return strOwner;

end


-------------------------------------------------
-------------------------------------------------
function GetYieldString(plot)
	--print("PazDebug PlotMouseoverInclude GetYieldString")
	local strYield = "";
	
	-- food
	local iNumFood = plot:CalculateYield(0, true);
	if (iNumFood > 0) then
		strYield = strYield .. "[ICON_FOOD] " .. iNumFood .. " ";
	end
	
	-- production
	local iNumProduction = plot:CalculateYield(1, true);
	if (iNumProduction > 0) then
		strYield = strYield .. "[ICON_PRODUCTION] " .. iNumProduction .. " ";
	end
	
	-- gold
	local iNumGold = plot:CalculateYield(2, true);
	if (iNumGold > 0) then
		strYield = strYield .. "[ICON_GOLD] " .. iNumGold .. " ";
	end
	
	-- science
	local iNumScience = plot:CalculateYield(3, true);
	if (iNumScience > 0) then
		strYield = strYield .. "[ICON_RESEARCH] " .. iNumScience .. " ";
	end
	
    	-- culture	
	local iNumCulture = plot:CalculateYield(4, true);
	if (iNumCulture > 0) then
		strYield = strYield .. "[ICON_CULTURE] " .. iNumCulture .. " ";
	end
	
	-- Faith
	local iNumFaith = plot:CalculateYield(5, true);
	if (iNumFaith > 0) then
		--Paz disabled: strYield = strYield .. "[ICON_PEACE] " .. iNumFaith .. " ";

		--Paz add
		local iconStr = "[ICON_STAR] "
		if plot:GetOwner() ~= -1 and gT.gPlayers then
			local eaPlayer = gT.gPlayers[plot:GetOwner()]
			if eaPlayer and eaPlayer.bUsesDivineFavor then
				iconStr = "[ICON_PEACE] "
			end
		end
		strYield = strYield .. iconStr .. iNumFaith .. " "
		--end Paz add

	end

	-- Happiness (should probably be calculated in CvPlayer)
	local featureType = plot:GetFeatureType();
	if(featureType ~= FeatureTypes.NO_FEATURE) then
		local featureInfo = GameInfo.Features[featureType];
		if(featureInfo ~= nil) then
			local plotHappiness = featureInfo.InBorderHappiness;
			local naturalWonderYieldModifier = Players[Game.GetActivePlayer()]:GetNaturalWonderYieldModifier();
			if(naturalWonderYieldModifier > 0) then
				plotHappiness = plotHappiness * (100 + naturalWonderYieldModifier);
				plotHappiness = math.floor(plotHappiness / 100);	
			end
			
			if(plotHappiness > 0) then
				strYield = strYield .. "[ICON_HAPPINESS_1] " .. plotHappiness .. " ";
			end
		end
	end
	
	return strYield;
	
end

-------------------------------------------------
-------------------------------------------------
function GetInternationalTradeRouteString(plot)
	local strTradeRouteStr = "";
	local iActivePlayer = Game.GetActivePlayer();
	local astrTradeRouteStrings = Players[iActivePlayer]:GetInternationalTradeRoutePlotToolTip(plot);
		
	for i,v in ipairs(astrTradeRouteStrings) do	
		if (strTradeRouteStr == "") then
			strTradeRouteStr = strTradeRouteStr .. Memoize_LocaleLookup("TXT_KEY_TRADE_ROUTE_TT_PLOT_HEADING");
		else
			strTradeRouteStr = strTradeRouteStr .. "[NEWLINE]";
		end
	
		strTradeRouteStr = strTradeRouteStr .. v.String;
	end
	
	return strTradeRouteStr;
end

