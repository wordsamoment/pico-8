pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
COLORS = { BLACK = 0, DARKBLUE = 1, MAGENTA = 2, DARKGREEN = 3, BROWN = 4, DARKGREY = 5, GREY = 6, WHITE = 7, RED = 8, ORANGE = 9, YELLOW = 10, NEONGREEN = 11, LIGHTBLUE = 12, LAVENDER = 13, PINK = 14, PEACH = 15 }
--x = 90
--y = 0
--c = 10
--
--cls()
--
--pset(x,y,c)
--pset(x+20,y+20,c+4)

-- health bar
--x=64
--y=50
--cls()
--rect(x-50,y,x+50,y+20,6) -- outer grey rect
--rectfill(x-49,y+1,x,y+19,8) -- inner red
--rectfill(x,y+1,x+49,y+19,1) -- inner blue
--line(x-50,y+21,x+50,y+21,13) -- bottom border line

-- health bar after nerdy showed it in layers
-- x=64
-- y=50
-- cls()
-- rect(x-50,y,x+50,y+20,13) -- outer grey rect
-- rectfill(x-49,y+1,x+49,y+19,1) -- inner blue
-- rectfill(x-49,y+1,x,y+19,8) -- inner red
-- rect(x-50,y,x+50,y+19,6) -- outer grey rect

-- health bar challenge one
-- x = 20
-- y = 50
-- width = 100
-- height = 20
-- cls()
-- rect(x + 1, y + 1, x + width + 1, y + height + 1, COLORS.LAVENDER) -- outer grey rect
-- rectfill(x, y + 1, x + width, y + height, COLORS.DARKBLUE) -- inner blue
-- rectfill(x, y + 1, x + (width / 2), y + height, COLORS.RED) -- inner red
-- rect(x, y, x + width, y + height, COLORS.GREY) -- outer grey rect
-- print("health", x, y - 6, COLORS.WHITE)

-- health bar challenge two
-- x = 20
-- y = 50
-- width = 60
-- height = 10
-- cls()
-- rectfill(x, y, x + width, y + height + 3, COLORS.LAVENDER) -- outer grey rect
-- rectfill(x, y + 1, x + width, y + height, COLORS.DARKBLUE) -- inner blue
-- rectfill(x, y + 1, x + 2*(width / 3), y + height, COLORS.RED) -- inner red
-- rect(x, y, x + width, y + height, COLORS.GREY) -- outer grey rect
-- print("health", x, y - 6, COLORS.WHITE)

-- health bar challenge three
-- x = 20
-- y = 50
-- width = 60
-- height = 10
-- cls()
-- rectfill(x, y, x + width, y + height + 3, COLORS.LAVENDER) -- outer grey rect
-- rectfill(x, y + 1, x + width, y + height, COLORS.DARKBLUE) -- inner blue
-- rectfill(x, y + 1, x + 2*(width / 3), y + height, COLORS.RED) -- inner red
-- rect(x, y, x + width, y + height, COLORS.GREY) -- outer grey rect
-- print("health", x+3, y+3, COLORS.MAGENTA)

-- health bar challenge four
-- x = 20
-- y = 50
-- width = 60
-- height = 10
-- cls()
-- rectfill(x, y, x + width, y + height + 3, COLORS.LAVENDER) -- outer grey rect
-- rectfill(x, y + 1, x + width, y + height, COLORS.DARKBLUE) -- inner blue
-- rectfill(x, y + 1, x + 3*(width / 4), y + height, COLORS.RED) -- inner red
-- line(x + 3*(width / 4) +1 , y + 1, x + 3*(width / 4) +1, y + height, COLORS.WHITE) -- inner red
-- rect(x, y, x + width, y + height, COLORS.GREY) -- outer grey rect
-- print("health", x+3, y+3, COLORS.MAGENTA)

-- health bar challenge five
-- x = 20
-- y = 50
-- width = 60
-- height = 10
-- cls()
-- rectfill(x, y, x + width, y + height + 3, COLORS.LAVENDER) -- outer grey rect
-- rectfill(x, y + 1, x + width, y + height, COLORS.DARKBLUE) -- inner blue
-- rectfill(x, y + 2, x + (1.80 * (width / 2) + 1), y + height - 2, COLORS.RED) -- inner red
-- line(x + (1.80 * (width / 2) + 1), y + 2, x + (1.80 * (width / 2) + 1), y + height - 2, COLORS.WHITE) -- inner red
-- rect(x, y, x + width, y + height, COLORS.GREY) -- outer grey rect
-- print("health", x + 3, y + 3, COLORS.MAGENTA)

-- energy bar extra challenge
x = 50
y = 30
width = 12
height = 50
radius = 2
cls()

-- BACKGROUND RECTANGLE
rect(x, y, x + width + 1, y + height + 1, COLORS.ORANGE) -- background orange border

-- ENERGY RECTANGLES
rectfill(x, y, x + width, y + height, COLORS.DARKGREEN)
rectfill(x, y + height / 3, x + width, y + height, COLORS.NEONGREEN)
circ(x + width / 3 * 2, y + height / 5 * 2, radius, COLORS.DARKGREEN)
circ(x + width / 3, y + height / 4 * 2, radius - 1, COLORS.DARKGREEN)
circ(x + width / 3 + 1, y + height / 4, radius - 1, COLORS.NEONGREEN)

-- CIRCLES
-- top left circles
circfill(x, y, radius, COLORS.YELLOW)

-- top right circles
circfill(x + width + 1, y + 1, radius, COLORS.ORANGE)
circfill(x + width, y, radius, COLORS.YELLOW)

-- bottom right circles
circfill(x + width + 1, y + height + 1, radius, COLORS.ORANGE)
circfill(x + width, y + height, radius, COLORS.YELLOW)

-- bottom left circles
circfill(x + 1, y + height + 1, radius, COLORS.ORANGE)
circfill(x, y + height, radius, COLORS.YELLOW)

-- FOREGROUND RECTANGLE
rect(x, y, x + width, y + height, COLORS.YELLOW)  -- foreground yellow border

-- TWINKLE CIRCLES (WHITE)
circ(x - 1, y - 1, radius - 1, COLORS.WHITE)
circ(x - 1 + width, y - 1, radius - 1, COLORS.WHITE)
circ(x - 1 + width, y + height - 1, radius - 1, COLORS.WHITE)
circ(x - 1, y + height - 1, radius - 1, COLORS.WHITE)

print("energy", x - 5, y - 9, COLORS.NEONGREEN)

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
