pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
-- ATTEMPT 01
-- INIT

COLORS = { BLACK = 0, DARKBLUE = 1, MAGENTA = 2, DARKGREEN = 3, BROWN = 4, DARKGREY = 5, GREY = 6, WHITE = 7, RED = 8, ORANGE = 9, YELLOW = 10, NEONGREEN = 11, LIGHTBLUE = 12, LAVENDER = 13, PINK = 14, PEACH = 15 }

function convertDegreeToTurn(degree)
	return degree / 360
end

-- function drawPointOnCircle(circleOriginX, circleOriginY, circleRadius, angle, color)
-- 	x = circleOriginX + circleRadius * cos(convertDegreeToTurn(angle))
-- 	y = circleOriginY + circleRadius * sin(convertDegreeToTurn(angle))
-- 	la = pset(x, y, color)
-- end

function getPointOnCircle(circleOriginX, circleOriginY, circleRadius, angle)
	local point = {}
	point.x = circleOriginX + circleRadius * cos(convertDegreeToTurn(angle))
	point.y = circleOriginY + circleRadius * sin(convertDegreeToTurn(angle))
	return point
end

function drawBoldMarker(angle)
	local x = getPointOnCircle(centerx, centery, radius, angle).x
	local y = getPointOnCircle(centerx, centery, radius, angle).y
	rectfill(x, y, x, y + 2, 8)
end

function drawMarker(angle)
	local x = getPointOnCircle(centerx, centery, radius - 5, angle).x
	local y = getPointOnCircle(centerx, centery, radius - 5, angle).y
	rectfill(x, y, x, y, 3)
end

-- make it move during the hour
function drawHourHandle(hour)
	local hourHandleLength = radius - 40
	local hourAngle = -30 * hour + 90
	local hourAngle2 = getPointOnCircle(centerx, centery, hourHandleLength, hourAngle)
	line(centerx, centery, hourAngle2.x, hourAngle2.y, COLORS.WHITE)
end

function drawMinuteSecondHandle(time, color)
	local timeHandleLength = radius - 20
	local timeAngle = -6 * time + 90
	local timeAngle2 = getPointOnCircle(centerx, centery, timeHandleLength, timeAngle)
	line(centerx, centery, timeAngle2.x, timeAngle2.y, color)
end

function getCurrentTime()
	local time = {}
	time.hour = stat(93)
	time.minute = stat(94)
	time.second = stat(95)
	return time
end

function printFullTime()
	print(getCurrentTime().hour .. ":" .. getCurrentTime().minute .. ":" .. getCurrentTime().second)
end

function _init()
	poke(0x5f2d, 1)
	-- enables mouse/keyboard input
	centerx, centery = 64, 64
	radius = 60
	angle = 0
	bg_color = COLORS.DARKBLUE
end

function _draw()
	cls(bg_color)
	circ(centerx, centery, radius, COLORS.WHITE)
	circfill(centerx, centery, 2, COLORS.WHITE)
	for i = 0, 360, 30 do
		drawBoldMarker(i)
	end

	for i = 0, 360, 6 do
		drawMarker(i)
	end

	drawHourHandle(getCurrentTime().hour)
	drawMinuteSecondHandle(getCurrentTime().minute, COLORS.WHITE)
	drawMinuteSecondHandle(getCurrentTime().second, COLORS.RED)
	pset(stat(32), stat(33), COLORS.RED)
	printFullTime()
end

--
------lines

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
