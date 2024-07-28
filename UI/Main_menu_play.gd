extends TextureButton

## 0: MAIN_MENU, 1: MISSION_SELECT, 2: CHARACTER_SELECT, 3: GAME_SCREEN
@export var go_to_screen: int

@export_range(0.01, 1) var animation_speed: float = 0.2

var encrypted_text: String
var decrypted_text: String
var text_mode: String = "encrypted"

@onready var button_text = $Play
@onready var text = $Play.text

func _ready():
	decrypted_text = text
	encrypted_text = "[code]" + text + "[/code]"
	
	button_down.connect(_goto_screen)
	mouse_entered.connect(_decrypt_animation)
	mouse_exited.connect(_encrypt_animation)
	
	text = encrypted_text
	button_text.visible_ratio = 1
	button_text.bbcode_enabled = true

func _process(delta):
	pass

func _decrypt_animation():
	text_mode = "decrypted"
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(self, "visible_ratio", 0.0, animation_speed)
	tween.tween_callback(_set_decrypted)
	tween.tween_property(self, "visible_ratio", 1.0, animation_speed)
	
func _encrypt_animation():
	text_mode = "encrypted"
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(self, "visible_ratio", 0.0, animation_speed)
	tween.tween_callback(_set_encrypted)
	tween.tween_property(self, "visible_ratio", 1.0, animation_speed)

func _set_decrypted():
	text = decrypted_text

func _set_encrypted():
	text = encrypted_text

func _goto_screen():
	MissionState.set_current_screen(go_to_screen)
