@tool
extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_entered.connect(_hover_on)
	mouse_exited.connect(_hover_off)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _hover_on():
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT).set_parallel(true)
	tween.tween_property($SubViewportContainer/SubViewport/Node3D, "undulate_amount_1", .4, 1)
	tween.tween_property($SubViewportContainer/SubViewport/Node3D, "undulate_amount_2", .6, 1)
	tween.tween_property($SubViewportContainer/SubViewport/Node3D, "undulate_amount_3", .7, 1)
	
func _hover_off():
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT).set_parallel(true)
	tween.tween_property($SubViewportContainer/SubViewport/Node3D, "undulate_amount_1", .1, 2)
	tween.tween_property($SubViewportContainer/SubViewport/Node3D, "undulate_amount_2", .1, 2)
	tween.tween_property($SubViewportContainer/SubViewport/Node3D, "undulate_amount_3", .1, 2)
