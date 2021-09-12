extends Control

export(String) var starting_timeline = "1. Introduction"

################################################################################
##								PUBLIC
################################################################################

func open():
	show()
	$Buttons/NewGame_Button.grab_focus()

################################################################################
##								PRIVATE
################################################################################

func _ready():
	open()

func _on_NewGame_Button_pressed():
	get_parent().get_node("MenuMusic").playing = false
	var dialog = Dialogic.start(starting_timeline)
	dialog.layer = 0
	get_parent().add_game_node(dialog)

func _on_LoadGame_Button_pressed():
	hide()
	get_parent().get_node("SubMenus").open_load_menu()

func _on_Settings_Button_pressed():
	hide()
	get_parent().get_node("SubMenus").open_settings_menu()

func _on_About_Button_pressed():
	hide()
	get_parent().get_node("SubMenus").open_about_menu()

func _on_Quit_Button_pressed():
	get_tree().quit()
