Hooks:PostHook(InteractionTweakData,"init","ii_interactiontweakdata_init",function(self,tweak_data)
	-- previously, these used the icon "equipment_bank_manager_key", which is a keycard icon.
	-- don't ask me why.
	
	self.trai_achievement_safe.icon = "equipment_sheriff_star"
	
	local replacement_icon = "equipment_key_chain"
	for _,id in pairs({
		"bex_safe_door",
		"cant_pick_lock",
		"chas_pick_lock_easy_no_skill",
		"chas_pickup_keychain_forklift",
		"fex_pick_lock_easy_no_skill",
		"lockpick_locker",
		"mex_red_door",
		"mex_red_room_key",
		"open_door_with_keys",
		"pex_give_car_key",
		"pex_pick_lock_easy_no_skill",
		"pex_red_room_key",
		"pick_lock_30",
		"pick_lock_deposit_transport",
		"pick_lock_easy",
		"pick_lock_easy_no_skill",
		"pick_lock_easy_no_skill_pent",
		"pick_lock_hard",
		"pick_lock_hard_no_skill",
		"pick_lock_hard_no_skill_deactivated",
		"pick_lock_x_axis",
		"trai_hold_picklock_toolsafe",
		"trai_press_reinforced_big_sliding_gate_open"
	}) do 
		self[id].icon = replacement_icon
	end
	
end)