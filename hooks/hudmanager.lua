Hooks:PostHook(HUDManager,"pd_stop_progress","interactionindicator_hudmanager_stop_interact",function(self)
	log("Doot")
	InteractionIndicator:HideInteractionBar(nil,nil)
end)