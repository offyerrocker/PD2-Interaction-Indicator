--todo figure out timer text positioning
--menu
--i/o
--localization
--colorpicker code

InteractionIndicator = InteractionIndicator or {}
do 
	local save_path = SavePath
	local mod_path = (InteractionIndicatorCore and InteractionIndicatorCore:GetPath()) or ModPath
	InteractionIndicator._mod_core = InteractionIndicatorCore
	InteractionIndicator._mod_path = mod_path
	InteractionIndicator._menu_path = mod_path .. "menu/options.json"
	InteractionIndicator._default_localization_path = mod_path .. "localization/english.json"
	InteractionIndicator._save_path = save_path .. "interaction_indicator.ini"
end

InteractionIndicator.url_colorpicker = "https://modworkshop.net/mod/29641"

InteractionIndicator._timer_format_string = "%0.1f"
--default; rebuilt on settings load/settings changed

InteractionIndicator.settings = {
	hud_compatibility_mode = false,
		--[bool]
		--	true: alternate hud creation hook is engaged. this may cause the II hud to be visible in the lobby state
		--	false: alternate hud creation hook is not engaged. II hud is created during regular pd2 hud creation
	indicator_line_visible_on_mouseover = true,
		--[bool]
		--	true: displays the indicator line when aiming at an interactable object without interacting 
		--	false: does not display the indicator line when that thing i just said
	indicator_line_visible_on_interact = true,
		--[bool]
		--	true: displays the indicator line when interacting with an object
		--	false: does not display the indicator line when that thing i just said
	line_w = 2,
		--[float] the width of the indicator line
	line_alpha = 0.5,
		--[float] the opacity of the indicator line. smaller values are more transparent
	line_color = 0xffffff,
		--[number] a hexadecimal number representing the color of the custom interaction timer
	line_blend_mode = "normal",
		--[string]
		--	"normal"
		--	"add"
		--	"sub"
		--	"mul"
		--	"mulx2"
		--no menu option
		
	indicator_dot_visible_on_mouseover = true,
		--[bool]
		--	true: displays the indicator dot over the object when aiming at an interactable object without interacting 
		--	false: does not display the indicator dot when that thing i just said
	indicator_dot_visible_on_interact = true,
		--[bool]
		--	true: displays the indicator dot over the object when interacting with an object
		--	false: does not display the indicator dot when that thing i just said
	dot_radius = 4,
		--[float] the radius of the indicator dot, which appears over an interactable object
	dot_alpha = 0.66,
		--[float] the opacity of the indicator dot. smaller values are more transparent
	dot_color = 0xffffff,
		--[number] a hexadecimal number representing the color of the custom interaction timer
		
	circle_enabled = true,
		--[bool]
		--	true: custom interaction circle is visible. also hides vanilla interaction circle
		--	false: custom interaction circle is invisible. vanilla interaction circle is unchanged
	circle_alignment_mode = 2,
		--[int]
		--	1: align in screen middle (vanilla/default)
		--	2: align on object
	circle_radius = 32,
		--[float] radius of interaction circle and its bg
		--interaction progress ring; default 64
	circle_screen_margin = 16,
		--[float] screen boundary margin
		--interaction circle will stay this many pixels from the edge of the screen; set to 0 to allow offscreen clipping
	circle_x = 0,
		--[float] horizontal coordinate
		--no menu option
	circle_y = 0,
		--[float] vertical coordinate
		--no menu option
	circle_halign = 1,
		--[int]
		--	1: left; circle_x sign is unchanged (positive)
		--	2: right; circle_x sign is reversed (negative)
		--no menu option
	circle_valign = 1,
		--[int] (top / bottom)
		--	1: top; circle_y sign is unchanged (positive)
		--	2: bottom; circle_y sign is reversed (negative)
		--no menu option
	circle_animate_duration = 0.33,
		--[float] the amount of seconds for an animation to last before disappearing
		--no menu option
	
	text_enabled = true,
		--[bool]
		--	true: custom interaction timer is visible
		--	false: custom interaction timer is not visible
	text_font_name = "fonts/font_medium_shadow_mf",
		--[string] the asset path to the font used for the text
		--no menu option
	text_font_size = 32,
		--[float] the size of the text
	text_halign = "center",
		--[string] horizontal alignment
		--	"left": aligned from the left side of the screen
		--	"center": aligned from the horizontal center of the screen
		--	"right": aligned from the right side of the screen
		--no menu option
	text_valign = "top",
		--[string] vertical alignment
		--	"top": aligned from the top of the screen
		--	"center": aligned from the vertical center of the screen
		--	"bottom": aligned from the bottom of the screen
		--no menu option
	text_x = 0,
		--[float] horizontal coordinate
		--no menu option
	text_y = 480,
		--[float] vertical coordinate
		--no menu option
	text_color = 0xffffff,
		--[number] a hexadecimal number representing the text color.
	timer_accuracy_places = 2,
		--[int] [1-3] index representing decimal place accuracy choice.
			--1: no decimal point, integer timer only (rounded)
			--2: show 1 decimal place
			--3: show 2 decimal places
	timer_show_total = false,
		--[bool]
		--	true: shows the remaining interaction time and the total interaction time
		--	false: shows only the remaining interaction time
	timer_show_seconds_suffix = true,
		--[bool]
		--	true: shows the seconds suffix after each time value 
		--	false: does not show the seconds suffix
	timer_seconds_suffix = "s",
		--[string] the suffix to show after the timer, eg. "12.5s/30s" or "12.5s"
		--no menu option
	
	timer_accuracy = nil
		--DEPRECATED- DO NOT USE
		--use timer_accuracy_places instead
		--[float] [0-2]
		--	number of decimal places shown
		
}

