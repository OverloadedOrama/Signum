extends Control

onready var save_as_file_dialog = get_node('SaveAsFileDialog')
onready var open_file_dialog = get_node('OpenFileDialog')
onready var about_popup = get_node('AboutPopup')

const UNTITLED = 'Untitled'
var current_file = UNTITLED

func _ready():
	title_update()

func title_update():
	# This sets the title for the current title
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
			# Opens file select dialog
			open_file_dialog.popup()
		1:
			# Opens save file dialog
			save_as_file_dialog.popup()
		2:
			# Closes the program
			get_tree().quit()
		3:
			# Creates file
			new_file()
		4:
			# Saves file without changing the name
			save_file()

func help_item_pressed(id):
	match id:
		0:
			# Opens about popup
			about_popup.popup()
		1:
			# Opens the github page in the browser
			OS.shell_open('https://github.com/MintStudios/Signum')

# Creates a new file
func new_file():
	current_file = UNTITLED
	title_update()
	# Resets the text back to nothing
	$TextEdit.text = ''

# Opens an existing file
func open_file_selected(path):
	# Creates and reads the file
	var file = File.new()
	file.open(path, 1)
	# Makes the TextEdit text the same as the file's
	$TextEdit.text = file.get_as_text()
	# Closes to prevent memory leaks
	file.close()
	# Changes the title to the file path
	current_file = path
	title_update()

# Saves the file as a file type
func save_as_file_selected(path):
	# Creates and writes the file
	var file = File.new()
	file.open(path, 2)
	file.store_string($TextEdit.text)
	# Closes to prevent memory leaks
	file.close()
	# Changes the title to the file path
	current_file = path
	title_update()

func save_file():
	# Changes the title to the file path
	var path = current_file
	# Checks if the file hasn't been created. If it has, then it triggers the 'Save As` Dialog
	if path == UNTITLED:
		save_as_file_dialog.popup()
	# If the file exists, writes the file.
	else:
		var file = File.new()
		file.open(path, 2)
		file.store_string($TextEdit.text)
		# Closes to prevent memory leaks
		file.close()
		# Changes the title to the file path
		current_file = path
