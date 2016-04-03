Hooks:PostHook(PlayerManager, "update", "WeaponPickup_checkpickupavailable", function(self)
    
    if not managers.hud then return end
    
    local player_unit = self:player_unit()
    
    if not player_unit then return end
    
    local corpses = managers.enemy._enemy_data.corpses
    local my_pos = player_unit:movement():m_pos()

    local corpses_nearby = false

    for i, v in pairs(corpses) do
        
        if not v.unit:unit_data().wp_picked_up then
        
            --Distance in arbitrary distance units (One distance unit is supposed to approximate a centimeter, but that's a dirty lie)
            local max_dis = 150
            local max_dis_sq = max_dis * max_dis
            local corpse_pos = v.unit:movement():m_pos()            
            local dis_sq = mvector3.distance_sq(corpse_pos, my_pos)
            
            if dis_sq < max_dis_sq then
                corpses_nearby = true
                break
            end
        
        end
    end
    
    managers.hud:set_wp_panel_visible(corpses_nearby)
    
end)