@tool
extends TextureButton

@export var button_image: Texture2D
@export var mission_name: String

@onready var button_text: RichTextLabel = $Mission_name

var button_is_pressed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	button_text.text = mission_name
	button_text.text = "[center]" + button_text.text + "[/center]"
	texture_normal = button_image

	mouse_entered.connect(_hover_tween)
	mouse_exited.connect(_stopped_hover_tween)
	button_down.connect(SfxMixer.click_2)


func _process(_delta):
	var temp_pressed = button_pressed
	if temp_pressed != button_is_pressed:
		_button_changed()
		button_is_pressed = temp_pressed


## Everything that happens while the mouse hovers over the character_icon's bounding box
func _hover_tween():
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(0.65, 0.65), 0.3)

## Everything that happens when the mouse leaves the character_icon's bounding box
func _stopped_hover_tween():
	if button_pressed == false:
		var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		tween.tween_property(self, "scale", Vector2(0.6, 0.6), 0.6)

func _button_changed():
	if button_pressed == true:
		scale = Vector2(0.65, 0.65)
		MissionState.set_mission(mission_name)
	else:
		_stopped_hover_tween()
