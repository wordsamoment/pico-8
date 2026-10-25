---- GLOBAL VARIABLES -----------------------

-- ORIGINAL PALLETE
-- COLORS = { black = 0, dark_blue = 1, magenta = 2, dark_green = 3, brown = 4, dark_grey = 5, grey = 6, white = 7, red = 8, orange = 9, yellow = 10, neon_green = 11, light_blue = 12, lavender = 13, pink = 14, peach = 15 }

-- CUSTOM PALLETE
-- https://nerdyteachers.com/PICO-8/Palette/?c=WzAsMjcsMiwzLDIxLDUsNiw3LDE4LDI5LDE5LDExLDE2LDI2LDE0LDE3XQ==
poke(0x5f2e, 1)
pal({ [0] = 0, -5, 2, 3, -11, 5, 6, 7, -14, -3, -13, 11, -16, -6, 14, -15 }, 1)
COLORS = { black = 0, grass_green = 1, magenta = 2, dark_green = 3, mud_brown = 4, dirt_brown = 5, grey = 6, white = 7, dark_magenta = 8, plum = 9, petrol = 10, neon_green = 11, dark_brown = 12, lime = 13, pink = 14, dark_blue = 15 }

DELTATIME = nil -- global delta time
TIMER = setmetatable({}, { __index = function() return 0 end }) -- Clever countdown timer helper - https://lynn.github.io/blog/pico-timers/

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

-- UTILITIES -----------------------
PRINT = {
	inCenter = function(self, text, height)
		local text_style = "\f0\^w\^t\^x5\^obff"
		local glyph_width = 8
		local glyph_height = 12
		print(text_style .. text, 64 - ((#text * glyph_width) / 2), height - (glyph_height / 2), color)
		-- one normal letter = 4 px len
	end,

	score = function(self, text, height)
		local text_style = "\f0\^w\^t\^x5\^obff"
		local glyph_width = 8
		local glyph_height = 12
		print(text_style .. text, 5, height - (glyph_height / 2), color)
	end,

	log = function(self, text)
		print(text, COLORS.neon_green)
		-- one normal letter = 4 px len
	end
}

MATH = {
	getPointOnCircle = function(circleOriginX, circleOriginY, circleRadius, angle)
		local point = { x = nil, y = nil }
		point.x = circleOriginX + circleRadius * cos(angle / 360)
		point.y = circleOriginY + circleRadius * sin(angle / 360)
		return point
	end
}