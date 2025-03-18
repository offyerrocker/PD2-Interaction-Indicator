local base_interact_class = MUIInteract

InteractionIndicator:ApplyHooks(base_interact_class)

-- the hud has already been created at this point,
-- but redefine it just in case it gets called again during the course of the game
function HUDManager:_create_interaction()
	table.insert(_G.olib_loadorder,"II-mui hudmanager create interaction")
	
	-- remove prev hud interaction
	InteractionIndicator:RecreateHUDInteraction(self,self._mui_hud);
end

function HUDManager.pd_start_progress(self, current, total, msg, icon_id)
	local intrct = self._mui_ii_nonplayer_hud_interaction
	if intrct then 
		intrct:hide_interaction_bar(intrct._circle:color().red >= 1);
		intrct:remove_interact();
		intrct:destroy();
		intrct = nil;
	end
	intrct = base_interact_class:new(self._mui_hud); -- use base hud interaction class for non-player interactions
	self._mui_ii_nonplayer_hud_interaction = intrct;
	intrct:animate(managers.localization:text(msg), current, total);
end

function HUDManager:pd_stop_progress()
	local intrct = self._mui_ii_nonplayer_hud_interaction;
	intrct:hide_interaction_bar(intrct._circle:color().red >= 1);
	intrct:remove_interact();
end

-- and remove the existing hud interaction instance, recreate it with our cloned and hooked class instead
InteractionIndicator:RecreateHUDInteraction(managers.hud,managers.hud._mui_hud);
