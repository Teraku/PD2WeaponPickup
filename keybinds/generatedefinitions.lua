local definitions = {
    ["_credits"] = "Thanks to SC for finding out these specific weapons used by NPC's.",
    --Regular guard weapons
    ["c45_npc"] = {
        ["name_id"] = "g22c",
        ["blueprint"] = {
            "wpn_fps_pis_g22c_b_standard",
            "wpn_fps_pis_g22c_body_standard",
            "wpn_fps_pis_g18c_m_mag_17rnd"            
        }
    },
    --Murkywater guard and GenSec Elite weapons.
    ["ump_npc"] = {
        ["name_id"] = "new_mp5",
        ["blueprint"] = {
            "wpn_fps_smg_mp5_body_mp5",
            "wpn_fps_smg_mp5_fg_mp5a4",
            "wpn_fps_smg_mp5_s_solid",
            "wpn_fps_smg_mp5_m_straight",
            "wpn_fps_upg_o_t1micro"
        }
    },
    --Mendoza Gangster weapons
    ["mac11_npc"] = {
        ["name_id"] = "mac10",
        ["blueprint"] = {
            "wpn_fps_smg_mac10_body_mac10",
            "wpn_fps_smg_mac10_b_dummy",
            "wpn_fps_smg_mac10_s_fold",
            "wpn_fps_smg_mac10_m_extended" 
        }
    },
    --MP5 used by guards and certain light units 
    ["mp5_npc"] = {
        ["name_id"] = "new_mp5",
        ["blueprint"] = {
            "wpn_fps_smg_mp5_body_mp5",
            "wpn_fps_smg_mp5_m_std",
            "wpn_fps_smg_mp5_fg_mp5a5",
            "wpn_fps_smg_mp5_s_adjust"
        }
    },
    --Bronco used by those glass cannon first responder fuckers.
    ["raging_bull_npc"] = {
        ["name_id"] = "new_raging_bull",
        ["blueprint"] = {
            "wpn_fps_pis_rage_body_standard",
            "wpn_fps_pis_rage_g_standard",
            "wpn_fps_pis_rage_b_long"
        }
    },
    --Remington 870 used by the SWAT shotgunners.
    ["r870_npc"] = {
        ["name_id"] = "r870",
        ["blueprint"] = {
            "wpn_fps_shot_r870_body_standard",
            "wpn_fps_shot_r870_b_long",
            "wpn_fps_shot_r870_fg_big",
            "wpn_fps_shot_r870_s_solid_vanilla",
            "wpn_fps_upg_m4_g_standard"
        }
    },
    --Standard M4 used by lots of standard enemies, especially on Very Hard/Overkill.
    ["m4_npc"] = {
        ["name_id"] = "new_m4",
        ["blueprint"] = {
            "wpn_fps_upg_m4_g_standard_vanilla",
            "wpn_fps_m4_lower_reciever",
            "wpn_fps_m4_uupg_fg_rail", 
            "wpn_fps_m4_uupg_m_std_vanilla",    
            "wpn_fps_upg_m4_s_standard_vanilla",
            "wpn_fps_m4_uupg_draghandle",       
            "wpn_fps_m4_uupg_b_short",          
            "wpn_fps_upg_o_eotech",             
            "wpn_fps_m4_upper_reciever_edge"
        }
    },
    --G36 used by GenSec Elites.
    ["g36_npc"] = {
        ["name_id"] = "g36",
        ["blueprint"] = {
            "wpn_fps_ass_g36_s_standard",
            "wpn_fps_ass_g36_m_standard",
            "wpn_fps_ass_g36_b_long",
            "wpn_fps_ass_g36_fg_k",
            "wpn_fps_upg_o_eotech"
        }
    },
    --MP9 used by all kinds of shields.
    ["mp9_npc"] = {
        ["name_id"] = "mp9",
        ["blueprint"] = {
            "wpn_fps_smg_mp9_body_mp9",
            "wpn_fps_smg_mp9_s_fold",
            "wpn_fps_smg_mp9_b_dummy",
            "wpn_fps_smg_mp9_m_extended"
        }
    }
}


local path = "mods/WeaponPickup/"
local file = io.open(path .. "copweapondefinitions.json", "w+")
if file then
    file:write(json.encode(definitions))
    file:close()
end