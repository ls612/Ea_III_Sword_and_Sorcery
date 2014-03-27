-- _Debug
-- Author: Pazyryk
-- DateCreated: 3/24/2014 10:02:52 AM
--------------------------------------------------------------

local bHidden =			MapModData.bHidden


local tableByOrderType = {	[OrderTypes.ORDER_TRAIN] = "Units",
							[OrderTypes.ORDER_CONSTRUCT] = "Buildings",
							[OrderTypes.ORDER_CREATE] = "Projects",
							[OrderTypes.ORDER_MAINTAIN] = "Processes"	}

local function DebugOnPlayerPreAIUnitUpdate(iPlayer)
	if bHidden[iPlayer] then return end
	local player = Players[iPlayer]

	print("*************************************")
	print("DebugOnPlayerPreAIUnitUpdate ", iPlayer)
	for city in player:Cities() do
		local name = city:GetName()
		print("Build queue for ", name, ":")
		local qLength = city:GetOrderQueueLength()
		if qLength > 0 then
			for i = 0, qLength - 1 do
				local queuedOrderType, queuedData1, queuedData2, queuedSave, queuedRush = city:GetOrderFromQueue(i)
				print("* ", GameInfo[tableByOrderType[queuedOrderType]][queuedData1].Type)
			end
		else
			print("!!!! WARNING: Empty build queue !!!!")
			for row in GameInfo.Units() do
				if city:CanTrain(row.ID) then
					print("* City can train ", row.Type)
				end
			end
			for row in GameInfo.Buildings() do
				if city:CanConstruct(row.ID) then
					print("* City can construct ", row.Type)
				end
			end
			for row in GameInfo.Processes() do
				if city:CanMaintain(row.ID, 1) then
					print("* City can maintain ", row.Type)
				end
			end
		end
	end
	print("*************************************")
end
GameEvents.PlayerPreAIUnitUpdate.Add(function(iPlayer) return HandleError10(DebugOnPlayerPreAIUnitUpdate, iPlayer) end)