extends Node

var menu_song_volume: float
var heist_song_global_volume: float
var heist_song_danger_volume: float

func _ready():
	## Looping songs
	$MenuSong.finished.connect(func(): $MenuSong.play())
	$HeistSong/HeistMainSong.finished.connect(play_heist_song)
	
func _process(delta):
	$MenuSong.volume_db = linear_to_db(menu_song_volume)
	$HeistSong/HeistMainSong.volume_db = linear_to_db(heist_song_global_volume)
	
## the menu song has a sample that introduced the song (called a riser). It plays for half a bar and then the song starts.
func play_menu_song_with_riser():
	$MenuRiser.play()
	get_tree().create_timer(5.333).timeout.connect(func(): $MenuSong.play())
	
func play_menu_song():
	$MenuSong.play()

func play_heist_song():
	$HeistSong/HeistMainSong.play()
	$HeistSong/HeistShaker.play()
	$HeistSong/HeistBubbleSynth.play()

func danger_fade_in():
	$HeistSong/AnimationPlayer.play("audio_fade")
	
func danger_fade_out():
	$HeistSong/AnimationPlayer.play_backwards("audio_fade")
