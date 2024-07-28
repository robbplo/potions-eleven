extends TextureButton

## 0: MAIN_MENU, 1: MISSION_SELECT, 2: CHARACTER_SELECT, 3: GAME_SCREEN
@export var go_to_screen: int

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_entered.connect(_hover_tween)
	mouse_exited.connect(_stopped_hover_tween)
	button_down.connect(_goto_screen)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _hover_tween():
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(0.65, 0.65), 0.3)

## Everything that happens when the mouse leaves the character_icon's bounding box
func _stopped_hover_tween():
	if button_pressed == false:
		var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		tween.tween_property(self, "scale", Vector2(0.6, 0.6), 0.6)

func _goto_screen():
	get_tree().change_scene_to_file("res://ui_level.tscn")
