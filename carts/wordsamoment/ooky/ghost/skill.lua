---- CALCULATIONS -----------------------
function ghostInvisibleSkillUpdate()
	if TIMER.ghost_invisible_cooldown == 0 then
		if btnp(🅾️) then
			sfx(2)
			TIMER.ghost_invisible = DURATION.ghost_invisible
			GHOST.invisible = true
			TIMER.ghost_invisible_cooldown = DURATION.ghost_invisible_cooldown
		end
	end
end

---- DRAWING -----------------------
function ghostInvisibleSkillIconDraw()
	if MODE.game_over then
		spr(10, 2, 110, 2, 2)
	else
		if TIMER.skill_icon_animation == 0 then
			TIMER.skill_icon_animation = 1
			GHOST_SKILL.icon_y_offset = 1 - GHOST_SKILL.icon_y_offset
		end

		-- also make elapsedTime a local or smth
		elapsedTime = (TIMER.ghost_invisible_cooldown / DURATION.ghost_invisible_cooldown)
		GHOST_SKILL.circle_cooldown.radius = 8 + (0 - 8) * elapsedTime

		palt(COLORS.dark_blue, true)
		palt(COLORS.black, false)
		if TIMER.ghost_invisible_cooldown == 0 then
			spr(12, 2, 110 - GHOST_SKILL.icon_y_offset, 2, 2)
		else
			spr(10, 2, 110, 2, 2)
			circ(GHOST_SKILL.circle_cooldown.center_x, GHOST_SKILL.circle_cooldown.center_y, GHOST_SKILL.circle_cooldown.radius, GHOST_SKILL.circle_cooldown.color)
		end
		palt(COLORS.dark_blue, false)
		palt(COLORS.black, true)
	end
end