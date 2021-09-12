extends Control

signal pressed(slot_name)
signal delete_requested(slot_name)

################################################################################
##								PUBLIC
################################################################################

# sets the text of the save slot and tries to find the thumbnail
func set_name(text:String) -> void:
	# set the text
	$Label.text = text
	
	# load the thumbnail (if possible)
	var file = File.new()
	if file.open("user://dialogic/"+text+"/thumbnail.png", File.READ) == OK:
		var buffer = file.get_buffer(file.get_len())
		file.close()

		var image = Image.new()
		image.load_png_from_buffer(buffer)

		var image_texture = ImageTexture.new()
		image_texture.create_from_image(image)

		$Panel/Image.texture = image_texture

################################################################################
##								PRIVATE
################################################################################

# manages left and right click -> emits signals
func _on_SaveSlot_gui_input(event:InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		emit_signal("pressed", $Label.text)
	
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT:
		emit_signal("delete_requested", $Label.text)

# plays hover animation
func _on_SaveSlot_mouse_entered() -> void:
	$hoveranims.play("hover")

# plays unhover animation
func _on_SaveSlot_mouse_exited() -> void:
	$hoveranims.play_backwards("hover")
