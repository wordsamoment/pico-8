pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
-- screen tearing test
-- by /dev/urandom

f = 0

function _init()
end

function _draw()
	for ix = 0, 127 do
		local b = (ix + f) % 16
		if (b >= 8) then
			line(ix, 0, ix, 127, 7)
		else
			line(ix, 0, ix, 127, 0)
		end
	end
end

function _update60()
	f += 1
end
