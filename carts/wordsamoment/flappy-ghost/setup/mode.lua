function setActiveMode(mode)
	for mode in pairs(MODE) do
		MODE[mode] = false
	end
	MODE[mode] = true
end

-- Main Menu mode
function mainMenuModeUpd()
	mainMenuExecuteSelectedOption()
	ghostUpdateSprite()
	ghostParticlesSpawn(GHOST.x_main_menu)
	ghostParticlesMove()
end

function mainMenuModeDrw()
	mainSceneDraw()
	environmentUpdate()
	mainMenuDraw()
	mainMenuNavigateOptions()
	ghostDraw(GHOST.x_main_menu, GHOST.y)
end

-- Main Menu transition to Gameplay mode
function mainMenuTransitionToGameplayModeUpd()
	transitionMainMenuToGameplayUpd()
	ghostUpdateSprite()
	ghostParticlesMove()
end

function mainMenuTransitionToGameplayModeDrw()
	mainSceneDraw()
	environmentUpdate()
	ghostDraw(GHOST.x, GHOST.y)
	transitionMainMenuToGameplayDrw()
end

-- Gameplay mode
function gameplayModeUpd()
	calculateTimers()
	environmentUpdate()
	ghostParticlesSpawn(GHOST.x)
	ghostParticlesMove()
	ghostCalculateBehavior()
	ghostUpdateSprite()
	wallCalculateBehavior()
	scoreIncrease()
	if isGameOver() then setActiveMode("game_over") end
end

function gameplayModeDrw()
	mainSceneDraw()
	wallDraw()
	ghostDraw(GHOST.x, GHOST.y)
	scoreDraw()
	ghostInvisibleSkillIconDraw()
	-- print(MODE.gameplay, 0, 50, COLORS.green)
end

-- Gameover mode
function gameOverModeUpd()
	if btnp(🅾️) then
		gameInit()
		setActiveMode("gameplay") -- kinda mid cause gameInit sets it to main menu?
	end
end

function gameOverModeDrw()
	mainSceneDraw()
	wallDraw()
	ghostDraw(GHOST.x, GHOST.y)
	scoreDraw()
	ghostInvisibleSkillIconDraw()
	PRINT:inCenter("game over", 60, "big")
	PRINT:inCenter("press 🅾️/z to retry", 80)
end