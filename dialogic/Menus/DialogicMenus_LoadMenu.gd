extends Control

var SaveSlot = preload("res://dialogic/Menus/DialogicMenu_SaveSlot.tscn")

onready var SaveSlotContainer = $Scroll/SaveSlots
onready var MenusContainer = get_parent().get_parent().get_parent()

var current_selected_slot

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
	for save in Dialogic.get_save_names_array():
		var x = SaveSlot.instance()
		x.set_name(save)
		SaveSlotContainer.add_child(x)
		x.connect("pressed", self, "save_slot_pressed")
		x.connect("delete_requested", self , "save_slot_delete_request")

# will load the currently selected slot
func load_slot() -> void:
	MenusContainer.get_node("MenuMusic").playing = false
	MenusContainer.resume_game()
	var dialog = Dialogic.resume_from_save(current_selected_slot)
	dialog.layer = 0
	MenusContainer.add_game_node(dialog)
	hide()

################################################################################
##								PRIVATE
################################################################################

func _ready() -> void:
	hide()

# will load the slot @save_slot_name or show a warning
func save_slot_pressed(save_slot_name:String) -> void:
	current_selected_slot = save_slot_name
	if MenusContainer.is_game_playing() and not get_parent().current_saved:
		MenusContainer.LooseWarning.open(self, "load_slot")
	else:
		load_slot()

# will show a warning about deleting saves
func save_slot_delete_request(save_slot_name:String) -> void:
	current_selected_slot = save_slot_name
	MenusContainer.LooseSaveWarning.open(self, "delete_save_slot")

# will delete the currently selected save slot
func delete_save_slot() -> void:
	Dialogic.erase_save(current_selected_slot)
	update_saves()
