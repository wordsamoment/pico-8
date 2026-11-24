function globalVariablesCreate()
	MODE = {
		main_menu = false,
		main_menu_to_gameplay = false,
		gameplay = false,
		game_over = false
	}

	DURATION = {
		main_menu_transition = 2,
		ghost_invisible = 3,
		ghost_invisible_cooldown = 6
	}

	MAIN_MENU = {
		name_position = { x = 10, y = 30, x_end = -60 },
		current_option = 1,
		options = {
			{ label = "nEW GAME", select_arrow_y = 48 },
			{ label = "hIGH SCORES", select_arrow_y = 60 },
			{ label = "qUIT", select_arrow_y = 72 }
		},
		transition = 1
	}

	GAME = {
		speed = 1,
		wall_gap = 32,
		max_walls = 2,
		over = false,
		sprite_size = 7
	}

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

	WALLS = {}

	GHOST = {
		x = 64,
		y = 50,
		x_main_menu = 90,
		size = 8,
		vertical_speed = 0,
		jump_speed = GAME.speed * 90,
		current_sprite = 0,
		next_sprite_set_step = 2,
		sprite_choice = 0,
		jumping = false,
		invisible = false
	}

	GHOST_PARTICLES = {}

	GHOST_SKILL = { icon_y_offset = 0, circle_cooldown = { center_x = 10, center_y = 117, radius = 8, color = COLORS.white, points = {} } }

	SCORE = { count = 0 }

	for name, time in pairs(TIMER) do
		TIMER[name] = 0
	end
end

function gameInit()
	globalVariablesCreate()
	setActiveMode("main_menu")
	generateWall()
end

function isGameOver()
	-- Ghost touched the floor
	if ghostIsTouchingFloor() then
		ghostDeath()
		sfx(-2)
		return true
	end

	-- Ghost hit a wall
	for wall in all(WALLS) do
		if ghostIsWallColliding(wall) then
			ghostDeath()
			sfx(-2)
			return true
		end
	end

	-- Ghost still alive
	return false
end