InteractionIndicator.default_palettes = {
	"ff0000",
	"ffff00",
	"00ff00",
	"00ffff",
	"0000ff",
	"880000",
	"888800",
	"008800",
	"008888",
	"000088",
	"ff8800",
	"88ff00",
	"00ff88",
	"0088ff",
	"8800ff",
	"884400",
	"448800",
	"008844",
	"004488",
	"440088",
	"ffffff",
	"bbbbbb",
	"888888",
	"444444",
	"000000"
}
InteractionIndicator.palettes = table.deep_map_copy(InteractionIndicator.default_palettes)

InteractionIndicator.settings_sort = {
	"hud_compatibility_mode",
	
	"indicator_line_visible_on_mouseover",
	"indicator_line_visible_on_interact",
	"line_w",
	"line_alpha",
	"line_color",
	"line_blend_mode",
	
	"indicator_dot_visible_on_mouseover",
	"indicator_dot_visible_on_interact",
	"dot_radius",
	"dot_alpha",
	"dot_color",
	
	"circle_enabled",
	"circle_alignment_mode",
	"circle_radius",
	"circle_screen_margin",
	"circle_x",
	"circle_y",
	"circle_halign",
	"circle_valign",
	"circle_animate_duration",
	
	"text_enabled",
	"text_font_name",
	"text_font_size",
	"text_halign",
	"text_valign",
	"text_x",
	"text_y",
	"text_color",
	"timer_accuracy_places",
	"timer_show_total",
	"timer_show_seconds_suffix",
	"timer_seconds_suffix",
	
	"timer_accuracy"
}

do
	--load ini parser
	local f,e = blt.vm.loadfile(InteractionIndicator._mod_path .. "utils/LIP.lua")
	local lip
	if e then 
		log("[Horizon Indicator in HUD] ERROR: Failed loading LIP module. Try re-installing BeardLib if this error persists.")
	elseif f then 
		lip = f()
	end
	if lip then 
		InteractionIndicator._lip = lip
	end
end

--debug only; requires Console
function InteractionIndicator:log(s,...)
	if Console then 
		Console:Log("[InteractionIndicator] " .. tostring(s),...)
	else
		log("[InteractionIndicator] " .. tostring(s))
	end
end



--creates (or deletes and recreates) the ii hud elements
function InteractionIndicator:CreateHUD()
	if not managers.hud then 
		return
	end
	
	self:StopAnimateInteractionComplete()
	
	if alive(self._panel) then 
		self._panel:parent():remove(self._panel)
		self._panel = nil
	end
	
	local line_color = Color(string.format("%06x",self.settings.line_color))
	local line_w = self.settings.line_w
	local line_alpha = self.settings.line_alpha
	
	local dot_color = Color(string.format("%06x",self.settings.dot_color))
	local dot_radius = self.settings.dot_radius
	local dot_w = dot_radius * 2
	local dot_h = dot_radius * 2
	local dot_alpha = self.settings.dot_alpha
	
	local circle_radius = self.settings.circle_radius
	local circle_w = circle_radius * 2
	local circle_h = circle_radius * 2
	local circle_x = self.settings.circle_x
	local circle_y = self.settings.circle_y
	local circle_halign = self.settings.circle_halign
	local circle_valign = self.settings.circle_valign
	
	local text_color = Color(string.format("%06x",self.settings.text_color))
	local text_font_name = self.settings.text_font_name
	local text_font_size = self.settings.text_font_size
	local text_valign = self.settings.text_valign
	local text_halign = self.settings.text_halign
	local text_x = self.settings.text_x
	local text_y = self.settings.text_y
	
	if circle_halign == 2 then 
		circle_x = -circle_x
	end
	if circle_valign == 2 then 
		circle_y = -circle_y
	end
	
	local interactionindicator_panel
	
