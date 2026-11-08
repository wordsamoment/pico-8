---- CALCULATIONS -----------------------
function moonCreate()
	TIMER.moon_inner_shadow = MOON.inner_shadow.duration
	TIMER.moon_outer_shadow = MOON.outer_shadow.duration
	TIMER.moon_crater = MOON.crater.duration
end

function shadowMoonUpdate()
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

function craterMoonUpdate()
	if TIMER.moon_crater == 0 then
		local craterX = flr(rnd(18) + 6)
		local craterY = flr(rnd(20) + 39)
		-- f(x) = 13 - x // f(7) = 13 - 7 = 6 (Grey) //  f(6) = 13 - 6 = 7 (White) in current color selection. (utilities.lua COLORS)
		sset(craterX, craterY, 13 - sget(craterX, craterY))

		TIMER.moon_crater = MOON.crater.duration
	end
end

function environmentUpdate()
	shadowMoonUpdate()
	craterMoonUpdate()
end
---- DRAWING -----------------------
function moonDraw()
	if TIMER.moon_inner_shadow == 0 then
		TIMER.moon_inner_shadow = MOON.inner_shadow.duration
	end

	if TIMER.moon_outer_shadow == 0 then
		TIMER.moon_outer_shadow = MOON.outer_shadow.duration
	end

	fillp(0x95a6)
	circfill(MOON.outer_shadow.center_x, MOON.outer_shadow.center_y, MOON.outer_shadow.radius, COLORS.midnight)
	fillp(0xa5a5)
	circ(MOON.inner_shadow.center_x, MOON.inner_shadow.center_y, MOON.inner_shadow.radius, COLORS.black)
	-- change moon color on level difficutly
	-- circfill(117, 10, MOON.shadow_radius - 1, COLORS.midnight)
	fillp()
	-- reset

	-- Moon Sprite
	spr(64, 102, -6, 4, 4)
	pset(MOON.crater.x, MOON.crater.y, MOON.crater.color)
	-- rect(109, 1, 126, 21, COLORS.green)
end

function mainSceneDraw()
	moonDraw()
end