class_name PotionDetonationTeleportEffect extends Node2D

var timer := 1.0
var origin: PotionDetonationTeleportOrigin

func teleport():
	for node in ($Area2D as Area2D).get_overlapping_bodies():
		print(node)
		var relative_pos = to_local(node.global_position)
		node.global_position = origin.global_position + relative_pos

	for node in origin.get_overlapping_bodies():
		print(node)
		var relative_pos = origin.to_local(node.global_position)
		node.global_position = global_position + relative_pos

	queue_free()
	origin.queue_free()