--	local parent_panel = hudinteraction._hud_panel
	local parent_panel = managers.hud._fullscreen_workspace:panel()
	if alive(parent_panel) then
		interactionindicator_panel = parent_panel:panel({
			name = "interactionindicator_panel"
		})
	else
		self:log("ERROR: No parent panel")
		return
	end
	self._panel = interactionindicator_panel
	local center_x,center_y = interactionindicator_panel:center()
	
	local indicator_line = interactionindicator_panel:rect({
		name = "indicator_line",
		color = line_color,
		visible = false, --changed on update
		w = line_w,
		alpha = line_alpha,
		layer = 2,
		h = 0, --changed on update
		rotation = 0 --changed on update
	})
	
	local indicator_dot = interactionindicator_panel:bitmap({
		name = "indicator_dot",
		color = dot_color,
		texture = "guis/textures/circlefill",
		texture_rect = {
			48,
			48,
			16,
			16
		},
		w = dot_w,
		h = dot_h,
		layer = 3,
		alpha = dot_alpha,
		visible = false
	})
	
	local indicator_home = interactionindicator_panel:rect({ --only used as a position marker- never visible
		name = "indicator_home",
		w = 1,
		h = 1,
		layer = -1,
		visible = false,
		color = Color.red,
		alpha = 0.5
	})
	indicator_home:set_center(interactionindicator_panel:center())
	local interaction_circle = interactionindicator_panel:bitmap({
		name = "interaction_circle",
		blend_mode = "add",
		layer = 5,
		w = circle_w,
		h = circle_h,
		texture = "guis/textures/pd2/hud_progress_active",
		render_template = "VertexColorTexturedRadial",
		color = Color(0,1,1), --0% progress initially 
		alpha = 1,
		visible = false
	})
	local interaction_circle_bg = interactionindicator_panel:bitmap({
		name = "interaction_circle_bg",
		blend_mode = "normal",
		layer = 4,
		w = circle_w,
		h = circle_h,
		texture = "guis/textures/pd2/hud_progress_bg",
		color = Color.white,
		alpha = 1,
		visible = false
	})
	
	local interaction_text = interactionindicator_panel:text({
		name = "interaction_text",
		blend_mode = "normal",
		text = "",
		layer = 6,
		font = text_font_name,
		font_size = text_font_size,
		color = text_color,
		align = text_halign,
		vertical = text_valign,
		x = text_x,
		y = text_y,
		visible = false
	})
	
	interaction_circle:set_center(center_x + circle_x,center_y + circle_y)
	interaction_circle_bg:set_center(center_x + circle_x,center_y + circle_y)
	
	managers.hud:add_updator("interactionindicator_update",callback(self,self,"Update"))
end

--removes ii's interaction circle ghost element (used in completion animation only)
function InteractionIndicator:StopAnimateInteractionComplete()
	if alive(self._panel) then 
		local ghost = self._panel:child("interaction_circle_ghost")
		if alive(ghost) then 
			self._panel:remove(ghost)
		end
	end
end

--create the circle ghost and start the animation
function InteractionIndicator:AnimateInteractionComplete()
	if alive(self._panel) then
		local align_circle_to_target = self.settings.circle_alignment_mode == 2
		local circle_animate_duration = self.settings.circle_animate_duration
		local circle_radius = self.settings.circle_radius
		
		local player = managers.player:local_player()
		
		local pos
		local ws
		local current_camera
		if align_circle_to_target then
			if alive(player) then
				local state = player:movement():current_state()
				local interaction_data = state._interaction
				if interaction_data then
					local active_unit = interaction_data:active_unit()
					if active_unit then 
						
						local obj = self:GetInteractObject(active_unit)
						if obj then 
							if obj.oobb and obj:oobb() then 
								pos = obj:oobb():center()
							else
								pos = obj:position()
							end
						end
						pos = pos or (active_unit:oobb() and active_unit:oobb():center()) or active_unit:position()
						ws = managers.hud._fullscreen_workspace
						current_camera = managers.viewport:get_current_camera()
					end
				end
			end
		end
		
		self:StopAnimateInteractionComplete()
		
		local interaction_circle = self._panel:child("interaction_circle")
		local interaction_circle_ghost = self._panel:bitmap({
			name = "interaction_circle_ghost",
			blend_mode = "add",
			layer = 7,
			w = circle_radius * 2,
			h = circle_radius * 2,
			x = interaction_circle:x(),
			y = interaction_circle:y(),
			texture = "guis/textures/pd2/hud_progress_active",
			render_template = "VertexColorTexturedRadial",
			color = Color(1,1,1),
			alpha = 1,
			visible = true
		})
		interaction_circle_ghost:animate(function(o)
			local t = 0
			local duration = circle_animate_duration
			while t <= duration do 
				dt = coroutine.yield()
				t = t + dt
				local elapsed = math.max(0,duration - t)
				local progress = elapsed / duration
				local prog_sq = progress * progress
				o:set_alpha(prog_sq)
				if pos then 
					local to_pos = ws:world_to_screen(current_camera,pos)
					o:set_world_center(to_pos.x,to_pos.y)
				end
			end
			o:parent():remove(o)
		end)
	end
