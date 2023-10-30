
HUDInteractionIndicatorPDTH = class(HUDInteraction) --clone PDTHHud's modified HUDInteraction

-- HUDManager
if PDTHHud.Options:GetValue("HUD/MainHud") and not (restoration and restoration:all_enabled("HUD/MainHUD", "HUD/Teammate")) then
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
end


-- HUDInteraction
if PDTHHud.Options:GetValue("HUD/Interaction") and not (restoration and restoration:all_enabled("HUD/MainHUD", "HUD/Interaction")) then
    local interact_tr = PDTHHud.constants.interaction_main_texture_rect
    local background_tr = PDTHHud.constants.interaction_bg_texture_rect

    local ValidColour = Color(1, 1, 1, 0)
	--local ValidColour = Color(1, 1, 0.7647058824, 0) --OLD VALUE

	Hooks:PostHook(HUDInteractionIndicatorPDTH, "init", "pdth_hud_HUDInteraction_init", function(self, hud, child_name)
	
		local const = PDTHHud.constants
        self._interaction_h = const.interact_bar_size / const.interact_h_multiplier
        self._interaction_w = ((self._interaction_h / const.interact_scale_h) * const.interact_scale_w)

        local panel_name = (child_name or "interact") .. "_panel"

        if self._hud_panel:child(panel_name) then
            self._hud_panel:remove(self._hud_panel:child(panel_name))
        end

        local poco_compat = self._hud_panel:text({
            name = "progress_timer_text",
            visible = false
        })
		
		self._interact_panel = self._hud_panel:panel({
            name = panel_name,
            layer = 10,
            visible = false,
            w = const.interact_bar_size + self._interaction_w + const.interact_bitmap_x_offset,
            h = const.interact_bar_size * 2
        })
        self._interact_panel:set_center_x(self._hud_panel:center_x())
        self._interact_panel:set_center_y(self._hud_panel:h() / 3  )

        local interact_bitmap = self._interact_panel:bitmap({
            name = "interact_bitmap",
            layer = 1,
            visible = true,
            blend_mode = "normal",
            x = 0,
            y = 0,
            w = const.interact_bar_size,
            h = const.interact_bar_size
        })

        local icon, texture_rect = tweak_data.hud_icons:get_icon_data("develop")
        interact_bitmap:set_image(icon, unpack(texture_rect))

        local interact_background = self._interact_panel:bitmap({
            name = "interact_background",
            blend_mode = "normal",
            layer = 1,
            texture = "guis/textures/pdth_hud/hud_icons",
            texture_rect = background_tr,
            w = self._interaction_w,
            h = self._interaction_h
        })
        interact_background:set_center_y(interact_bitmap:center_y())
        interact_background:set_left(interact_bitmap:right() + const.interact_bitmap_x_offset)
        local interact_bar = self._interact_panel:bitmap({
            name = "interact_bar",
            visible = true,
            layer = 2,
            texture = "guis/textures/pdth_hud/hud_icons",
            texture_rect = interact_tr,
            color = ValidColour,
            w = self._interaction_w - (const.interact_border * 2),
            h = self._interaction_h - (const.interact_border * 2)
        })
        interact_bar:set_center(interact_background:center())
        local interact_text = self._interact_panel:text({
            name = "interact_text",
            visible = true,
            text = "",
            blend_mode = "normal",
            layer = 3,
            font = tweak_data.menu.small_font,
            font_size = const.interact_font_size,
        })
        managers.hud:make_fine_text(interact_text)
        interact_text:set_center_y(interact_background:center_y())
        interact_text:set_left(interact_bar:left() + const.interact_text_x_offset)

        local invalid_text = self._interact_panel:text({
            name = "invalid_text",
            visible = false,
            text = "",
            layer = 3,
            color = Color(1, 0.3, 0.3),
            blend_mode = "normal",
            font = tweak_data.menu.small_font,
            font_size = const.interact_invalid_font_size,
        })
        managers.hud:make_fine_text(invalid_text)
        invalid_text:set_center_x(self._interact_panel:w() / 2)
        invalid_text:set_top(interact_background:bottom())

        self._interact_circle = {}
        self._interact_circle._circle = interact_bar
        self.valid = true
	
	end)
	
	--[[
	local hooked_class = HUDInteractionIndicatorPDTH
	-- InteractionIndicator/ hooks
	Hooks:PostHook(hooked_class,"show_interact","interactionindicator_showinteract",function(self,data)
		InteractionIndicator:OnStartMouseoverInteractable(self,data)
	end)

	Hooks:PostHook(hooked_class,"remove_interact","interactionindicator_removeinteract",function(self)
		InteractionIndicator:OnStopInteraction(self)
	end)

	Hooks:PostHook(hooked_class,"show_interaction_bar","interactionindicator_showinteractionbar",function(self,current,total)
		InteractionIndicator:OnInteractionStart(self,current,total)
	end)

	Hooks:PostHook(hooked_class,"set_interaction_bar_width","interactionindicator_setinteractionprogress",function(self,current,total)
		InteractionIndicator:SetInteractionProgress(self,current,total)
	end)

	Hooks:PostHook(hooked_class,"hide_interaction_bar","interactionindicator_hideinteractionbar",function(self,complete)
		InteractionIndicator:OnInteractionEnd(self,complete)
	end)

	Hooks:PostHook(hooked_class,"set_bar_valid","interactionindicator_setbarvalid",function(self,valid,text_id)
		InteractionIndicator:SetInteractTextValid(self,valid,text_id)
	end)

	--]]
	
    function HUDInteractionIndicatorPDTH:show_interact(data)
        local interact_bar = self._interact_panel:child("interact_bar")
        local interact_text = self._interact_panel:child("interact_text")
        local interact_bitmap = self._interact_panel:child("interact_bitmap")
        local interact_background = self._interact_panel:child("interact_background")
        self:remove_interact()
        local text = utf8.to_upper(data.text or "Press 'F' to interact")

        self._interact_panel:set_visible(true)
        interact_bar:set_w(0)
        interact_text:set_text(text)
        managers.hud:make_fine_text(interact_text)
        interact_text:set_center_y(interact_background:center_y())
        interact_text:set_left(interact_bar:left() + PDTHHud.constants.interact_text_x_offset)
		if self.icon then
			data.icon = self.icon -- make self.icon override the icon
			self.icon = nil 
		end
        if data.icon then
            local icon, texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
            interact_bitmap:set_image(icon, unpack(texture_rect))
        end
    end

    function HUDInteractionIndicatorPDTH:remove_interact()
        local interact_bar = self._interact_panel:child("interact_bar")
        local interact_text = self._interact_panel:child("interact_text")
        local interact_bitmap = self._interact_panel:child("interact_bitmap")
        local interact_background = self._interact_panel:child("interact_background")
        if not alive(self._interact_panel) then
            return
        end
        self._interact_panel:set_visible(false)
        local icon, texture_rect = tweak_data.hud_icons:get_icon_data("develop")
        interact_bitmap:set_image(icon, unpack(texture_rect))
    end

    function HUDInteractionIndicatorPDTH:show_interaction_bar(current, total, icon_id)
        local interact_background = self._interact_panel:child("interact_background")
        local interact_bar = self._interact_panel:child("interact_bar")
        local interact_bitmap = self._interact_panel:child("interact_bitmap")
        local interact_text = self._interact_panel:child("interact_text")
        local mul = current / total
        local width = mul * self._interaction_w
        interact_bar:set_w(width)
        self._interact_panel:set_visible(true)
        if icon_id then
            local icon, texture_rect = tweak_data.hud_icons:get_icon_data(icon_id)
            interact_bitmap:set_image(icon, unpack(texture_rect))
			self.icon = icon_id -- self.icon overrides the icon
        end
        if BetterLightFX then
            BetterLightFX:StartEvent("Interaction")
        end
    end

    function HUDInteractionIndicatorPDTH:set_interaction_bar_width(current, total)
        local interact_background = self._interact_panel:child("interact_background")
        local interact_bar = self._interact_panel:child("interact_bar")
        local interact_bitmap = self._interact_panel:child("interact_bitmap")
        local interact_text = self._interact_panel:child("interact_text")
        local invalid_text = self._interact_panel:child("invalid_text")
        local mul = current / total
        local width = mul * self._interaction_w
        interact_bar:set_w(width)
        self._interact_panel:set_visible(true)
        interact_bar:set_texture_rect(interact_tr[1], interact_tr[2], interact_tr[3] * mul, interact_tr[4])
        if not self.valid then
            interact_bar:set_color(Color.red)
            if BetterLightFX then
                BetterLightFX:StartEvent("Interaction")
                BetterLightFX:UpdateEvent("Interaction", {_custom_color = Color.red, _progress = mul})
            end
        else
            interact_bar:set_color(ValidColour)
            if BetterLightFX then
                BetterLightFX:StartEvent("Interaction")
                BetterLightFX:UpdateEvent("Interaction", {_custom_color = ValidColour, _progress = mul})
            end
        end
    end

    function HUDInteractionIndicatorPDTH:hide_interaction_bar(complete)
        local interact_bar = self._interact_panel:child("interact_bar")
        local interact_background = self._interact_panel:child("interact_background")
        if complete then
            interact_bar:set_image("guis/textures/pdth_hud/hud_icons", unpack(interact_tr))
        end
        interact_bar:set_w(0)
        self._interact_panel:set_visible(false)

        if BetterLightFX then
            BetterLightFX:UpdateEvent("Interaction", {_progress = 0})
            BetterLightFX:EndEvent("Interaction")
        end
    end

    function HUDInteractionIndicatorPDTH:set_bar_valid(valid, text_id)
        local interact_bar = self._interact_panel:child("interact_bar")
        local interact_background = self._interact_panel:child("interact_background")
        self.valid = valid
        interact_bar:set_image("guis/textures/pdth_hud/hud_icons", unpack(interact_tr))
        local invalid_text = self._interact_panel:child("invalid_text")
        if text_id then
            invalid_text:set_text(managers.localization:to_upper_text(text_id))
            managers.hud:make_fine_text(invalid_text)
            invalid_text:set_center_x(self._interact_panel:w() / 2)
            invalid_text:set_top(interact_background:bottom())
        end
        invalid_text:set_visible(not valid)
    end

    function HUDInteractionIndicatorPDTH:destroy()
        if self._interact_panel then
            self._hud_panel:remove(self._interact_panel)
            self._interact_panel = nil
        end
    end

    function HUDInteractionIndicatorPDTH:_animate_interaction_complete(bitmap, circle)
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
			bitmap:parent():remove(bitmap)
			circle:remove()
		end
    end
	
end
