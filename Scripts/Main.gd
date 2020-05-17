extends Control

onready var save_as_file_dialog = get_node('SaveAsFileDialog')
onready var open_file_dialog = get_node('OpenFileDialog')
onready var about_popup = get_node('AboutPopup')

const UNTITLED = 'Untitled'
var current_file = UNTITLED

func _ready():
	title_update()

func title_update():
	OS.set_window_title('Signum - ' + current_file)

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

func file_item_pressed(id):
	match id:
		0:
			open_file_dialog.popup()
		1:
			save_as_file_dialog.popup()
		2:
			get_tree().quit()
		3:
			new_file()
		4:
			save_file()

func help_item_pressed(id):
	match id:
		0:
			about_popup.popup()
		1:
			OS.shell_open('https://github.com/MintStudios/Signum')



func new_file():
	current_file = UNTITLED
	title_update()
	$TextEdit.text = ''

func open_file_selected(path):
	var file = File.new()
	file.open(path, 1)
	$TextEdit.text = file.get_as_text()
	file.close()
	current_file = path
	title_update()

func save_as_file_selected(path):
	var file = File.new()
	file.open(path, 2)
	file.store_string($TextEdit.text)
	file.close()
	current_file = path
	title_update()

func save_file():
	var path = current_file
	if path == UNTITLED:
		save_as_file_dialog.popup()
	else:
		var file = File.new()
		file.open(path, 2)
		file.store_string($TextEdit.text)
		file.close()
		current_file = path
