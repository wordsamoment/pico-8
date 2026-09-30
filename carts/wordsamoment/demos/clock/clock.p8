pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
-- ATTEMPT 01
-- INIT

COLORS = { BLACK = 0, DARKBLUE = 1, MAGENTA = 2, DARKGREEN = 3, BROWN = 4, DARKGREY = 5, GREY = 6, WHITE = 7, RED = 8, ORANGE = 9, YELLOW = 10, NEONGREEN = 11, LIGHTBLUE = 12, LAVENDER = 13, PINK = 14, PEACH = 15 }

function convertDegreeToTurn(degree)
	return degree / 360
end

function getPointOnCircle(circleOriginX, circleOriginY, circleRadius, angle)
	local point = {}
	point.x = circleOriginX + circleRadius * cos(convertDegreeToTurn(angle))
	point.y = circleOriginY + circleRadius * sin(convertDegreeToTurn(angle))
	return point
end

function drawBoldMarker(angle)
	local x1 = getPointOnCircle(centerx, centery, radius-1, angle).x
	local y1 = getPointOnCircle(centerx, centery, radius-1, angle).y
	local x2 = getPointOnCircle(centerx, centery, radius+2, angle).x
	local y2 = getPointOnCircle(centerx, centery, radius+2, angle).y
	-- print(angle)
	line(x1, y1, x2, y2, COLORS.RED)
end

function printHourNumbers(angle)
	local x = getPointOnCircle(centerx, centery, radius + 10, angle).x
	local y = getPointOnCircle(centerx, centery, radius + 10, angle).y
	local hourNumber = flr((-1 / 30) * angle + 3) % 12
	print(hourNumber, x, y, COLORS.RED)
end

function drawMarker(angle)
	local x = getPointOnCircle(centerx, centery, radius - 4, angle).x
	local y = getPointOnCircle(centerx, centery, radius - 4, angle).y
	rectfill(x, y, x, y, 3)
end

-- f(x) = -30x + 90
-- This equations maps hours [0, 23] to degree angles (0, 30, 90)
function drawHourHandle(hour)
	local hourHandleLength = radius - 20
	local hourFraction = getCurrentTime().minute / 60
	local hourAngle = (-30 * (hour + hourFraction) + 90)
	local hourOnClock = getPointOnCircle(centerx, centery, hourHandleLength, hourAngle)
	line(centerx, centery, hourOnClock.x, hourOnClock.y, COLORS.WHITE)
end

-- f(x) = -6x + 90
-- This equations maps minutes or seconds [0, 59] to degree angles (0, 30, 90)
function drawMinuteSecondHandle(time, color)
	local timeHandleLength = radius - 10
	local timeFraction = time / 60
	local timeAngle = (-6 * (time + timeFraction) + 90)
	local timeOnClock = getPointOnCircle(centerx, centery, timeHandleLength, timeAngle)
	line(centerx, centery, timeOnClock.x, timeOnClock.y, color)
end

function getCurrentTime()
	local time = {}
	time.hour = stat(93)
	time.minute = stat(94)
	time.second = stat(95)
	return time
end

function printFullTime()
	print(getCurrentTime().hour .. ":" .. getCurrentTime().minute .. ":" .. getCurrentTime().second, 0, 0, COLORS.WHITE)
end

function _init()
	poke(0x5f2d, 1)
	-- enables mouse/keyboard input
	mouse = {}
	centerx, centery = 64, 64
	radius = 39
	angle = 0
	bg_color = COLORS.DARKBLUE
end

function _update60()
	mouse.x = stat(32)
	mouse.y = stat(33)
end

function _draw()
	cls(bg_color)
	circ(centerx, centery, radius, COLORS.WHITE)
	circfill(centerx, centery, 2, COLORS.WHITE)
	for i = 0, 360, 30 do
		drawBoldMarker(i)
		printHourNumbers(i)
	end

	for i = 0, 360, 6 do
		drawMarker(i)
	end

	drawHourHandle(getCurrentTime().hour)
	drawMinuteSecondHandle(getCurrentTime().minute, COLORS.WHITE)
	drawMinuteSecondHandle(getCurrentTime().second, COLORS.RED)
	pset(mouse.x, mouse.y, COLORS.RED)
	-- pset(stat(32), stat(33), COLORS.RED)
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
