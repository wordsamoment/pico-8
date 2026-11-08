function setActiveMode(mode)
	for mode in pairs(MODE) do
		MODE[mode] = false
	end
	MODE[mode] = true
end

-- Main Menu mode
function mainMenuModeUpd()
end

function mainMenuModeDrw()
	mainMenuDraw()
end

-- Gameplay mode
function gameplayModeUpd()
	calculateTimers()
	environmentUpdate()
	ghostParticlesSpawn()
	ghostParticlesMove()
	ghostCalculateBehavior()
	ghostCalculateAnimation()
	wallCalculateBehavior()
	scoreIncrease()
	if isGameOver() then setActiveMode("game_over") end
end

function gameplayModeDrw()
	mainSceneDraw()
	wallDraw()
	ghostDraw()
	scoreDraw()
	ghostInvisibleSkillIconDraw()
	-- print(MODE.gameplay, 0, 50, COLORS.green)
end

-- Gameover mode
function gameOverModeUpd()
	if btnp(4) then
		gameInit()
	end
end

function gameOverModeDrw()
	mainSceneDraw()
	wallDraw()
	ghostDraw()
	scoreDraw()
	ghostInvisibleSkillIconDraw()
	PRINT:inCenter("game over", 60, "big")
	PRINT:inCenter("press 🅾️/z to retry", 80)
end