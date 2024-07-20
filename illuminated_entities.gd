extends Node2D

var dict: Dictionary = {}

func has(id: int) -> bool:
	return dict.has(id)

func erase(id):
	dict.erase(id)

func add(id, entity):
	dict[id] = entity

