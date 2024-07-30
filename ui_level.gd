extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicMixer.heist_song_global_volume = 1.0
	MusicMixer.play_heist_song()
	$Star_background.background_color = Color("160e1b")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
