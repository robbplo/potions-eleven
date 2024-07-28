extends Control

var screen_width: int = 2000
var tween_playing: bool


func _ready():
	pass 


func _process(_delta):
	#var target_distance = position.x / (1.0 + screen_width*MissionState.current_screen)
	#print(target_distance)
	if tween_playing == false:
			tween_playing = true
			#print("GOING")
			var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
			tween.tween_property(self, "position", Vector2(-screen_width * MissionState.current_screen, position.y) , .6)
			tween.tween_property(self, "tween_playing", false, 0)
			
			
