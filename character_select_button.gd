@icon("res://Visual assets/Sprites/Character Icons/GORMENGHAST.png")
extends Panel

## This script controls all the animations that correspond to a character selection button in the character select screen. 
## The label uses the mono spaced font type in BBcode to set the encrypted version of the font. 

@onready var character_icon: TextureButton = $Icon_background/Character_icon
@onready var name_label :RichTextLabel = $Character_name

var encrypted_text: String
var decrypted_text: String
var animation_speed: float = 0.15

func _ready():
	## Take the text from the textlabel and add the right BBcode to align to center and use the encrypted font
	## !! Do not use BBcode [code] in the text field in the Character_name node. !!
	decrypted_text = "[center]" + name_label.text + "[/center]"
	encrypted_text = "[center][code]" + name_label.text + "[/code][/center]"
	character_icon.mouse_entered.connect(_hover_tween)
	character_icon.mouse_exited.connect(_stopped_hover_tween)
	
	## some basic setup for good measure.
	name_label.text = encrypted_text
	name_label.visible_ratio = 1
	name_label.bbcode_enabled = true
	
	print (decrypted_text)
	print (encrypted_text)
	pass

## Everything that happens while the mouse hovers over the character_icon's bounding box
func _hover_tween():
	_decrypt_animation()
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property($Icon_background/Character_icon, "scale", Vector2(0.23, 0.23), 0.3)

## Everything that happens when the mouse leaves the character_icon's bounding box
func _stopped_hover_tween():
	_encrypt_animation()
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_property($Icon_background/Character_icon, "scale", Vector2(0.2, 0.2), 0.6)

## 'backspace' the letters until gone, set the font to the encrypted version and then type out the letters again.
func _decrypt_animation():
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property($Character_name, "visible_ratio", 0.0, animation_speed)
	tween.tween_callback(_set_decrypted)
	tween.tween_property($Character_name, "visible_ratio", 1.0, animation_speed)

## 'backspace' the letters until gone, set the font to the decrypted version and then type out the letters again.
func _encrypt_animation():
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property($Character_name, "visible_ratio", 0.0, animation_speed)
	tween.tween_callback(_set_encrypted)
	tween.tween_property($Character_name, "visible_ratio", 1.0, animation_speed)

func _set_decrypted():
	name_label.text = decrypted_text

func _set_encrypted():
	name_label.text = encrypted_text
