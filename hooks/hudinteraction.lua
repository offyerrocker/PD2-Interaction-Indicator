HUDInteractionIndicator = class(HUDInteraction)

--posthooking a custom class... galaxy brained
local hooked_class = HUDInteractionIndicator
InteractionIndicator.HUDInteractionIndicator = HUDInteractionIndicator

Hooks:PostHook(hooked_class,"init","interactionindicator_init",function(self,hud,child_name)
	InteractionIndicator:CreateHUD()
end)

Hooks:PostHook(hooked_class,"show_interact","interactionindicator_showinteract",function(self,data)
--	OffyLib:c_log("show_interact")
	InteractionIndicator:OnStartMouseoverInteractable(self,data)
	--InteractionIndicator:ShowInteractText(self,data)
end)

Hooks:PostHook(hooked_class,"remove_interact","interactionindicator_removeinteract",function(self)
--	OffyLib:c_log("remove_interact")
	InteractionIndicator:OnStopInteraction(self)
	--InteractionIndicator:HideInteractText(self)
end)

Hooks:PostHook(hooked_class,"show_interaction_bar","interactionindicator_showinteractionbar",function(self,current,total)
--	OffyLib:c_log("show_interaction_bar " .. string.format("%0.1f",current) .. "/" .. string.format("%0.1f",total))
	InteractionIndicator:OnInteractionStart(self,current,total)
--	InteractionIndicator:ShowInteractionBar(self,current,total)
end)

Hooks:PostHook(hooked_class,"set_interaction_bar_width","interactionindicator_setinteractionprogress",function(self,current,total)
--	OffyLib:c_log("set_interaction_bar_width " .. string.format("%0.1f",current) .. "/" .. string.format("%0.1f",total))
	InteractionIndicator:SetInteractionProgress(self,current,total)
	--InteractionIndicator:ShowInteractionProgress(self,current,total)
end)

Hooks:PostHook(hooked_class,"hide_interaction_bar","interactionindicator_hideinteractionbar",function(self,complete)
--	OffyLib:c_log("hide_interaction_bar " .. tostring(complete))
	InteractionIndicator:OnInteractionEnd(self,complete)
	--InteractionIndicator:HideInteractionBar(self,complete)
end)

Hooks:PostHook(hooked_class,"set_bar_valid","interactionindicator_setbarvalid",function(self,valid,text_id)
--	OffyLib:c_log("set_bar_valid")
	InteractionIndicator:SetInteractTextValid(self,valid,text_id)
end)

local orig_animate_complete = Hooks:GetFunction(hooked_class,"_animate_interaction_complete")
Hooks:OverrideFunction(hooked_class,"_animate_interaction_complete",function(self,bitmap,circle,...)
	if InteractionIndicator.settings.circle_enabled then
		if alive(bitmap) then 
			bitmap:stop()
			bitmap:parent():remove(bitmap)
		end
		if alive(circle) then
			circle:stop()
			circle:remove()
		end
	else
		return orig_animate_complete(self,bitmap,circle,...)
	end
end)
