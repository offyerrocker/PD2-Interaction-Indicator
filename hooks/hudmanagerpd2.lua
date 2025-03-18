Hooks:OverrideFunction(HUDManager,"_create_interaction",function(self,hud)
	--table.insert(_G.olib_loadorder,"II hudmanager create interaction")
	InteractionIndicator:RecreateHUDInteraction(self,hud)
end)
