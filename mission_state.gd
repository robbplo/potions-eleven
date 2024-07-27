extends TextureButton

var selected_mission: String :set =set_mission
var selected_character: String :set =set_character
var is_pressed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var temp_pressed = button_pressed
	if temp_pressed != is_pressed:
		_button_changed()
		is_pressed = temp_pressed

func set_mission(mission_name: String):
	selected_mission = mission_name
	
func set_character(character_name: String):
	selected_character = character_name
	
func _button_changed():
	pass
