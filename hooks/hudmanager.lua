Hooks:PostHook(HUDManager,"pd_stop_progress","interactionindicator_hudmanager_stop_interact",function(self)
	--InteractionIndicator:HideInteractionBar(nil,nil)
	InteractionIndicator:OnInteractionEnd()
end)