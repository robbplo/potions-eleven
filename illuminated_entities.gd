extends Node2D

var dict: Dictionary = {}

func has(node: Node2D) -> bool:
	return dict.has(node.get_instance_id())

func erase(id):
	dict.erase(id)

func add(id, entity):
	dict[id] = entity

