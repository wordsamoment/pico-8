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

GAME = { speed = 1.5, wallGap = 40, maxWalls = 2, over = false }
WORLD = { ceiling = 0, floor = 127 }
GHOST = { x = 64, y = 50, size = 8, currentSprite = 0, lastJumpTime = 0, verticalSpeed = 0, jumpSpeed = GAME.speed * 70, activeSpriteSheet = 0 }
WALLS = {} -- go to createWall()

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
	if ghostHitbox.x < wall.top_wall.x + wall.top_wall.width
			and ghostHitbox.x + ghostHitbox.w > wall.top_wall.x
			and ghostHitbox.y < wall.top_wall.y + wall.top_wall.height
			and ghostHitbox.y + ghostHitbox.h > wall.top_wall.y then
		return true
	elseif ghostHitbox.x < wall.bottom_wall.x + wall.bottom_wall.width
			and ghostHitbox.x + ghostHitbox.w > wall.bottom_wall.x
			and ghostHitbox.y < wall.bottom_wall.y + wall.bottom_wall.height
			and ghostHitbox.y + ghostHitbox.h > wall.bottom_wall.y then
		return true
	else
		return false
	end
end

function isGameOver()
	local ghostCollidedWithWall = false

	for wall in all(WALLS) do
		ghostCollidedWithWall = ghostIsWallColliding(wall)
	end

	if ghostCollidedWithWall or ghostIsTouchingFloor() then
		GHOST.currentSprite = 4
		return true
	else
		return false
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
	GHOST.verticalSpeed = GHOST.verticalSpeed + ((-200 * GAME.speed) * DELTATIME)
end

function ghostJump()
	if btnp(5) then
		GHOST.verticalSpeed = GHOST.jumpSpeed
		sfx(0)
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
	moveWall()
	respawnWall()
end

function moveWall(wall)
	for wall in all(WALLS) do
		wall.top_wall.x -= GAME.speed
		wall.bottom_wall.x -= GAME.speed
	end
end

function respawnWall()
	if WALLS[1].top_wall.x + WALLS[1].top_wall.width <= 0 then
		del(WALLS, WALLS[1])
		createWall()
	end
	if WALLS[1].top_wall.x + WALLS[1].top_wall.width <= 64 then
		createWall()
	end
end

function createWall()
	if #WALLS < GAME.maxWalls then
		local height = rnd(80) + 20
		local wall = {
			top_wall = { x = 128, y = WORLD.ceiling, width = 5, height = height },
			bottom_wall = { x = 128, y = height + GAME.wallGap, width = 5, height = WORLD.floor }
		}
		add(WALLS, wall)
	end
end

---- DRAWING -----------------------
function ghostDraw()
	spr(GHOST.currentSprite, GHOST.x, GHOST.y)
end

function wallDraw()
	for wall in all(WALLS) do
		rectfill(wall.top_wall.x, wall.top_wall.y, wall.top_wall.x + wall.top_wall.width, wall.top_wall.y + wall.top_wall.height, COLORS.DARKGREEN)
		rectfill(wall.bottom_wall.x, wall.bottom_wall.y, wall.bottom_wall.x + wall.bottom_wall.width, wall.bottom_wall.y + wall.bottom_wall.height, COLORS.DARKGREEN)
	end
end

function gameOverDraw()
	if GAME.over then
		PRINT.inCenter("game over", 63, COLORS.RED)
	end
end

-- GAME START -----------------------
function _init()
	poke(0x5f5c, 255)
	-- Make btnp not repeat
	createWall()
end

function _update60()
	if not GAME.over then
		calculateTimers()
		calculateDeltaTime()
		-- ghostCalculateBehavior()
		-- ghostCalculateAnimation()
		wallCalculateBehavior()
		GAME.over = isGameOver()
	end
end

function _draw()
	cls(COLORS.DARKBLUE)

	gameOverDraw()
	-- ghostDraw()
	wallDraw()
	-- ghostDrawHitBox()
	-- print(stat(1))
	-- print(stat(7) .. "fps")
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
__sfx__
0101000003520075200b5200f52012520165200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0002000022750207501f7501b75019750187501675014750117500f7500d7500b7500975008750067500375001750007502a75000000000000000000000000000000000000000000000000000000000000000000