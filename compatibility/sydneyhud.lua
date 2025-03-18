Hooks:PostHook(HUDManager,"hide_interaction_bar","ii_sydneyhud_compat_hideinteract",function(self)
	if self._hud_interaction._interact_circle then
        self._hud_interaction._interact_circle._panel:stop()
	end
end)

-- overwrite custom function SydneyHUD for compatibility with II (specifically to hide the II interaction dot when charging melees)
-- currently, this function is only used for custom non-interaction timers (eg. melee/reload timers);
-- if that changes, i'll need a different approach (likely overwriting the PlayerStandard functions responsible)
Hooks:PostHook(HUDManager,"animate_interaction_bar","ii_sydneyhud_compat_hideinteract",function(self, current, total, hide)
	InteractionIndicator._panel:child("indicator_dot"):hide()
	InteractionIndicator._panel:child("indicator_line"):hide()
end)