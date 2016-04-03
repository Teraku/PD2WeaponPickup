function HUDManager:set_wp_panel_visible(visibility)
    
    visibility = visibility or true
    
    self._hud_objectives.wp_panel:set_visible(visibility)
end