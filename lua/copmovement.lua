--Remember this cop's weapon to retrieve later.
--If not playing solo, a cop's weapon is forgotten once he dies.
Hooks:PostHook(CopMovement, "_post_init", "WeaponPickup_CopMovementPostInit", function(self)

    local unit = self._unit
    unit:inventory()._wp_weapon = self._ext_inventory:get_weapon()

end)