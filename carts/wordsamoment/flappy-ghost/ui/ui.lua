function drawScore()
	PRINT:score(SCORE.count, 10, COLORS.neon_green)
end

local skill_icon_y_offset = 0
local skill_circle_cooldown = { center_x = 10, center_y = 117, radius = 8, color = COLORS.white, points = {} }

function drawSkillIcon()
	if TIMER.skill_icon_animation == 0 then
		TIMER.skill_icon_animation = 1
		skill_icon_y_offset = 1 - skill_icon_y_offset
	end

	elapsedTime = (TIMER.ghost_invisible_cooldown / 5) % 2
	skill_circle_cooldown.radius = 8 + (0 - 8) * elapsedTime

	palt(COLORS.dark_blue, true)
	palt(COLORS.black, false)
	if TIMER.ghost_invisible_cooldown == 0 then
		spr(12, 2, 110 - skill_icon_y_offset, 2, 2)
	else
		spr(10, 2, 110, 2, 2)
		circ(skill_circle_cooldown.center_x, skill_circle_cooldown.center_y, skill_circle_cooldown.radius, skill_circle_cooldown.color)
	end
	palt(COLORS.dark_blue, false)
	palt(COLORS.black, true)
end