--NOTE: this conflicts directly with MUI since they're both overriding the same function

--when creating the HUDInteraction instance that will hold vanilla player interaction HUD elements,
--use our custom HUDInteractionIndicator class,
--instead of sharing the same class used for Teammate AI interactions
Hooks:OverrideFunction(HUDManager,"_create_interaction",function(self,hud)
	hud = hud or managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self._hud_interaction = HUDInteractionIndicator:new(hud)
end)

--[[

Hooks:PostHook(HUDManager,"pd_stop_progress","interactionindicator_hudmanager_stop_interact",function(self)
	--InteractionIndicator:HideInteractionBar(nil,nil)
	InteractionIndicator:OnInteractionEnd()
end)

--]]