Hooks:PostHook(CharacterTweakData, "init", "WeaponPickup_MagMultipliers", function(self)
    
    self.tank.weaponpickup_mags = 4
    self.spooc.weaponpickup_mags = 2
    self.taser.weaponpickup_mags = 2
    self.shield.weaponpickup_mags = 2
    
end)