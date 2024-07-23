extends Node2D

var screen_size = DisplayServer.window_get_size()

func _process(delta):
	_follow_position(get_global_mouse_position())

func _follow_position(target: Vector2):
	var origin = Vector2(screen_size/2)
	var direction = target - origin

	$Stars1.position = direction/15
	$Stars2.position = direction/22
	$Stars3.position = direction/29
