local playerinventory_send_equipped_orig = PlayerInventory._send_equipped_weapon
function PlayerInventory:_send_equipped_weapon()
    
    if not Utils:IsInHeist() then
        return playerinventory_send_equipped_orig(self)
    end
    
    local index, blueprint_string, cosmetics_string = self:get_spoofed_weapon()
    if not index then
        index, blueprint_string, cosmetics_string = self:get_wp_weapon_sync_data()
        if Utils:IsCurrentWeaponPrimary() then
            self:set_spoofed_weapon(true, index, blueprint_string, cosmetics_string)
        else
            self:set_spoofed_weapon(false, index, blueprint_string, cosmetics_string)
        end
    end
    
    self._unit:network():send("set_equipped_weapon", index, blueprint_string, cosmetics_string)
end

function PlayerInventory:set_spoofed_weapon(is_primary, index, blueprint_string, cosmetics_string)
    if is_primary then
        self._spoofed_primary_index = index
        self._spoofed_primary_blueprint_string = blueprint_string
        self._spoofed_primary_cosmetics_string = cosmetics_string
    else
        self._spoofed_secondary_index = index
        self._spoofed_secondary_blueprint_string = blueprint_string
        self._spoofed_secondary_cosmetics_string = cosmetics_string        
    end
end

--At least Utils has a valid use case now, I guess?
function PlayerInventory:get_spoofed_weapon()
    if Utils:IsCurrentWeaponPrimary() then
        return self._spoofed_primary_index, self._spoofed_primary_blueprint_string, self._spoofed_primary_cosmetics_string
    else
        return self._spoofed_secondary_index, self._spoofed_secondary_blueprint_string, self._spoofed_secondary_cosmetics_string
    end
end

--Copied from send_equipped_weapon
function PlayerInventory:get_wp_weapon_sync_data()
	local eq_weap_name = self:equipped_unit():base()._factory_id or self:equipped_unit():name()
	local index = self._get_weapon_sync_index(eq_weap_name)
	if not index then
		debug_pause("[PlayerInventory:_send_equipped_weapon] cannot sync weapon", eq_weap_name, self._unit)
		return
	end
	local blueprint_string = self:equipped_unit():base().blueprint_to_string and self:equipped_unit():base():blueprint_to_string() or ""
	local cosmetics_string = ""
	local cosmetics_id = self:equipped_unit():base().get_cosmetics_id and self:equipped_unit():base():get_cosmetics_id() or nil
	if cosmetics_id then
		local cosmetics_quality = self:equipped_unit():base().get_cosmetics_quality and self:equipped_unit():base():get_cosmetics_quality() or nil
		local cosmetics_bonus = self:equipped_unit():base().get_cosmetics_bonus and self:equipped_unit():base():get_cosmetics_bonus() or nil
		local entry = tostring(cosmetics_id)
		local quality = tostring(tweak_data.economy:get_index_from_entry("qualities", cosmetics_quality) or 1)
		local bonus = cosmetics_bonus and "1" or "0"
		cosmetics_string = entry .. "-" .. quality .. "-" .. bonus
	else
		cosmetics_string = "nil-1-0"
	end
	return index, blueprint_string, cosmetics_string   
end