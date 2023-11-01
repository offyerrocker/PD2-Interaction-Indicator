--NOTE: this conflicts directly with MUI since they're both overriding the same function

--when creating the HUDInteraction instance that will hold vanilla player interaction HUD elements,
--use our custom HUDInteractionIndicator class,
--instead of sharing the same class used for Teammate AI interactions;
--Teammate AI interactions will use the original version of the class

--===================================--
--        VoidUI behavior
--===================================--
if VoidUI and VoidUI.options.enable_interact then
	function HUDManager:pd_start_progress(current, total, msg, icon_id)
		if not self._pd2_hud_interaction then
			-- InteractionIndicator change: use new instance of HUDInteraction instead of recycling it
			self._pd2_hud_interaction = HUDInteraction:new(managers.hud:script(PlayerBase.PLAYER_DOWNED_HUD))
		end
		
		self._pd2_hud_interaction:show_interaction_bar(current, total)
		self._hud_player_downed:hide_timer()
		local function feed_circle(o, total)
			local t = 0
			while total > t do
				t = t + coroutine.yield()
				self._pd2_hud_interaction:set_interaction_bar_width(t, total)
				self._pd2_hud_interaction:show_interact({text = utf8.to_upper(managers.localization:text(msg))})
			end
			self._pd2_hud_interaction:remove_interact()
			self._pd2_hud_interaction:hide_interaction_bar(true)
		end
		self._pd2_hud_interaction._interact_bar:stop()
		self._pd2_hud_interaction._interact_bar:animate(feed_circle, total)
	end

	function HUDManager:pd_stop_progress()
		if not self._pd2_hud_interaction then
			return
		end
		self._pd2_hud_interaction:remove_interact()
		self._pd2_hud_interaction:hide_interaction_bar(false)
		self._hud_player_downed:show_timer()
	end
end


if PDTHHud and PDTHHud.Options:GetValue("HUD/MainHud") and not (restoration and restoration:all_enabled("HUD/MainHUD", "HUD/Teammate")) then
	--===================================--
	--        PDTHHud behavior
	--===================================--
	
	function HUDManager:pd_start_progress(current, total, msg, icon_id)
		local hud = self:script(PlayerBase.PLAYER_DOWNED_HUD)

		if not hud then
			return
		end
		
		-- InteractionIndicator: use HUDInteractionIndicator cloned class instead of HUDInteraction
		self._pd2_hud_interaction = HUDInteractionIndicatorPDTH:new(managers.hud:script(PlayerBase.PLAYER_DOWNED_HUD))
	-- here icon_id
		self._pd2_hud_interaction:show_interact({text = utf8.to_upper(managers.localization:text(msg)), icon = icon_id})
		self._pd2_hud_interaction:show_interaction_bar(current, total)
		self._hud_player_downed:hide_timer()

		local function feed_circle(o, total)
			local t = 0

			while t < total do
				t = t + coroutine.yield()

				self._pd2_hud_interaction:set_interaction_bar_width(t, total)
			end
		end

		if _G.IS_VR then
			return
		end

		self._pd2_hud_interaction._interact_circle._circle:stop()
		self._pd2_hud_interaction._interact_circle._circle:animate(feed_circle, total)
	end
else
	--===================================--
	--        default behavior
	--===================================--
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
end