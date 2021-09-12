extends Control

# what menu is currently shown
var current_menu = null


################################################################################
##								PUBLIC
################################################################################

func open_main_menu():
	hide_current()
	current_menu = null
	hide()
	get_parent().get_node("MainMenu").open()

func open_save_menu():
	if current_menu == $MenuContent/SaveMenu: return
	check_resume()
	show()
	hide_current()
	$Buttons/MenuTitle.text = "Save Menu"
	$Buttons/SaveMenu_Button.grab_focus()
	current_menu = $MenuContent/SaveMenu
	current_menu.open()

func open_load_menu():
	if current_menu == $MenuContent/LoadMenu: return
	check_resume()
	show()
	hide_current()
	$Buttons/MenuTitle.text = "Load Menu"
	$Buttons/LoadMenu_Button.grab_focus()
	current_menu = $MenuContent/LoadMenu
	current_menu.open()

func open_settings_menu():
	if current_menu == $MenuContent/SettingsMenu: return
	check_resume()
	show()
	hide_current()
	$Buttons/MenuTitle.text = "Settings"
	$Buttons/Settings_Button.grab_focus()
	current_menu = $MenuContent/SettingsMenu
	current_menu.open()

func open_about_menu():
	if current_menu == $MenuContent/AboutMenu: return
	check_resume()
	show()
	hide_current()
	$Buttons/MenuTitle.text = "About"
	$Buttons/About_Button.grab_focus()
	current_menu = $MenuContent/AboutMenu
	current_menu.open()

func hide_current():
	if current_menu: current_menu.hide()

# will show or hide the Resume_Button based on whether a game is currently playing
func check_resume():
	$Buttons/ResumeGame_Button.visible = get_parent().is_game_playing()
	$Buttons/HSeparator.visible = get_parent().is_game_playing()

################################################################################
##								PRIVATE
################################################################################

func _ready():
	hide()

## SIGNALS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
func _on_MainMenu_Button_pressed():
	if get_parent().is_game_playing() and not get_parent().current_saved:
		get_parent().LooseWarning.open(self, "open_main_menu")
	else:
		open_main_menu()

func _on_SaveMenu_Button_pressed():
	open_save_menu()

func _on_LoadMenu_Button_pressed():
	open_load_menu()

func _on_Settings_Button_pressed():
	open_settings_menu()

func _on_About_Button_pressed():
	open_about_menu()

func _on_Quit_Button_pressed():
	if get_parent().is_game_playing() and not get_parent().current_saved:
		get_parent().LooseWarning.open(get_tree(), "quit")
	else:
		get_tree().call("quit")

func _on_ResumeGame_Button_pressed():
	hide_current()
	current_menu = null
	hide()
	get_parent().resume_game()
