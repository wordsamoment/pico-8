---- INIT -----------------------

function createWall()
	if #WALLS < GAME.max_walls then
		local gap_position = (flr(rnd(11)) * 8) + 8
		local bricks = { 0, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120, 128 }
		for i = 0, 3 do
			del(bricks, gap_position + (i * 8))
		end
		local wall = {
			x = 128,
			width = GAME.sprite_size,
			gap_position = gap_position,
			bricks = bricks,
			-- Shared x and width for top and bottom wall
			top_part = { y = WORLD.ceiling, height = gap_position },
			bottom_part = { y = gap_position + GAME.wall_gap, height = WORLD.floor }
		}
		add(WALLS, wall)
	end
end

---- CALCULATIONS -----------------------
function moveWall()
	for wall in all(WALLS) do
		wall.x -= GAME.speed
	end
end

function respawnWall()
	if WALLS[1].x + WALLS[1].width <= 0 then
		del(WALLS, WALLS[1])
		createWall()
	end
	if WALLS[1].x + WALLS[1].width <= 64 then
		createWall()
	end
end

function wallCalculateBehavior()
	moveWall()
	respawnWall()
end

---- DRAWING -----------------------
function wallDraw()
	palt(0, false)
	for wall in all(WALLS) do
		for brick in all(wall.bricks) do
			spr(17, flr(wall.x + 0.5), brick)
		end
		-- Debug wall draw
		-- rectfill(flr(wall.x + 0.5), wall.top_part.y, flr(wall.x + 0.5) + wall.width, wall.top_part.y + wall.top_part.height, COLORS.dark_green)
		-- rectfill(flr(wall.x + 0.5), wall.bottom_part.y, flr(wall.x + 0.5) + wall.width, wall.bottom_part.y + wall.bottom_part.height, COLORS.dark_green)
	end
	palt(0, true)
end