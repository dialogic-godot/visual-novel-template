extends Control

var save_name = ""
var save_idx = 0
var SaveSlot = preload("res://dialogic/Menus/DialogicMenu_SaveSlot.tscn")

onready var SaveSlotContainer = $Scroll/SaveSlots
onready var MenusContainer = get_parent().get_parent().get_parent()

################################################################################
##								PUBLIC
################################################################################

func open() -> void:
	show()
	update_saves()

# will reload and add saves slots
func update_saves() -> void:
	for child in SaveSlotContainer.get_children():
		child.queue_free()
	save_name = ""
	for save in Dialogic.get_save_names_array():
		var x = SaveSlot.instance()
		x.set_name(save)
		SaveSlotContainer.add_child(x)
		save_name = save.trim_prefix("Save ")
		if save_name.is_valid_integer():
			save_idx = int(save_name) +1
		x.connect("pressed", self, "on_save_slot_pressed")
	if Dialogic.has_current_dialog_node():
		var x = SaveSlot.instance()
		x.set_name("NEW SAVE SLOT")
		SaveSlotContainer.add_child(x)
		x.connect("pressed", self, "new_save_slot")

# will save the current state to a new save slot
func new_save_slot(slot_name:String) -> void:
	slot_name = 'Save '+str(save_idx)
	Dialogic.save_current_info(slot_name)
	MenusContainer.saved_image.save_png("user://dialogic/"+slot_name+"/thumbnail.png")
	update_saves()
	MenusContainer.current_saved = true


################################################################################
##								PRIVATE
################################################################################

func _ready():
	hide()

# will overwrite the selected save
func on_save_slot_pressed(slot_name:String) -> void:
	if not Dialogic.has_current_dialog_node(): return
	
	Dialogic.save_current_info(slot_name)
	
	MenusContainer.saved_image.save_png("user://dialogic/"+slot_name+"/thumbnail.png")
	update_saves()
	MenusContainer.current_saved = true
