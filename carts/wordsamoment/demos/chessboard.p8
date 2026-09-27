pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
cls()

-- ATTEMPT 01
-- -- INIT
-- x = 0
-- y = 0
-- tile_size = 15.9
-- -- at 15.9 the last pixel is at 127.2 which rounds down to 127 which uses the full screen.
-- black = 0
-- white = 7

-- function drawChessBoard(withOutline)
-- 	for row = 0, 7, 1 do
-- 		for column = 0, 7, 1 do
-- 			if row % 2 == 0 then
-- 				if (column % 2 == 0) then
-- 					color = black
-- 				else
-- 					color = white
-- 				end
-- 			else
-- 				if (column % 2 == 0) then
-- 					color = white
-- 				else
-- 					color = black
-- 				end
-- 			end
-- 			rectfill(x, y, x + tile_size, y + tile_size, color)
-- 			if withOutline then
-- 				rect(x, y, x + tile_size, y + tile_size, 8)
-- 			end
-- 			x += tile_size
-- 		end
-- 		x = 0
-- 		y += tile_size
-- 	end
-- end

-- function debugPixels()
-- 	pset(0, 0, 3)
-- 	pset(15, 0, 3)
-- 	pset(127, 127, 3)
-- 	pset(112, 128, 3)
-- end

-- -- MAIN EXECUTION
-- drawChessBoard(false)
-- debugPixels()

-- -- ATTEMPT 02
-- -- INIT
-- function drawChessBoard(withOutline)
-- 	x = 0
-- 	y = 0
-- 	tile_size = 15
-- 	black = 0
-- 	white = 7
-- 	for row = 0, 7, 1 do
-- 		for column = 0, 7, 1 do
-- 			if (row + column) % 2 == 0 then
-- 				color = black
-- 			else
-- 				color = white
-- 			end
-- 			rectfill(x, y, x + tile_size, y + tile_size, color)
-- 			if withOutline then
-- 				rect(x, y, x + tile_size, y + tile_size, 8)
-- 			end
-- 			x += tile_size + 1
-- 		end
-- 		x = 0
-- 		y += tile_size + 1
-- 	end
-- end

-- function debugPixels()
-- 	pset(0, 0, 3)
-- 	pset(15, 0, 3)
-- 	pset(127, 127, 3)
-- end

-- -- MAIN EXECUTION
-- drawChessBoard()
-- debugPixels()

-- while true do
-- end

-- -- ATTEMPT 03
-- -- INIT
-- function drawChessBoard(withOutline)
-- 	local x = 0
-- 	local y = 0
-- 	local tile_size = 15
-- 	local black = 0
-- 	local white = 7
-- 	local color
-- 	for row = 0, 7, 1 do
-- 		for column = 0, 7, 1 do
-- 			if (row + column) % 2 == 0 then
-- 				color = black
-- 			else
-- 				color = white
-- 			end
-- 			x = column * 16 y = row * 16
-- 			rectfill(x, y, x + tile_size, y + tile_size, color)
-- 			if withOutline then rect(x, y, x + tile_size, y + tile_size, 8) end
-- 		end
-- 	end
-- end

-- function debugPixels()
-- 	pset(0, 0, 3)
-- 	pset(15, 0, 3)
-- 	pset(127, 127, 3)
-- end

-- -- MAIN EXECUTION
-- drawChessBoard()
-- debugPixels()

-- ATTEMPT 03 ONLY WHITE SQUARES
-- INIT
function drawChessBoard(withOutline)
	local x = 0
	local y = 0
	local tile_size = 15
	local color = 7
	for row = 0, 7, 1 do -- for 8 rows
		for column = 0, 7, 1 do -- for 8 columns
			if (row + column) % 2 == 1 then -- modulo 0, white first, modulo 1, white second
				x = column * 16 y = row * 16 -- calculating top left coords of each square
				rectfill(x, y, x + tile_size, y + tile_size, color) -- drawing square with top left coords + tile size on each opposite side to fill in the square
			end
		end
	end
end

function debugPixels()
	pset(0, 0, 3)
	pset(15, 0, 3)
	pset(127, 127, 3)
end

-- MAIN EXECUTION
cls()
drawChessBoard()
debugPixels()

while true do
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
