Hooks:PostHook(HUDInteraction,"init","interactionindicator_init",function(self,hud,child_name)
	InteractionIndicator:CreateHUD() --(self,hud,child_name)
end)

Hooks:PostHook(HUDInteraction,"show_interact","interactionindicator_showinteract",function(self,data)
	InteractionIndicator:ShowInteractText(self,data)
end)

Hooks:PostHook(HUDInteraction,"remove_interact","interactionindicator_removeinteract",function(self)
	InteractionIndicator:HideInteractText(self)
end)

Hooks:PostHook(HUDInteraction,"show_interaction_bar","interactionindicator_showinteractionbar",function(self,current,total)
	InteractionIndicator:ShowInteractionBar(self,current,total)
end)

Hooks:PostHook(HUDInteraction,"set_interaction_bar_width","interactionindicator_setinteractionprogress",function(self,current,total)
	InteractionIndicator:ShowInteractionProgress(self,current,total)
end)

Hooks:PostHook(HUDInteraction,"hide_interaction_bar","interactionindicator_hideinteractionbar",function(self,complete)
	InteractionIndicator:HideInteractionBar(self,complete)
end)

Hooks:PostHook(HUDInteraction,"set_bar_valid","interactionindicator_setbarvalid",function(self,valid,text_id)
	InteractionIndicator:SetInteractTextValid(self,valid,text_id)
end)

local orig_animate_interaction_complete = HUDInteraction._animate_interaction_complete
function HUDInteraction:_animate_interaction_complete(bitmap, circle,...)
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
		return orig_animate_interaction_complete(self,bitmap,circle,...)
	end
end
