---- INIT -----------------------
function createWall()
	if #WALLS < GAME.max_walls then
		local height = (flr(rnd(11)) * 8) + 8
		local gap_position = (flr(rnd(11)) * 8) + 8
		local wall = {
			x = 128,
			width = 5,
			gaps = { gap_position, gap_position + 8, gap_position + 16, gap_position + 24 },
			-- Shared x and width for top and bottom wall
			top_part = { y = WORLD.ceiling, height = height },
			bottom_part = { y = height + GAME.wall_gap, height = WORLD.floor }
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
		-- spr(17, flr(wall.x + 0.5), brick)
		-- rectfill(flr(wall.x + 0.5), wall.top_part.y, flr(wall.x + 0.5) + wall.width, wall.top_part.y + wall.top_part.height, COLORS.dark_green)
		-- rectfill(flr(wall.x + 0.5), wall.bottom_part.y, flr(wall.x + 0.5) + wall.width, wall.bottom_part.y + wall.bottom_part.height, COLORS.dark_green)
	end

	palt(0, true)
end