end

--called once when a new interaction object is moused over
function InteractionIndicator:OnStartMouseoverInteractable(hudinteraction,data)
	--show line and dot only if mouseover is enabled
	--or if the current "interaction" is deploying a deployable equipment
	
	if alive(self._panel) then
		local is_deploying
		local player = managers.player:local_player()
		if alive(player) then 
			is_deploying = player:movement():current_state():is_deploying()
		end
		
		if not is_deploying then
--			OffyLib:c_log("ShowInteractText()")
			if self.settings.indicator_dot_visible_on_mouseover then 
				self._panel:child("indicator_dot"):show()
			end
			if self.settings.indicator_line_visible_on_mouseover then 
				self._panel:child("indicator_line"):show()
			end
		end
	end
end

--called once when mousing away from the current interaction object
--also called once when mousing over a new interaction object, before OnStartMouseoverInteractable()
--also called once on "dirty" (instant) interact
function InteractionIndicator:OnStopInteraction(hudinteraction)
	--hide text, dot, and line
	--the custom ii circle is hidden in the completion animation instead of here
	
	if alive(self._panel) then
		self._panel:child("interaction_text"):hide()
		--OffyLib:c_log("HideInteractText()")
		
		local is_mouseover = self:GetInteractionActiveUnit() and true or false
				
		if is_mouseover then
			if not self.settings.indicator_dot_visible_on_mouseover then 
				self._panel:child("indicator_dot"):hide()
			end
			if not self.settings.indicator_line_visible_on_mouseover then 
				self._panel:child("indicator_line"):hide()
			end
		else
			self._panel:child("indicator_line"):hide()
			self._panel:child("indicator_dot"):hide()
		end
	end
end

--called once when interaction begins
function InteractionIndicator:OnInteractionStart(hudinteraction,current,total)
	--show text, dot, and line (according to settings)
	--also show the custom interact circle if that is enabled
	if alive(self._panel) then
		self:SetInteractionProgress(hudinteraction,current,total)
		if self.settings.indicator_line_visible_on_interact then
			self._panel:child("indicator_dot"):show()
			self._panel:child("indicator_line"):show()
			
		end
		
		if self.settings.text_enabled then
			self._panel:child("interaction_text"):show()
		end
		
		if self.settings.circle_enabled then
			--show ii custom interaction circle
			self._panel:child("interaction_circle"):show()
			self._panel:child("interaction_circle_bg"):show()

			--hide the game's default interact circle when custom circle is enabled 
			if hudinteraction then 
				
				--MUI compatibility; hudinteraction in this case is MUIInteract
				if alive(hudinteraction._circle) then 
					--hide MUI's interaction circle
					hudinteraction._circle:stop()
					hudinteraction._circle:hide()
				end
				
				--PDTH HUD: don't attempt to hide the interaction progress bar, since that HUD has a mod option already
				
				--default pd2 hud: hide interact circle
				if hudinteraction._interact_circle and hudinteraction._interact_circle.set_visible then 
					-- _interact_circle is a CircleGuiObject wrapper, not the GuiObject itself, so alive() won't work
					hudinteraction._interact_circle:set_visible(false) --GETTA OUTTA HERE
				end
			end
		end
	end
end

--called every frame while interaction is in progress, to update hud progress
--also called once at interaction start to reset visual state
function InteractionIndicator:SetInteractionProgress(hudinteraction,current,total)
	if alive(self._panel) then 
		if self.settings.circle_enabled then
			self._panel:child("interaction_circle"):set_color(Color(current/total,1,1))
		end
		if self.settings.text_enabled then
			local format_string = self:GetTimerFormat()
			
			local timer_counts_down = self.settings.timer_counts_down	
			local countdown
			if timer_counts_down then 
				countdown = current
			else
				countdown = total - current
			end
		
			local interaction_text = self._panel:child("interaction_text")
			if alive(interaction_text) then
				interaction_text:set_text(string.format(format_string,countdown,total))
			end
		end
	end
end

--called once when interaction ends
--note that this still may be called when manually cancelling an interaction (releasing the button) but continuing to look at the interaction object
function InteractionIndicator:OnInteractionEnd(hudinteraction,complete)
	local panel = self._panel
	if alive(panel) then
		panel:child("interaction_text"):hide()
		
		panel:child("interaction_circle"):hide()
		panel:child("interaction_circle_bg"):hide()
		
		local is_mouseover = self:GetInteractionActiveUnit() and true or false
		
		if is_mouseover then
			if not self.settings.indicator_dot_visible_on_mouseover then 
				panel:child("indicator_dot"):hide()
			end
			if not self.settings.indicator_line_visible_on_mouseover then 
				panel:child("indicator_line"):hide()
			end
		else
			panel:child("indicator_line"):hide()
			panel:child("indicator_dot"):hide()
		end
		
		
		if complete then 
			if self.settings.circle_enabled then
				self:AnimateInteractionComplete()
			end
		end
	end
