extends Node

var volume_music: float : set = set_volume_music
var volume_sfx: float : set = set_volume_sfx

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func  set_volume_music(volume: float):
	volume_music = volume
	
func  set_volume_sfx(volume: float):
	volume_sfx = volume
	
