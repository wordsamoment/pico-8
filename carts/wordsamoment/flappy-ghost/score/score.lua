function scoreIncrease()
	for wall in all(WALLS) do
		if GHOST.x == wall.x + wall.width then
			SCORE.count += 1
			sfx(3)
		end
	end
end

function scoreDraw()
	PRINT:score(SCORE.count, 10, COLORS.green)
end