end

--called each frame when deploying deployable equipment (eg. doc bag)
function InteractionIndicator:SetInteractTextValid(hudinteraction,valid,text_id)
	--normally, pd2 uses this to determine which text to show:
	--the red "invalid placement" text, or the white "placing xyz deployable..." text
	--but ii only shows the timer, so it is not necessary for ii to do anything at this point
end


--update function; runs every frame
--when interaction is active, updates the render position for custom hud elements such as the line and dot, and circle if circle target alignment is enabled
function InteractionIndicator:Update(t,dt)
--	local use_custom_interact_circle = self.settings.circle_enabled
	local align_circle_to_target = self.settings.circle_alignment_mode == 2

	local indicator_dot_visible_on_mouseover = self.settings.indicator_dot_visible_on_mouseover
	local indicator_dot_visible_on_interact = self.settings.indicator_dot_visible_on_interact
	
	local indicator_line_visible_on_mouseover = self.settings.indicator_line_visible_on_mouseover
	local indicator_line_visible_on_interact = self.settings.indicator_line_visible_on_interact
	
	local circle_radius = self.settings.circle_radius
	local circle_screen_margin = self.settings.circle_screen_margin
	local interaction_circle_screen_margin = circle_radius + circle_screen_margin
	
--	local hudinteraction = managers.hud._hud_interaction
	local line_w = self.settings.line_w
	local panel = self._panel
	if alive(panel) then
		local indicator_line = panel:child("indicator_line")
		local indicator_dot = panel:child("indicator_dot")
		
		local current_game_state = game_state_machine:last_queued_state_name()
		
		local player = managers.player:local_player()
		if alive(player) then
			local state = player:movement():current_state()
			
			--camera access interaction triggers a different camera perspective but this doesn't affect the current interaction object
			--so manually hide the interaction when entering the camera access state
			--known issue: camera access will not show the dot/line when exiting camera access until looking away from the interact object; probably won't bother fixing that
			if current_game_state == "ingame_access_camera" then-- or game_state_machine:verify_game_state(GameStateFilters.need_revive,current_game_state) then
				indicator_dot:set_visible(false)
				indicator_line:set_visible(false)
				return
			end
			
			local is_deploying = state:is_deploying()
			
			local interaction_data = state._interaction
			local is_interacting = state:_interacting() or (interaction_data and interaction_data._active_object_locked_data and true or false)
			
			local pos
			local to_pos
			local to_x,to_y = panel:center()
			
			local active_unit = interaction_data and interaction_data:active_unit()
			if active_unit and not is_deploying then
				pos = pos or (active_unit:oobb() and active_unit:oobb():center()) or active_unit:position()
			
				local obj = self:GetInteractObject(active_unit)
				
				if obj then 
					if obj.oobb and obj:oobb() then 
						pos = obj:oobb():center()
					else
						pos = obj:position()
					end
				end
				
				to_pos = managers.hud._fullscreen_workspace:world_to_screen(managers.viewport:get_current_camera(),pos)
				if to_pos then
					to_x,to_y = to_pos.x,to_pos.y
				end
			end
			
			if circle_screen_margin > 0 then
				to_x = math.clamp(to_x,interaction_circle_screen_margin,panel:w() - interaction_circle_screen_margin)
				to_y = math.clamp(to_y,interaction_circle_screen_margin,panel:h() - interaction_circle_screen_margin)
			end
			
			local from_x,from_y = panel:child("indicator_home"):world_center() --world center
			
			if align_circle_to_target then 
				--draw line from screen center
				--(offset by user preference)
				panel:child("interaction_circle"):set_world_center(to_x,to_y)
				panel:child("interaction_circle_bg"):set_world_center(to_x,to_y)
				local interaction_circle_ghost = panel:child("interaction_circle_ghost")
				if alive(interaction_circle_ghost) then 
					interaction_circle_ghost:set_world_center(to_x,to_y)
				end
			end
			
			local d_x = (to_x - from_x) - (line_w / 2)
			local d_y = to_y - from_y
			
			local hyp = math.sqrt((d_x * d_x) + (d_y * d_y))
			
			local angle = math.atan(d_y / d_x) + 90
			
			
			indicator_line:set_h(hyp)
			indicator_line:set_rotation(angle)
			
			local ix,iy = panel:child("indicator_home"):center() --hudinteraction._hud_panel:center()
			ix = ix + (d_x/2)
			iy = iy + (d_y/2) - (hyp / 2)
			
			indicator_line:set_position(ix,iy)
			
			--[[
			--this is redundant now
			--it's inefficient anyway
			if not is_deploying then
				if is_interacting then
					indicator_dot:set_visible(indicator_dot_visible_on_interact)
					indicator_line:set_visible(indicator_line_visible_on_interact)
				elseif active_unit then 
					--interaction data is available
					indicator_dot:set_visible(indicator_dot_visible_on_mouseover)
					indicator_line:set_visible(indicator_line_visible_on_mouseover)
				else
					if indicator_dot:visible() then
						indicator_dot:hide()
					end
					if indicator_line:visible() then
						indicator_line:hide()
					end
				end
			end
			--]]
				
			indicator_dot:set_rotation(angle) --this shouldn't matter too much since the texture is a circle
			indicator_dot:set_world_center(to_x,to_y)
		end
	end
