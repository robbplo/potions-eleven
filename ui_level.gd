extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicMixer.heist_song_global_volume = 1.0
	MusicMixer.play_heist_song()
	$Star_background.background_color = Color("160e1b")

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_ESCAPE:
		get_tree().paused = !get_tree().paused
	if event is InputEventKey and event.keycode == KEY_ENTER:
		get_tree().paused = false
