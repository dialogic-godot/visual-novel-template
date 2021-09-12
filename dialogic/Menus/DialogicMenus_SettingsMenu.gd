extends Control


################################################################################
##								PUBLIC
################################################################################

func open() -> void:
	show()
	$HBox/VBox/OverallVolume/Slider.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))

################################################################################
##								PRIVATE
################################################################################

func _ready() -> void:
	hide()


func _on_Slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value))


func _on_DisplaySelect_item_selected(index):
	if index == 0:
		OS.window_fullscreen = false
	if index == 1:
		OS.window_fullscreen = true