end

--given a unit being interacted with, returns the object associated with the interaction point
function InteractionIndicator:GetInteractObject(unit)
	if unit then
		local interaction_ext = unit:interaction() 
		if interaction_ext then 
			obj = interaction_ext._interact_obj
		end
		
		if not obj then 
			obj = unit:get_object(Idstring("Spine")) or unit:get_object(Idstring("Head"))
		end
		
		return obj
	end
end

--returns active aimed-at interaction unit or nil
function InteractionIndicator:GetInteractionActiveUnit()
	local player = managers.player:local_player()
	if alive(player) then
		local state = player:movement():current_state()
		local interaction_data = state._interaction
		local active_unit = interaction_data and interaction_data:active_unit()
		
		if active_unit and alive(active_unit) then
			return active_unit
		end
	end
	return nil
end

function InteractionIndicator:GenerateTimerFormat()
	local format_string = ""
	
	local timer_text = ""
	local timer_show_total = self.settings.timer_show_total
	local timer_accuracy = math.round(self.settings.timer_accuracy_places) - 1
	local timer_show_seconds_suffix = self.settings.timer_show_seconds_suffix --show "s" seconds suffix 
	local timer_seconds_suffix = self.settings.timer_seconds_suffix

		--lookup table to chars by setting index
		--store in cache for retrieval vs generation
		--rebuild on setting change
	
	local ca = "f"
	if timer_accuracy > 0 then 
		ca = "0." .. string.format("%if",timer_accuracy)
	else 
		ca = "i"
	end
	
	local cs = ""
	if timer_show_seconds_suffix then 
		cs = timer_seconds_suffix
	end
	
	if timer_show_total then 
		format_string = "%" .. ca .. cs .. "/%" .. ca .. cs
	else
		format_string = "%" .. ca .. cs
	end
	
	self._timer_format_string = format_string
end

function InteractionIndicator:GetTimerFormat()
	return self._timer_format_string
end

function InteractionIndicator:GetPalettes()
	local palettes = {}
	for i,col_str in ipairs(self.palettes) do 
		palettes[i] = Color(col_str)
	end
	return palettes
end

function InteractionIndicator:GetDefaultPalettes()
	local palettes = {}
	for i,col_str in ipairs(self.default_palettes) do 
		palettes[i] = Color(col_str)
	end
	return palettes
end

function InteractionIndicator:SetPalettes(palettes)
	for i,color in ipairs(palettes) do 
		self.palettes[i] = ColorPicker.color_to_hex(color)
	end
end

function InteractionIndicator:callback_colorpicker_done(setting,color,palettes,success)

	self:SetPalettes(palettes)
	
	if success then 
		self.settings[tostring(setting)] = tonumber("0x" .. ColorPicker.color_to_hex(color))
		
		self:CreateHUD()
		
		self:SaveSettings()
	end
end

function InteractionIndicator:ShowMissingColorpickerDialogue()
	QuickMenu:new(
		managers.localization:text("menu_interactionindicator_missing_colorpicker_title"),
		string.format(managers.localization:text("menu_interactionindicator_missing_colorpicker_desc"),self.url_colorpicker),
		{
			{
				text = "menu_interactionindicator_ok",
				is_cancel_button = true
			}
		},
		true
	)
end

function InteractionIndicator:SaveSettings()
	if self._lip then
		local palettes = {}
		for i,v in ipairs(self.palettes) do
			--one unfortunate limitation of LIP is that it has a very limited ability to infer data types from regular ol' strings
			--only the primitives Bool, Number (Float/Int), and String are supported within a given table
			--and LIP does not recognize hex numbers properly-
			--if the value start with a number character, it is interpreted as a regular decimal number
			--so saving the hex string 000088 would work fine, but the hex string "000088" would be loaded as the decimal number "88"
			--could also solve this by wrapping them in quotation marks or other punctuation like so:
