pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
-- SETUP -----------------------
COLORS = { BLACK = 0, DARKBLUE = 1, MAGENTA = 2, DARKGREEN = 3, BROWN = 4, DARKGREY = 5, GREY = 6, WHITE = 7, RED = 8, ORANGE = 9, YELLOW = 10, NEONGREEN = 11, LIGHTBLUE = 12, LAVENDER = 13, PINK = 14, PEACH = 15 }

-- FUNCTIONS -----------------------
---- MATH -----------------------

-- Converts 0-360 degrees into 0.0-1.0 turn scale.
-- sin() and cos() expect turn values (e.g., 0.25 = 90 deg, 0.5 = 180 deg).
function convertDegreeToTurn(degree)
	return degree / 360
end

-- Find points on a circle using parametric form equation: https://en.wikipedia.org/wiki/Circle#Parametric_form
function getPointOnCircle(circleOriginX, circleOriginY, circleRadius, angle)
	local point = { x = nil, y = nil }
	point.x = circleOriginX + circleRadius * cos(convertDegreeToTurn(angle))
	point.y = circleOriginY + circleRadius * sin(convertDegreeToTurn(angle))
	return point
end

---- UTILITIES -----------------------
function getCurrentTime()
	local time = {}
	time.hour = stat(93)
	time.minute = stat(94)
	time.second = stat(95)
	return time
end

---- DRAWING -----------------------
function setScene(frameMode)
	cls(bg_color)
	if frameMode then
		rect(0, 0, 127, 127, COLORS.WHITE)
	end
end

-- Prints the the actual time in digital format.
-- explain sub trick.
function printFullTime(posX, posY, fontColor)
	print(sub("0" .. getCurrentTime().hour, -2) .. ":" .. sub("0" .. getCurrentTime().minute, -2) .. ":" .. sub("0" .. getCurrentTime().second, -2), posX, posY, fontColor)
end

function printTimer()
	print(flr((time() % (duration * 2)) * 100) / 100, 0, 0, COLORS.WHITE)
end

------ CLOCK MARKERS -----------------------
function drawMarkerLine(circleCenterX, circleCenterY, circleRadius, markerOffset, markerLength, markerAngle, markerColor)
	local x1 = getPointOnCircle(circleCenterX, circleCenterY, circleRadius + markerOffset, markerAngle).x
	local y1 = getPointOnCircle(circleCenterX, circleCenterY, circleRadius + markerOffset, markerAngle).y
	local x2 = getPointOnCircle(circleCenterX, circleCenterY, circleRadius + (markerOffset + markerLength), markerAngle).x
	local y2 = getPointOnCircle(circleCenterX, circleCenterY, circleRadius + (markerOffset + markerLength), markerAngle).y
	line(x1, y1, x2, y2, markerColor)
end

-- Maps the angle back to a 12-hour clock digit (0-11) centered relative to 3 o'clock (0るぬ).
-- Formula: (-1/30 * angle + 3) % 12 converts 30るぬ steps into counter-clockwise clock face numbers.

-- make rendering in better place. look up font size glyph size in pico.
function printHourNumbers(circleCenterX, circleCenterY, circleRadius, numberPosOffset, numberAngle, numberColor)
	local x = getPointOnCircle(circleCenterX, circleCenterY, circleRadius + numberPosOffset, numberAngle).x
	local y = getPointOnCircle(circleCenterX, circleCenterY, circleRadius + numberPosOffset, numberAngle).y
	local hourNumber = ((flr((-1 / 30) * numberAngle + 3) - 1) % 12) + 1
	print(hourNumber, x, y, numberColor)
end

function drawClockMarkers()
	for hourMarkerAngle = 0, 360, 30 do
		drawMarkerLine(centerX, centerY, radius, -2, 4, hourMarkerAngle, COLORS.RED)
		printHourNumbers(centerX, centerY, radius, 8, hourMarkerAngle, COLORS.RED)
	end

	for secondMarkerAngle = 0, 360, 6 do
		drawMarkerLine(centerX, centerY, radius, -4, 0, secondMarkerAngle, COLORS.DARKGREEN)
	end
end

function animateSize()
	elapsedTime = time() % 2

	if flr(elapsedTime) < 1 then
		-- f(x) = A + (B - A)*x
		radius = start_radius + (end_radius - start_radius) * elapsedTime
	elseif flr(elapsedTime) >= 1 then
		radius = end_radius + (start_radius - end_radius) * (elapsedTime - 1)
	end
end

------ CLOCK HANDLES -----------------------
-- Converts 12-hour or 60-minute time values to standard 360るぬ positions.
function drawClockHandle(type, time, circleRadius, handleColor)
	local handleLength, handleAngle, handleFraction, scalar = nil, nil, 0, nil
	if type == "hour" then
		handleLength = flr(circleRadius / 3)
		handleFraction = time.minute / 60 -- For hours calculate fraction to move hour handle between current and next hour. It's a number between 0.0 (current hour) and 1.0 (next hour)
		scalar = -30
	elseif type == "minute" or type == "second" then
		handleLength = flr(circleRadius / 1.5)
		scalar = -6
	end

	-- f(x) = -30x + 90 : Hours
	-- f(x) = -6x + 90  : Minutes or Seconds
	handleAngle = (scalar * (time[type] + handleFraction) + 90)
	local handleOnClock = getPointOnCircle(centerX, centerY, handleLength, handleAngle)
	line(centerX, centerY, handleOnClock.x, handleOnClock.y, handleColor)
end

function drawClockHandles()
	drawClockHandle("hour", getCurrentTime(), radius, COLORS.WHITE)
	drawClockHandle("minute", getCurrentTime(), radius, COLORS.WHITE)
	drawClockHandle("second", getCurrentTime(), radius, COLORS.RED)
end

-- GAME START -----------------------
function _init()
	-- Enables mouse
	poke(0x5f2d, 1)
	mouse = { x = nil, y = nil }

	-- Clock properties
	centerX, centerY = 64, 64
	start_radius = 20
	end_radius = 80
	radius = start_radius

	-- Animation parameters
	duration = 1
	angle = 0
	bg_color = COLORS.BLACK
	direction = "up"
	linex = 10
	elapsedTime = 0
end

function _update60()
	mouse.x = stat(32)
	mouse.y = stat(33)
	-- centerX = mouse.x
	-- centerY = mouse.y
	animateSize()
end

function _draw()
	setScene(true)

	-- Outer clock frame
	circ(centerX, centerY, radius, COLORS.WHITE)

	-- Center clock dial
	circfill(centerX, centerY, 2, COLORS.WHITE)

	drawClockMarkers()
	drawClockHandles()

	printFullTime(96, 122, COLORS.PEACH)
	printTimer()
	print(flr(elapsedTime * 100) .. "%", 100, 0, COLORS.RED)

	pset(10, 4, COLORS.WHITE)
	pset(70, 4, COLORS.WHITE)
	pset(mouse.x, mouse.y, COLORS.RED)
end

--
------lines

__gfx__
82225555555555550000000000000000000000000066660000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000600006000000000000000000000000000000000000000000000000000000000000000000000000000000000
55550555555505550000000000000000000000006099990600000000000000000000000000000000000000000000000000000000000000000000000000000000
66550666665506660000000000000000000000006099990600000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000006099990600000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666666660000000000000000000000006099990600000000000000000000000000000000000000000000000000000000000000000000000000000000
66066666660666660000000000000000000000000600006000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666666660000000000000000000000000066660000000000000000000000000000000000000000000000000000000000000000000000000000000000
