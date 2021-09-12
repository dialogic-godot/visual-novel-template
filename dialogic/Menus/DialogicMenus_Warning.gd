extends Control

var caller
var ok_func
var back_func

################################################################################
##								PUBLIC
################################################################################

# will open this warning
func open(called_by: Object, ok_func_name:String, back_func_name:String = "") -> void:
	caller = called_by
	ok_func = ok_func_name
	back_func = back_func_name
	show()
	$WarningPanel/VBoxContainer/HBoxContainer/Ok.grab_focus()

################################################################################
##								PRIVATE
################################################################################

 # will call the ok_func on the caller 
func _on_Ok_pressed():
	hide()
	caller.call(ok_func)

# will call the back_func on the caller
func _on_Back_pressed():
	hide()
	if back_func:
		caller.call(back_func)
