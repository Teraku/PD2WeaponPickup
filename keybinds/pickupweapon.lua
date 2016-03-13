path = "mods/WeaponPickup/"
dofile(path .. "lib/swaplib.lua")

--First-time init
if not _G.WeaponPickup then
    _G.WeaponPickup = {}
    WeaponPickup.ModPath = path
    WeaponPickup.Hooks = {
        
    }
    WeaponPickup.WeaponDefinitions = {}
    
    --Load weapon definitions, to find corresponding player weapons+blueprints for each cop weapon.
    local file = io.open(WeaponPickup.ModPath .. "copweapondefinitions.json", "r")
	if file then
		WeaponPickup.WeaponDefinitions = json.decode(file:read("*all"))
		file:close()
	end
end

--[[
--For testing purposes, load a standard Glock 22C.
local blueprint = {
    "wpn_fps_pis_g22c_b_standard",
    "wpn_fps_pis_g22c_body_standard",
    "wpn_fps_pis_g18c_m_mag_17rnd"
}
InGame_WeaponSwap:set_weapon("g22c", blueprint)
]]


local player_unit = managers.player:player_unit()
local corpses = managers.enemy._enemy_data.corpses
local my_pos = player_unit:movement():m_pos()

local corpses_nearby = false

for i, v in pairs(corpses) do   
    
    --Distance in arbitrary distance units (One distance unit is supposed to approximate a centimeter, but that's a dirty lie)
    local max_dis = 150
    local max_dis_sq = max_dis * max_dis
    local corpse_pos = v.unit:movement():m_pos()
    --local cop_tweak = v.unit:base():char_tweak()
    local cop_weapon = v.unit:inventory():get_weapon()
    if not cop_weapon then
        cop_weapon = v.unit:unit_data()._wp_weapon
    end
    local cop_weapon_name_id = cop_weapon:base():get_name_id()
    
    local dis_sq = mvector3.distance_sq(corpse_pos, my_pos)
    
    if dis_sq < max_dis_sq then
        corpses_nearby = true
        log("[weaponpickup_notice]Enemy corpse is nearby!")
        --Match cop's weapon against definition table
        if WeaponPickup.WeaponDefinitions[cop_weapon_name_id] then
            local definition = WeaponPickup.WeaponDefinitions[cop_weapon_name_id]
            InGame_WeaponSwap:set_weapon(definition.name_id, definition.blueprint)
            player_unit:camera():play_redirect(player_unit:movement():current_state().IDS_EQUIP)
            break
        else
            log("[WEAPONPICKUP_WARN]Weapon definition '"..cop_weapon_name_id.."' did not match anything!")
        end
    end
end

if not corpses_nearby then
    log("[weaponpickup_notice]No enemy corpse nearby.")
end