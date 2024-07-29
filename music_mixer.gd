extends Node

var menu_song_volume: float
var heist_song_global_volume: float

func _ready():
	## Looping songs
	$MenuSong.finished.connect(func(): $MenuSong.play())
	$HeistSong/HeistMainSong.finished.connect(play_heist_song_loop)
	
func _process(_delta):
	$MenuSong.volume_db = linear_to_db(menu_song_volume)

## the menu song has a sample that introduced the song (called a riser). It plays for half a bar and then the song starts.
func play_menu_song_with_riser():
	$MenuRiser.play()
	get_tree().create_timer(5.333).timeout.connect(func(): $MenuSong.play())

func play_menu_song():
	$MenuSong.play()

func play_heist_song_intro():
	$HeistSong/HeistIntroArp.play()
	$HeistSong/HeistIntroBass.play()
	$HeistSong/HeistIntroDrums.play()
	$HeistSong/HeistIntroArp.finished.connect(play_heist_song_loop)
	
func play_heist_song_loop():
	$HeistSong/HeistMainSong.play()
	$HeistSong/HeistShaker.play()
	$HeistSong/HeistRide.play()
	$HeistSong/HeistBubbleSynth.play()
	$HeistSong/HeistMelodySynth.play()
	
