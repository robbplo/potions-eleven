extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_entered.connect(_hover_tween)
	mouse_exited.connect(_stopped_hover_tween)

func _hover_tween():
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(0.65, 0.65), 0.3)

## Everything that happens when the mouse leaves the character_icon's bounding box
func _stopped_hover_tween():
	if button_pressed == false:
		var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		tween.tween_property(self, "scale", Vector2(0.6, 0.6), 0.6)

