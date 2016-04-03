Hooks:PostHook(HUDObjectives, "init", "ObjectivesWeaponPickup", function(self, hud)

	self._full_hud_panel = managers.hud._fullscreen_workspace:panel():gui(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2, {})
    
	self.wp_panel = self._full_hud_panel:panel( {
		visible = false, 
		name = "wp_panel",
		x = 0,
		y = 0,
		h = 155, 
		w = 170,
		valign = "top",
		blend_mode = "normal"
	})
	local wp_bg = self.wp_panel:bitmap( {
		name = "wp_bg",
		visible = true, 
		layer = 0, 
		texture = "guis/textures/hud_icons",
        texture_rect = {
            0,
            192,
            45,
            50
        },
        w = 30,
        h = 39,
		vertical = "top",
	})
    
    self.wp_panel:set_top(self._full_hud_panel:bottom() / 1.35)
	wp_bg:set_left(self._full_hud_panel:left())
	wp_bg:set_top(self._bg_box:bottom() + 10)	
	--wp_bg:set_left(self._full_hud_panel:left())
    
    self.wp_panel:set_left(self._full_hud_panel:right() - wp_bg:w() - 50)
end)