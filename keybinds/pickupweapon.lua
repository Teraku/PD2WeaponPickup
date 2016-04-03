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
        cop_weapon = v.unit:inventory()._wp_weapon
        if not cop_weapon then
            log("[WEAPONPICKUP_FATAL]Cop weapon could not be retrieved!")
            break
        end
    end
    local cop_weapon_name_id = cop_weapon:base():get_name_id()
    
    local dis_sq = mvector3.distance_sq(corpse_pos, my_pos)
    
    if dis_sq < max_dis_sq then
        corpses_nearby = true
        --Match cop's weapon against definition table
        if WeaponPickup.WeaponDefinitions[cop_weapon_name_id] then
            
            --Get the translated weapon from the definitions table.
            local definition = WeaponPickup.WeaponDefinitions[cop_weapon_name_id]
            
            --Get the amount of magazines that should be given to the player.
            local cop_tweak_data = v.unit:base():char_tweak()
            local mags = 1
            if cop_tweak_data.weaponpickup_mags then
                mags = cop_tweak_data.weaponpickup_mags
            end
            
            --Set weapon's ammo to 1 mag (or more if special), and disable ammo pickup.
            tweak_data.weapon[definition.name_id].AMMO_PICKUP = {0,0}
            tweak_data.weapon[definition.name_id].AMMO_MAX = tweak_data.weapon[definition.name_id].CLIP_AMMO_MAX * mags
            
            --Remember the player's current selection.
            local old_selection = player_unit:inventory():equipped_selection()
            --log("Player's old selection is "..old_selection)
            
            --The wanted selection should be the *opposite* weapon slot that the swap weapon is for.
            local selection_wanted = tweak_data.weapon[definition.name_id].use_data.selection_index == 1 and 2 or 1
            --log("Wanted selection is "..selection_wanted)
            
            --Swap player's weapon.
            player_unit:camera():play_redirect(player_unit:movement():current_state().IDS_UNEQUIP)
            player_unit:inventory():equip_selection(selection_wanted, true)
            
            --Give weapon to player.
            InGame_WeaponSwap:set_weapon(definition.name_id, definition.blueprint)
            player_unit:camera():play_redirect(player_unit:movement():current_state().IDS_EQUIP)
            
            --Swap player weapon back again after one second, to prevent errors.
            DelayedCalls:Add("WeaponPickup_swap", 1, function()
                player_unit:inventory():equip_selection(old_selection, true)
                player_unit:camera():play_redirect(player_unit:movement():current_state().IDS_EQUIP)
            end)
            --player_unit:inventory():equip_selection(old_selection)
            
            --Set this weapon's ammo pickup to 0.
            --[[
            local weapon = player_unit:inventory():equipped_unit():base()
            local weapon_id = weapon:get_name_id()
            tweak_data.weapon[weapon_id].AMMO_PICKUP = {0,0}
            
            --Set this weapon's ammo to 1 magazine.
            weapon:set_ammo_max(weapon:get_ammo_max_per_clip())
            weapon:set_ammo_total(weapon:get_ammo_max_per_clip())
            ]]
            
            --Selection index of secondary weapon is 1, primary weapon is 2.
            
            break
        else
            log("[WEAPONPICKUP_WARN]Weapon definition '"..cop_weapon_name_id.."' did not match anything! Notify Rokk.")
        end
    end
end