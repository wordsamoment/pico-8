function createWorld()
	WORLD = {
		edge_left = 0,
		edge_right = 127,
		ceiling = 0,
		floor = 127
	}

	MOON = {
		outer_shadow = { center_x = 117, center_y = 10, radius = 16, start_radius = 16, end_radius = 22, duration = 8, elapsed_time = 0 },
		inner_shadow = { center_x = 117, center_y = 10, radius = 15, start_radius = 18, end_radius = 20, duration = 9, elapsed_time = 0 },
		crater = { duration = 2 }
	}
	TIMER.moon_inner_shadow = MOON.inner_shadow.duration
	TIMER.moon_outer_shadow = MOON.outer_shadow.duration
	TIMER.moon_crater = MOON.crater.duration
end

function updateShadowMoon()
	-- Outer shadow
	MOON.outer_shadow.elapsed_time = TIMER.moon_outer_shadow / (MOON.outer_shadow.duration / 3) % 3
	if flr(MOON.outer_shadow.elapsed_time) < 1 then
		-- f(x) = A + (B - A)*x
		MOON.outer_shadow.radius = MOON.outer_shadow.start_radius + (MOON.outer_shadow.end_radius - MOON.outer_shadow.start_radius) * MOON.outer_shadow.elapsed_time
	elseif flr(MOON.outer_shadow.elapsed_time) >= 1 and flr(MOON.outer_shadow.elapsed_time) <= 2 then
		MOON.outer_shadow.radius = MOON.outer_shadow.end_radius + (MOON.outer_shadow.start_radius - MOON.outer_shadow.end_radius) * (MOON.outer_shadow.elapsed_time - 1)
	end

	-- Inner shadow
	MOON.inner_shadow.elapsed_time = TIMER.moon_inner_shadow / (MOON.inner_shadow.duration / 3) % 3
	if flr(MOON.inner_shadow.elapsed_time) < 1 and flr(MOON.inner_shadow.elapsed_time) <= 2 then
		-- f(x) = A + (B - A)*x
		MOON.inner_shadow.radius = MOON.inner_shadow.start_radius + (MOON.inner_shadow.end_radius - MOON.inner_shadow.start_radius) * MOON.inner_shadow.elapsed_time
	elseif flr(MOON.inner_shadow.elapsed_time) >= 1 then
		MOON.inner_shadow.radius = MOON.inner_shadow.end_radius + (MOON.inner_shadow.start_radius - MOON.inner_shadow.end_radius) * (MOON.inner_shadow.elapsed_time - 1)
	end
end

function updateCraterMoon()
	if TIMER.moon_crater == 0 then
		local craterX = flr(rnd(18) + 6)
		local craterY = flr(rnd(20) + 39)
		-- f(x) = 13 - x // f(7) = 13 - 7 = 6 (Grey) //  f(6) = 13 - 6 = 7 (White) in current color selection. (utilities.lua COLORS)
		sset(craterX, craterY, 13 - sget(craterX, craterY))
		TIMER.moon_crater = MOON.crater.duration
	end
end

function updateEnvironment()
	updateShadowMoon()
	updateCraterMoon()
end

function drawMoon()
	if TIMER.moon_inner_shadow == 0 then
		TIMER.moon_inner_shadow = MOON.inner_shadow.duration
	end

	if TIMER.moon_outer_shadow == 0 then
		TIMER.moon_outer_shadow = MOON.outer_shadow.duration
	end

	fillp(0x95a6)
	circfill(MOON.outer_shadow.center_x, MOON.outer_shadow.center_y, MOON.outer_shadow.radius, COLORS.dark_blue)
	fillp(0xa5a5)
	circ(MOON.inner_shadow.center_x, MOON.inner_shadow.center_y, MOON.inner_shadow.radius, COLORS.black)
	-- change moon color on level difficutly
	-- circfill(117, 10, MOON.shadow_radius - 1, COLORS.dark_blue)
	fillp()
	-- reset

	-- Moon Sprite
	spr(64, 102, -6, 4, 4)
	pset(MOON.crater.x, MOON.crater.y, MOON.crater.color)
	-- rect(109, 1, 126, 21, COLORS.neon_green)
end

function drawMainScene()
	drawMoon()
end