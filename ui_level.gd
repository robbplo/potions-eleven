extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	_load_animation()
	
	MusicMixer.heist_song_global_volume = 1.0
	MusicMixer.play_heist_song()
	MusicMixer.heist_song_danger_volume = 0.0
	$Star_background.background_color = Color("160e1b")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _load_animation():
	$CircleOverlay.scale = Vector2(5.0, 5.0)
	var tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN)
	tween.tween_property($CircleOverlay, "scale", Vector2(0.0, 0.0) , 1)
