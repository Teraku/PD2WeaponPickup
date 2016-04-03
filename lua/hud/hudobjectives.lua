CloneClass(HUDObjectives)
Hooks:PostHook(HUDObjectives, "init", "ObjectivesWeaponPickup", function(self, hud)

	self._full_hud_panel = managers.hud._fullscreen_workspace:panel():gui(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2, {})

    --[[
	self.Combo_panel = self._full_hud_panel:panel( {
		visible = true, 
		name = "Combo_panel",
		x = 0,
		y = 0,
		h = 256, 
		w = 512,
		valign = "top", 
		blend_mode = "normal"
	})
	local Combo_bg = self.Combo_panel:bitmap( {
		name = "Combo_bg",
		visible = true, 
		layer = 0, 
		texture = "guis/textures/hud_icons",
		x = 8, 
		w = 200,
		h = 64,
		vertical = "top"
	})
    ]]
    
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
		vertical = "top",
	})
    
    self.wp_panel:set_top(self._bg_box:bottom())
	wp_bg:set_left(self._full_hud_panel:left())
	wp_bg:set_top(self._bg_box:bottom() + 10)	
	--wp_bg:set_left(self._full_hud_panel:left())
    
    self.wp_panel:set_left(self._full_hud_panel:right() - wp_bg:w())
end)

--[[
function HUDObjectives:set_combo(combo)
	--self.Combo_panel = self._hud_panel:child("Combo_panel")
	local Combo_text = self.Combo_panel:child("Combo_text")
	local Combo_text_bg = self.Combo_panel:child("Combo_text_bg")
	local Combo_bg = self.Combo_panel:child("Combo_bg")
	if combo > 1 then 
		self.Combo_panel:set_visible(true)  
	else
		Combo_text:animate(callback(self, self, "close_anim"))
		Combo_text_bg:animate(callback(self, self, "close_anim"))
	end
	if combo .. "x" ~= Combo_text:text() and combo ~= 0 then
		Combo_text:set_text(combo.."x")
		Combo_text_bg:set_text(combo.."x")
	if combo == 2 then
		Combo_text:animate(callback(self, self, "open_anim"))
	    Combo_text_bg:animate(callback(self, self, "open_anim"))	
	 -- Combo_text:animate(callback(self, self, "flash_text"), {forever = true})
	end
	if combo > 9 then
        Combo_bg:set_w(240)
	end	
	if combo > 99 then 
        Combo_bg:set_w(310)
	end
	end
end

function HUDObjectives:flash_text(text, config)
	local forever = config and config.forever or false
	local TOTAL_T = 2
	local t = TOTAL_T
	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
		local cv = math.abs((math.sin(t * 180 * 1)))
		text:set_color(Color.red * cv + Color(226/255, 8/255, 124/255) * cv)
	end
--	bg:set_color(Color(1, 0, 0, 0))
end
function HUDObjectives:open_anim( panel )
    local speed = 50
	panel:set_visible( false )
	panel:set_x( - 150 )
	panel:set_visible( true )
	local TOTAL_T = 10/speed
	local t = TOTAL_T
	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
		panel:set_x((1 - t/TOTAL_T) * 60 )
	end
end
function HUDObjectives:close_anim( panel )
	local speed = 50
	local cw = panel:x()
	local TOTAL_T = cw/speed
	local t = TOTAL_T
	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
		panel:set_x((1 - t/TOTAL_T) * -80 )
	end
	
	self.Combo_panel:set_visible(false)  
end

function HUDObjectives:KillUpdate(kill_streak)
	local font_size = 72
	local function end_shake(o)
		local TOTAL_T = 0.4
		local t = TOTAL_T
		while t < 1 do
			local dt = coroutine.yield() * 3
			t = t + dt
			--local alpha = math.round(math.abs((math.sin(t * 360 * 3))))
			o:set_font_size(font_size / t)
			--wait(0.0001)
		end
		o:set_font_size(font_size)
	end
	
	local function start_shake(o)
		local TOTAL_T = 1
		local t = TOTAL_T
		while t > 0.4 do
			local dt = coroutine.yield() * 3
			t = t - dt
			--local alpha = math.round(math.abs((math.sin(t * 360 * 3))))
			o:set_font_size(font_size / t)
			--wait(0.0001)
		end
		--o:set_font_size(font_size)
		o:animate(end_shake)
	end
	
	kill_streak:animate(start_shake)
end
]]