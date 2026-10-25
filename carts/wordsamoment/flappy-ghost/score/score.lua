function createScore()
	SCORE = { count = 0 }
end

function scorePoint()
	for wall in all(WALLS) do
		if GHOST.x == wall.x + wall.width then
			SCORE.count += 1
			sfx(3)
		end
	end
end