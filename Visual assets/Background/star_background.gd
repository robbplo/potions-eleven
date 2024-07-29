extends Control

@export var background_color : Color
var screen_size = DisplayServer.window_get_size()

func _ready():
	$ColorRect.color = background_color

func _process(_delta):
	_follow_position(get_global_mouse_position())
	$ColorRect.color = background_color

func _follow_position(target: Vector2):
	var origin = Vector2(screen_size/2)
	var direction = target - origin

	$Stars_1.position = direction/15
	$Stars_2.position = direction/22
	$Stars_3.position = direction/29
