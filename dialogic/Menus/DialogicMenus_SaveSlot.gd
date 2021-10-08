extends Control

signal pressed(slot_name)
signal delete_requested(slot_name)


################################################################################
##								PUBLIC
################################################################################

# sets the text of the save slot and tries to find the thumbnail
func set_name(text:String, enable_delete = true) -> void:
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

		$Panel/Border/Image.texture = image_texture
	
	if not enable_delete:
		$Delete.hide()

################################################################################
##								PRIVATE
################################################################################


# manages left and right click -> emits signals
func _on_SaveSlot_gui_input(event:InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		emit_signal("pressed", $Label.text)


# plays hover animation
func _on_SaveSlot_mouse_entered() -> void:
	$hoveranims.play("hover")
	$deletehover.play("hover")

# plays unhover animation
func _on_SaveSlot_mouse_exited() -> void:
	$hoveranims.play_backwards("hover")
	$deletehover.play_backwards("hover")


func _on_Delete_mouse_entered():
	$Delete/Tween.interpolate_property($Panel/Border/Image, "self_modulate", null, Color(0.855469, 0.590954, 0.357559), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Delete/Tween.start()
	$deletehover.stop()


func _on_Delete_mouse_exited():
	$Delete/Tween.interpolate_property($Panel/Border/Image, "self_modulate", null, Color(1, 1, 1), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Delete/Tween.start()
	


func _on_Delete_pressed():
	emit_signal('delete_requested', $Label.text)
