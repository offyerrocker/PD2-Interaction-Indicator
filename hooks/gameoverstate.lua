local hooked_class,hook_id
local required_script = string.lower(RequiredScript)
if required_script == "lib/states/victorystate" then 
	hooked_class = VictoryState
	hook_id = "interactionindicator_onvictorystate"
elseif required_script == "lib/states/gameoverstate" then 
	hooked_class = GameOverState
	hook_id = "interactionindicator_ongameoverstate"
end

if hooked_class then
	Hooks:PostHook(hooked_class,"at_enter",hook_id,function(self)
		if managers.hud then
			managers.hud:remove_updator("interactionindicator_update")
		end
		if InteractionIndicator and alive(InteractionIndicator._panel) then
			InteractionIndicator._panel:hide()
		end
	end)
end