extends LineEdit

func _process(delta):
	self.grab_focus()

func _ready():
	self.text_changed.connect(text_to_upper)
	self.text_submitted.connect(name_entered)

func text_to_upper(new_text):
	text = new_text.to_upper()
	for letter in text:
		if not letter in "ABCDEFGHIJKLMNOPQRSTUVWXYZ":
			text = text.replace(letter,"")
	self.caret_column = text.length()

func name_entered(name):
	if name.length() == 0:
		self.grab_focus()
		return
	Gamemanager.fullname = name
	Gamemanager.currentname = name
	get_tree().change_scene_to_file("res://Scenes/root.tscn")
	
	
