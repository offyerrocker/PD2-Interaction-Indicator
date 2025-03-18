if VoidUI.options.enable_interact then
	local function dispose_interaction(hud_interaction)
		hud_interaction:remove_interact()
		hud_interaction:hide_interaction_bar(false)
		hud_interaction:destroy()
	end
	
	function HUDManager:pd_start_progress(current, total, msg, icon_id)
		local hud_interaction = self._ii_nonplayer_hud_interaction
		if hud_interaction then 
			dispose_interaction(hud_interaction)
		end
		
		hud_interaction = HUDInteraction:new(managers.hud:script(PlayerBase.PLAYER_DOWNED_HUD))
		self._ii_nonplayer_hud_interaction = hud_interaction
		
		hud_interaction:show_interaction_bar(current, total)
		self._hud_player_downed:hide_timer()
		local function feed_circle(o, total)
			local t = 0
			while total > t do
				t = t + coroutine.yield()
				hud_interaction:set_interaction_bar_width(t, total)
				hud_interaction:show_interact({text = utf8.to_upper(managers.localization:text(msg))})
			end
			hud_interaction:remove_interact()
			hud_interaction:hide_interaction_bar(true)
		end
		hud_interaction._interact_bar:stop()
		hud_interaction._interact_bar:animate(feed_circle, total)
	end
	
	function HUDManager:pd_stop_progress()
		local hud_interaction = self._ii_nonplayer_hud_interaction
		if not hud_interaction then
			return
		end
		
		self._hud_player_downed:show_timer()
		
		dispose_interaction(hud_interaction)
		self._ii_nonplayer_hud_interaction = nil
	end
end
