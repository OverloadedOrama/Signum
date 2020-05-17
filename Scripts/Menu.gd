extends HBoxContainer

onready var file_menu = get_node('FileMenu')
onready var help_menu = get_node('HelpMenu')

# File Menu IDs:
# Open File = 0
# Save As File = 1
# Save File = 4
# Quit = 2
# New File = 3
# ----------------
# Help Menu IDs:
# About = 0
# Github Page = 1

func _ready():	
	file_menu.get_popup().set_item_shortcut(0, set_shortcut(KEY_O), true)
	file_menu.get_popup().set_item_shortcut(1, set_shortcut(KEY_E), true)
	file_menu.get_popup().set_item_shortcut(4, set_shortcut(KEY_Q), true)
	file_menu.get_popup().set_item_shortcut(2, set_shortcut(KEY_N), true)
	file_menu.get_popup().set_item_shortcut(3, set_shortcut(KEY_S), true)
	
	file_menu.get_popup().connect('id_pressed', get_parent(), 'file_item_pressed')
	help_menu.get_popup().connect('id_pressed', get_parent(), 'help_item_pressed')

func set_shortcut(key):
	var shortcut = ShortCut.new()
	var inputeventkey = InputEventKey.new()
	inputeventkey.set_scancode(key)
	inputeventkey.control = true
	shortcut.set_shortcut(inputeventkey)
	return shortcut
