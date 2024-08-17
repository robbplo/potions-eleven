##
## Global music mixer node
##
## TODO: rework so that only one song can play at a time, automatically stopping the rest
extends Node

var menu_song_volume: float:
	set(value):
		menu_song_volume = value
		$MenuSong.volume_db = linear_to_db(menu_song_volume)
var menu_riser_volume: float:
	set(value):
		menu_riser_volume = value
		$MenuRiser.volume_db = linear_to_db(menu_riser_volume)
var heist_song_global_volume: float:
	set(value):
		heist_song_global_volume = value
		$HeistSong/HeistMainSong.volume_db = linear_to_db(heist_song_global_volume)
var heist_song_danger_volume: float

func _ready():
	## Looping songs
	$MenuSong.finished.connect(play_menu_song)
	$HeistSong/HeistMainSong.finished.connect(play_heist_song)

func play_from_start(player: AudioStreamPlayer):
	player.seek(0.0)
	player.play(0.0)

## the menu song has a sample that introduced the song (called a riser). It plays for half a bar and then the song starts.
func play_menu_song_with_riser():
	play_from_start($MenuRiser)
	get_tree().create_timer(5.333).timeout.connect(play_menu_song)

func play_menu_song():
	play_from_start($MenuSong)

func stop_menu_song():
	$MenuSong.stop()

func play_heist_song():
	play_from_start($HeistSong/HeistMainSong)
	play_from_start($HeistSong/HeistShaker)
	play_from_start($HeistSong/HeistBubbleSynth)

func stop_heist_song():
	$HeistSong/HeistMainSong.stop()
	$HeistSong/HeistShaker.stop()
	$HeistSong/HeistBubbleSynth.stop()

func danger_fade_in():
	$HeistSong/AnimationPlayer.play("audio_fade")

func danger_fade_out():
	$HeistSong/AnimationPlayer.play_backwards("audio_fade")