--				palettes[i] = "\"" .. v .. "\""
--				self.palettes[i] = string.gsub(v,"%p","")
			--or saving the number in decimal form to preserve its value:
				--tonumber("0x" .. v)
			--it's not really a better solution, just a different one
			
			palettes[i] = "0x" .. v --tonumber("0x" .. v)
			
		end
		self._lip.save(self._save_path,{Config = self.settings,Palettes=palettes},self.settings_sort)
	end
end

function InteractionIndicator:LoadSettings()
	if self._lip then 
		if SystemFS:exists( Application:nice_path(self._save_path,true) ) then 
			local config_from_ini = self._lip.load(self._save_path)
			if config_from_ini then 
				if config_from_ini.Config then 
					local color_keys = { --don't look at me i'm hideous
						"text_color",
						"line_color",
						"dot_color"
					}
					for k,v in pairs(config_from_ini.Config) do
						if color_keys[k] then
							self.settings[k] = string.format("%06x",v)
						else
							self.settings[k] = v
						end
					end
					
					if config_from_ini.Config.timer_accuracy then 
						--convert old timer accuracy setting (float) to new setting (int index)
						
						local rounded_places = math.round(config_from_ini.Config.timer_accuracy)
						if rounded_places < 1 then
							--preserve setting as "don't show decimals"
							self.settings.timer_accuracy_places = 1
						else
							self.settings.timer_accuracy_places = math.clamp(rounded_places,1,2)
						end
						self.settings.timer_accuracy = nil
					end
				end
				if config_from_ini.Palettes then 
					for i,v in ipairs(config_from_ini.Palettes) do 
						self.palettes[i] = string.format("%06x",v)
					end
				end
				
			end
		else
			self:SaveSettings()
		end
	end
	self:GenerateTimerFormat()
end


Hooks:Add("LocalizationManagerPostInit", "interactionindicator_LocalizationManagerPostInit", function(loc)
	if not BeardLib then
		loc:load_localization_file(InteractionIndicator._default_localization_path)
	end
end)

