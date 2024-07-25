extends RichTextLabel

var encrypted_text: String
var decrypted_text: String

func _ready():
	decrypted_text = text
	encrypted_text = "[code]" + text + "[/code]"
	mouse_entered.connect(_decrypt_animation)
	mouse_exited.connect(_encrypt_animation)
	
	text = encrypted_text

func _process(delta):
	pass

func _decrypt_animation():
	print ("yes")
	text = decrypted_text

	
func _encrypt_animation():
	print ("no")
	text = encrypted_text
