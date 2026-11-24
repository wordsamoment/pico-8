function mainMenuDraw()
	print("oOKY", MAIN_MENU.name_position.x, MAIN_MENU.name_position.y, COLORS.green)
	print("\n\n", MAIN_MENU.name_position.x + 8, MAIN_MENU.name_position.y, COLORS.green)

	for option in all(MAIN_MENU.options) do
		print(option.label .. "\n", COLORS.green)
	end

	print(chr(23), MAIN_MENU.name_position.x, MAIN_MENU.options[MAIN_MENU.current_option].select_arrow_y, COLORS.green)
end

function mainMenuNavigateOptions()
	if btnp(⬇️) then
		if (MAIN_MENU.current_option + 1 > #MAIN_MENU.options) then
			MAIN_MENU.current_option = 1
		else
			MAIN_MENU.current_option += 1
		end
	end

	if btnp(⬆️) then
		if (MAIN_MENU.current_option - 1 == 0) then
			MAIN_MENU.current_option = #MAIN_MENU.options
		else
			MAIN_MENU.current_option -= 1
		end
	end

	-- print(MAIN_MENU.current_option, 80, 100, COLORS.green)
	-- end
end

function mainMenuExecuteSelectedOption()
	if btnp(5) then
		if MAIN_MENU.current_option == 1 then
			setActiveMode("main_menu_to_gameplay")
			TIMER.main_menu_transition = DURATION.main_menu_transition
		end
		-- if MAIN_MENU.current_option == "high_scores" then
		-- 	-- show high scores
		-- end
		if MAIN_MENU.current_option == 3 then
			cls(COLORS.black)
			stop()
		end
	end
end
-- Centered rects
-- w, h = 80, 50
-- rect(64 - (w / 2), 64 - (h / 2), 64 + (w / 2), 64 + (h / 2), COLORS.green)