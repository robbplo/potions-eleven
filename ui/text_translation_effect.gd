@tool
# Having a class name is handy for picking the effect in the Inspector.
class_name RichTextTextTranslationEffect
extends RichTextEffect

signal new_char_visible
#var decrypted_font: Font = load("res://Visual assets/UI/Jerian_english-Regular.otf")

# To use this effect:
# - Enable BBCode on a RichTextLabel.
# - Register this effect on the label.
# - Use [typewriter param=2.0]hello[/typewriter] in text.
var bbcode = "typewriter"


func _process_custom_fx(char_fx):
	var speed:float = char_fx.env.get("speed", .1)
	var progress = int(char_fx.elapsed_time/speed)
	
	if char_fx.relative_index > progress:
		char_fx.color.a = 0.0
	
	if progress != char_fx.env.get("progress", -1):
		char_fx.env["progress"] = progress
		#emit_signal("new_char_visible", progress)
	
	return true
