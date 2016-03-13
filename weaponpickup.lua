--First-time init
if not _G.WeaponPickup then
    _G.WeaponPickup = {}
    WeaponPickup.ModPath = ModPath
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

--Execute script
if RequiredScript then
	local script = RequiredScript:lower()
	if WeaponPickup.Hooks[script] then
		dofile(WeaponPickup.ModPath .. WeaponPickup.Hooks[script])
	end
end