Hooks:Add("MenuManagerInitialize", "interactionindicator_MenuManagerInitialize", function(menu_manager)
	
	InteractionIndicator:LoadSettings()

	if ColorPicker then
		InteractionIndicator._colorpicker = ColorPicker:new("interactionindicator_colorpicker",{
			color = Color.white, --placeholder data until a specific setting button is pressed
			palettes = InteractionIndicator:GetPalettes(),
			default_palettes = InteractionIndicator:GetDefaultPalettes(),
			changed_callback = nil,
			done_callback = nil
		})
	end
	
	MenuCallbackHandler.callback_interactionindicator_colorpicker_set_line_color = function(self)
		if InteractionIndicator._colorpicker then 
			InteractionIndicator._colorpicker:Show({
				color = Color(string.format("%06x",InteractionIndicator.settings.line_color)),
				palettes = InteractionIndicator:GetPalettes(),
				done_callback = callback(InteractionIndicator,InteractionIndicator,"callback_colorpicker_done","line_color")
			})
		else
			InteractionIndicator:ShowMissingColorpickerDialogue()
		end
	end
	
	MenuCallbackHandler.callback_interactionindicator_colorpicker_set_dot_color = function(self)
		if InteractionIndicator._colorpicker then 
			InteractionIndicator._colorpicker:Show({
				color = Color(string.format("%06x",InteractionIndicator.settings.dot_color)),
				palettes = InteractionIndicator:GetPalettes(),
				done_callback = callback(InteractionIndicator,InteractionIndicator,"callback_colorpicker_done","dot_color")
			})
		else
			InteractionIndicator:ShowMissingColorpickerDialogue()
		end
	end
	
	MenuCallbackHandler.callback_interactionindicator_colorpicker_set_text_color = function(self)
		if InteractionIndicator._colorpicker then 
			InteractionIndicator._colorpicker:Show({
				color = Color(string.format("%06x",InteractionIndicator.settings.text_color)),
				palettes = InteractionIndicator:GetPalettes(),
				done_callback = callback(InteractionIndicator,InteractionIndicator,"callback_colorpicker_done","text_color")
			})
		else
			InteractionIndicator:ShowMissingColorpickerDialogue()
		end
	end
	
	MenuCallbackHandler.callback_interactionindicator_hud_compatibility_mode = function(self,item)
		local value = item:value() == "on"
		InteractionIndicator.settings.hud_compatibility_mode = value
		InteractionIndicator:SaveSettings()
	end
	MenuCallbackHandler.callback_interactionindicator_indicator_line_visible_on_mouseover = function(self,item)
		local value = item:value() == "on"
		InteractionIndicator.settings.indicator_line_visible_on_mouseover = value
		InteractionIndicator:SaveSettings()
	end
	MenuCallbackHandler.callback_interactionindicator_indicator_line_visible_on_interact = function(self,item)
		local value = item:value() == "on"
		InteractionIndicator.settings.indicator_line_visible_on_interact = value
		InteractionIndicator:SaveSettings()
	end
	MenuCallbackHandler.callback_interactionindicator_line_w = function(self,item)
		local value = tonumber(item:value())
		InteractionIndicator.settings.line_w = value
		InteractionIndicator:SaveSettings()
	end
	MenuCallbackHandler.callback_interactionindicator_line_alpha = function(self,item)
		local value = tonumber(item:value())
		InteractionIndicator.settings.line_alpha = value
		InteractionIndicator:SaveSettings()
	end
	--[set line color button]
	
	MenuCallbackHandler.callback_interactionindicator_indicator_dot_visible_on_mouseover = function(self,item)
		local value = item:value() == "on"
		InteractionIndicator.settings.indicator_dot_visible_on_mouseover = value
		InteractionIndicator:SaveSettings()
	end
	MenuCallbackHandler.callback_interactionindicator_indicator_dot_visible_on_interact = function(self,item)
		local value = item:value() == "on"
		InteractionIndicator.settings.indicator_dot_visible_on_interact = value
		InteractionIndicator:SaveSettings()
	end
	MenuCallbackHandler.callback_interactionindicator_dot_radius = function(self,item)
		local value = tonumber(item:value())
		InteractionIndicator.settings.dot_radius = value
		InteractionIndicator:SaveSettings()
	end
	MenuCallbackHandler.callback_interactionindicator_dot_alpha = function(self,item)
		local value = tonumber(item:value())
		InteractionIndicator.settings.dot_alpha = value
		InteractionIndicator:SaveSettings()
	end
	--[set dot color button]
	
	MenuCallbackHandler.callback_interactionindicator_circle_enabled = function(self,item)
		local value = item:value() == "on"
		InteractionIndicator.settings.circle_enabled = value
		InteractionIndicator:SaveSettings()
	end
	MenuCallbackHandler.callback_interactionindicator_circle_alignment_mode = function(self,item)
		local value = tonumber(item:value())
		InteractionIndicator.settings.circle_alignment_mode = value
		InteractionIndicator:SaveSettings()
	end
	MenuCallbackHandler.callback_interactionindicator_circle_radius = function(self,item)
		local value = tonumber(item:value())
		InteractionIndicator.settings.circle_radius = value
		InteractionIndicator:SaveSettings()
	end
	MenuCallbackHandler.callback_interactionindicator_circle_screen_margin = function(self,item)
		local value = tonumber(item:value())
		InteractionIndicator.settings.circle_screen_margin = value
		InteractionIndicator:SaveSettings()
	end
	
	MenuCallbackHandler.callback_interactionindicator_text_enabled = function(self,item)
		local value = item:value() == "on"
		InteractionIndicator.settings.text_enabled = value
		InteractionIndicator:SaveSettings()
	end
	MenuCallbackHandler.callback_interactionindicator_text_font_size = function(self,item)
		local value = tonumber(item:value())
		InteractionIndicator.settings.text_font_size = value
		InteractionIndicator:SaveSettings()
	end
	MenuCallbackHandler.callback_interactionindicator_timer_accuracy = function(self,item)
		local value = tonumber(item:value())
		InteractionIndicator.settings.timer_accuracy_places = value
		InteractionIndicator:GenerateTimerFormat()
		InteractionIndicator:SaveSettings()
	end
	--[set text color button]
	MenuCallbackHandler.callback_interactionindicator_timer_show_total = function(self,item)
		local value = item:value() == "on"
		InteractionIndicator.settings.timer_show_total = value
		InteractionIndicator:GenerateTimerFormat()
		InteractionIndicator:SaveSettings()
	end
	MenuCallbackHandler.callback_interactionindicator_timer_show_seconds_suffix = function(self,item)
		local value = item:value() == "on"
		InteractionIndicator.settings.timer_show_seconds_suffix = value
		InteractionIndicator:GenerateTimerFormat()
		InteractionIndicator:SaveSettings()
	end
	
	MenuCallbackHandler.callback_interactionindicator_back = function(self,item)
		InteractionIndicator:CreateHUD()
	end
	
	MenuHelper:LoadFromJsonFile(InteractionIndicator._menu_path, InteractionIndicator, InteractionIndicator.settings)
end)
	
Hooks:Add("BaseNetworkSessionOnLoadComplete","interactionindicator_createhud",function()
	local ii = InteractionIndicator
	if ii.settings.hud_compatibility_mode then
		ii:CreateHUD()
		
		-- just does hook stuff so it's safe to do here
		if _G.MUIInteract then 
			local path = InteractionIndicator._mod_path .. "compatibility/mui.lua"
			local success,err = blt.vm.dofile(path)
			if err then
				InteractionIndicator:log("ERROR: Could not load [" .. path .. "]: " .. tostring(err)) 
			end
		end
		
	end
	
end)
