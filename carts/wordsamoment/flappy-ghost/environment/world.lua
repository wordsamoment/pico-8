function createWorld()
	WORLD = {
		edge_left = 0,
		edge_right = 127,
		ceiling = 0,
		floor = 127
	}

	MOON = {
		shadow_radius = 20
	}
end

function drawMoon()
	fillp(0x95a6)
	circfill(117, 10, MOON.shadow_radius, COLORS.dark_blue)
	-- change moon color on level difficutly
	-- circfill(117, 10, MOON.shadow_radius - 1, COLORS.dark_blue)
	fillp()
	-- reset

	spr(64, 102, -6, 4, 4)
end

function drawMainScene()
	drawMoon()
end