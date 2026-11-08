---- CALCULATIONS -----------------------
-- https://nerdyteachers.com/PICO-8/Collision/101
function ghostWorldBoundaryCollision()
	-- middle number between ceiling, ghost's y and floor (minus the ghost's srite height )
	GHOST.y = mid(WORLD.ceiling, GHOST.y, WORLD.floor - (GHOST.size - 1))
end

function ghostIsTouchingFloor()
	return GHOST.y == WORLD.floor - (GHOST.size - 1)
end

function ghostIsWallColliding(wall)
	if not GHOST.invisible then
		if GHOST.x < wall.x + wall.width
				and GHOST.x + GHOST.size > wall.x
				and GHOST.y < wall.top_part.y + wall.top_part.height - 1
				and GHOST.y + GHOST.size > wall.top_part.y then
			return true
		elseif GHOST.x < wall.x + wall.width
				and GHOST.x + GHOST.size > wall.x
				and GHOST.y < wall.bottom_part.y + wall.bottom_part.height
				and GHOST.y + GHOST.size > wall.bottom_part.y then
			return true
		else
			return false
		end
	else
		return false
	end
end

function ghostFalling()
	if not ghostIsTouchingFloor() then
		GHOST.y = GHOST.y - (GHOST.vertical_speed * DELTATIME)
		GHOST.vertical_speed = GHOST.vertical_speed + ((-300 * GAME.speed) * DELTATIME)
	end
end

function ghostJump()
	GHOST.jump_speed = GAME.speed * 90
	if btnp(5) then
		GHOST.vertical_speed = GHOST.jump_speed
		GHOST.jumping = true
		TIMER.ghost_jumping = 0.2
		sfx(0)
	end
end

-- Doesn't draw, calculates sprite to be drawn by ghostDraw()
function ghostCalculateAnimation()
	-- Ghost Spritesheet reference:
	-- 0 1 = Base sprites
	-- 2 3 = Jumping sprites
	-- 4 5 = Invisible sprites
	-- 6 7 = Jumping + Invisible sprites
	-- 8 9 = Death sprites

	local sprite_offset = 0

	if TIMER.time_between_sprites == 0 then
		TIMER.time_between_sprites = 0.2
		GHOST.sprite_choice = 1 - GHOST.sprite_choice
		-- This always flips between 1 and 0
		-- sprite_choice = 1 - 1 = 0
		-- sprite_choice = 1 - 0 = 1
	end

	if TIMER.ghost_jumping == 0 then
		GHOST.jumping = false
	end

	if TIMER.ghost_invisible == 0 then
		sfx(-2)
		GHOST.invisible = false
	end

	if GHOST.jumping then
		sprite_offset += GHOST.next_sprite_set_step
	end

	if GHOST.invisible then
		sprite_offset += GHOST.next_sprite_set_step * 2
	end

	-- Set the appropriate current ghost sprite.
	-- Summing sprite_choice (0 or 1) and sprite_offset(2,4,6)
	-- The duration of each sprite before flipping is "TIMER.time_between_sprites" long
	GHOST.current_sprite = GHOST.sprite_choice + sprite_offset
	-- COnsider using sset for the eyes, not multiple sprites.
end

function ghostCalculateBehavior()
	ghostJump()
	ghostInvisibleSkillUpdate()
	ghostFalling()
	ghostWorldBoundaryCollision()
end

---- DRAWING -----------------------
function ghostDeath()
	sfx(1)
	GHOST.current_sprite = 8
end

function ghostDraw()
	ghostParticlesDraw()
	spr(GHOST.current_sprite, flr(GHOST.x + 0.5), flr(GHOST.y + 0.5))
end

function ghostDrawHitBox()
	rect(GHOST.x, GHOST.y, GHOST.x + GHOST.size, GHOST.y + GHOST.size, COLORS.green)
end