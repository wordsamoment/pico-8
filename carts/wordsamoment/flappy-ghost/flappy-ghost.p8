pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
-- UTILITIES -----------------------
PRINT = {
	inCenter = function(text, height, color)
		local glyphsize = 4
		print(text, 64 - ((#text * glyphsize) / 2), height - (glyphsize / 2), color)
		-- one letter = 4 px len
	end
}

-- SETUP -----------------------
COLORS = { BLACK = 0, DARKBLUE = 1, MAGENTA = 2, DARKGREEN = 3, BROWN = 4, DARKGREY = 5, GREY = 6, WHITE = 7, RED = 8, ORANGE = 9, YELLOW = 10, NEONGREEN = 11, LIGHTBLUE = 12, LAVENDER = 13, PINK = 14, PEACH = 15 }

DELTATIME = nil -- global delta time
TIMER = setmetatable({}, { __index = function() return 0 end }) -- Clever countdown timer helper - https://lynn.github.io/blog/pico-timers/

GAME_OVER = false
WORLD = { ceiling = 0, floor = 127 }
GHOST = { x = 64, y = 50, size = 8, currentSprite = 0, lastJumpTime = 0, verticalSpeed = 0, jumpSpeed = 80, activeSpriteSheet = 0 }
WALL_ABOVE = { x = 100, y = WORLD.ceiling, w = 5, h = 52 }
WALL_BOTTOM = { x = 100, y = WORLD.floor - 52, w = 5, h = 52 }

-- FUNCTIONS -----------------------
---- SETUP CALCULATIONS -----------------------
function calculateDeltaTime()
	if (DELTATIME == nil) then
		DELTATIME = 1 / stat(8)
		-- stat(8) = Target FPS in PICO8
	end
end

function calculateTimers()
	for name, time in pairs(TIMER) do
		TIMER[name] = max(0, time - DELTATIME)
		-- minus DELTATIME let's you write seconds as 1 not as 60
		-- added "- DELTATIME" compared to lynn's to achieve this.
	end
end

---- GHOST CALCULATIONS -----------------------
function ghostCalculateBehavior()
	ghostJump()
	ghostFalling()
	ghostWorldBoundaryCollision()
end

-- https://nerdyteachers.com/PICO-8/Collision/101
function ghostWorldBoundaryCollision()
	-- middle number between ceiling, ghost's y and floor (minus the ghost's srite height )
	GHOST.y = mid(WORLD.ceiling, GHOST.y, WORLD.floor - (GHOST.size - 1))
end

function ghostIsTouchingFloor()
	return GHOST.y == WORLD.floor - (GHOST.size - 1)
end

function ghostIsWallColliding(wall)
	local ghostHitbox = ghostCalculateHitBox()
	if ghostHitbox.x < wall.x + wall.w
			and ghostHitbox.x + ghostHitbox.w > wall.x
			and ghostHitbox.y < wall.y + wall.h
			and ghostHitbox.y + ghostHitbox.h > wall.y then
		return true
	else
		return false
	end
end

function ghostIsColliding()
end

function gameOver()
	if ghostIsWallColliding(WALL_ABOVE)
			or ghostIsWallColliding(WALL_BOTTOM)
			or ghostIsTouchingFloor() then
		GHOST.currentSprite = 4
		GAME_OVER = true
	end
end

function ghostCalculateHitBox()
	local hitbox = { x = GHOST.x, y = GHOST.y, w = GHOST.size, h = GHOST.size - 1 }
	return hitbox
end

function ghostDrawHitBox()
	local hitbox = { x = GHOST.x, y = GHOST.y, w = GHOST.size, h = GHOST.size - 1 }
	rect(hitbox.x, hitbox.y, hitbox.x + hitbox.w, hitbox.y + hitbox.h)
end

function ghostFalling()
	GHOST.y = GHOST.y - (GHOST.verticalSpeed * DELTATIME)
	GHOST.verticalSpeed = GHOST.verticalSpeed + (-300 * DELTATIME)
end

function ghostJump()
	if btnp(5) then
		GHOST.verticalSpeed = GHOST.jumpSpeed
	end
end

function ghostCalculateAnimation()
	local timeBetweenSprites = 0.2
	if btnp(5) then
		TIMER.ghostAnimationSpriteTime = 0.25
		GHOST.activeSpriteSheet = 2
	end

	if TIMER.ghostAnimationSpriteTime == 0 then
		GHOST.activeSpriteSheet = 0
	end
	GHOST.currentSprite = flr(((time() / timeBetweenSprites) % 2) + GHOST.activeSpriteSheet)
end

---- WALL CALCULATIONS -----------------------

function wallCalculateBehavior()
	moveWall(WALL_ABOVE)
	moveWall(WALL_BOTTOM)
	respawnWall(WALL_ABOVE, "top")
	respawnWall(WALL_BOTTOM, "bottom")
end

function moveWall(wall)
	local wallSpeed = 2
	wall.x -= wallSpeed
end

function respawnWall(wall, type)
	if wall.x + wall.w <= 0 then
		wall.x = 128
		if type == "top" then
			wall.h = rnd(20) + 20
		end
		if type == "bottom" then
			wall.y = WORLD.floor - (rnd(50) + 30)
		end
	end
end

-- WALL_ABOVE = { x = 100, y = WORLD.ceiling, w = 5, h = 40 }
-- WALL_BOTTOM = { x = 100, y = WORLD.floor - 40, w = 5, h = 40 }

---- DRAWING -----------------------
function ghostDraw()
	spr(GHOST.currentSprite, GHOST.x, GHOST.y)
end

function wallDraw(wall)
	rectfill(wall.x, wall.y, wall.x + wall.w, wall.y + wall.h, COLORS.DARKGREEN)
end

function gameOverDraw()
	if GAME_OVER then
		PRINT.inCenter("game over from pc", 63, COLORS.RED)
	end
end

-- GAME START -----------------------
function _init()
end

function _update60()
	gameOver()
	if not GAME_OVER then
		calculateTimers()
		calculateDeltaTime()
		ghostCalculateBehavior()
		ghostCalculateAnimation()
		wallCalculateBehavior()
	end
end

function _draw()
	cls(COLORS.DARKBLUE)
	gameOverDraw()
	ghostDraw()
	wallDraw(WALL_ABOVE)
	wallDraw(WALL_BOTTOM)
	-- ghostDrawHitBox()
end

--
------lines

__gfx__
00666660006666600066666000666660008888800088888000000000000000000000000000000000000000000000000000000000000000000000000000000000
06663636666636360666e6e66666e6e6088858580888585800000000000000000000000000000000000000000000000000000000000000000000000000000000
60666666006666666066666600666666808888888088888800000000000000000000000000000000000000000000000000000000000000000000000000000000
00666006006660060066660600666606008880080088800800000000000000000000000000000000000000000000000000000000000000000000000000000000
00066006000660060006660600066606000880080008800800000000000000000000000000000000000000000000000000000000000000000000000000000000
00066066000660660006666600066666000880880008808800000000000000000000000000000000000000000000000000000000000000000000000000000000
00666660606666600066666060666660008888800088888000000000000000000000000000000000000000000000000000000000000000000000000000000000
66660000066600006666000006660000888800008888000000000000000000000000000000000000000000000000000000000000000000000000000000000000
