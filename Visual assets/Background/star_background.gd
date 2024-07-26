@tool
extends Control

@export var Background_color : Color
var screen_size = DisplayServer.window_get_size()

func _ready():
	$ColorRect.color = Background_color

func _process(delta):
	_follow_position(get_global_mouse_position())
	$ColorRect.color = Background_color

func _follow_position(target: Vector2):
	var origin = Vector2(screen_size/2)
	var direction = target - origin

	$Stars_1.position = direction/15
	$Stars_2.position = direction/22
	$Stars_3.position = direction/29
