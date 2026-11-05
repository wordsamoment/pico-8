pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
poke(0x5f2d, 1)
-- GAME START -----------------------
function _init()
end

function _update60()
end

function printCenter(string)
	textlabel = "this is some cool text!!!"

	function hcenter(s)
		-- screen center minus the
		-- string length times the
		-- pixels in a char's width,
		-- cut in half
		return 64 - #s * 2
	end

	function vcenter(s)
		-- screen center minus the
		-- string height in pixels,
		-- cut in half
		return 61
	end

	function _draw()
		cls()
		print(textlabel, hcenter(textlabel), vcenter(textlabel), 8)
	end
	local glyph_width = 7
	local glyph_height = 10
	text_style = "\f7\^w\^t"
	print(text_style .. string, 64 - (#string * (glyph_width / 2)), 64 - (glyph_height / 2), 7)
end

function markers(string)
	line(64, 0, 64, 127, 9)
	line(0, 64, 127, 64, 9)

	-- pset(60, 64, 11)
	line(64 - ((#string * glyph_width) / 2), 57, 64 - ((#string * glyph_width) / 2) + glyph_width, 57, 11)
	line(59, 64 - (glyph_height / 2), 59, 64 - (glyph_height / 2) + glyph_height, 11)
end
function _draw()
	cls(1)
	string = "wordsamoment"
	-- markers(string)

	-- print(text_style .. string, 7)

	pset(stat(32), stat(33), 8)
	-- print(text_style .. string)
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
