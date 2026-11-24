function transitionMainMenuToGameplayUpd()
	-- Moving main menu to the left

	menuElapsedTime = (TIMER.main_menu_transition / DURATION.main_menu_transition)
	MAIN_MENU.name_position.x = MAIN_MENU.name_position.x_end + (10 - MAIN_MENU.name_position.x_end) * menuElapsedTime
	GHOST.x = 64 + (GHOST.x_main_menu - 64) * menuElapsedTime
	if TIMER.main_menu_transition == 0 then
		setActiveMode("gameplay")
	end
end

function transitionMainMenuToGameplayDrw()
	if TIMER.main_menu_transition > 0 then
		print("oOKY", MAIN_MENU.name_position.x, MAIN_MENU.name_position.y, COLORS.green)
		print("\n\n", MAIN_MENU.name_position.x + 8, MAIN_MENU.name_position.y, COLORS.green)

		for option in all(MAIN_MENU.options) do
			print(option.label .. "\n", COLORS.green)
		end

		print(chr(23), MAIN_MENU.name_position.x, MAIN_MENU.options[MAIN_MENU.current_option].select_arrow_y, COLORS.green)
	end
end