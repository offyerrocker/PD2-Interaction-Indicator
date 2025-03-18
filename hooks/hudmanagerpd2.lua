Hooks:OverrideFunction(HUDManager,"_create_interaction",function(self,hud)
	InteractionIndicator:RecreateHUDInteraction(self,hud)
end)
