
function HUDManager:_create_interaction(hud)
	hud = hud or managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self._hud_interaction = HUDInteractionIndicator:new(hud)
end


--[[

Hooks:PostHook(HUDManager,"pd_stop_progress","interactionindicator_hudmanager_stop_interact",function(self)
	--InteractionIndicator:HideInteractionBar(nil,nil)
	InteractionIndicator:OnInteractionEnd()
end)

--]]