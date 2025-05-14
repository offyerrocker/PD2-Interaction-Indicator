Hooks:PostHook(InteractionTweakData,"init","ii_interactiontweakdata_init",function(self,tweak_data)
	-- previously, these used the icon "equipment_bank_manager_key", which is a keycard icon.
	-- don't ask me why.
	
	self.pick_lock_easy_no_skill.icon = "equipment_key_chain"
	self.pex_pick_lock_easy_no_skill.icon = "equipment_key_chain"
	self.fex_pick_lock_easy_no_skill.icon = "equipment_key_chain"
	self.chas_pick_lock_easy_no_skill.icon = "equipment_key_chain"
	self.pick_lock_easy_no_skill_pent.icon = "equipment_key_chain"
end)