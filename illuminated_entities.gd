extends Node2D

## Global dictionary containing entities which are currently illuminated.
## Keys are instance ids, which you can find with `Node.get_instance_id()`.

var dict: Dictionary = {}

func has(id: int) -> bool:
	return dict.has(id)

func erase(id: int) -> void:
	dict.erase(id)

func add(id: int, entity: Node2D) -> void:
	dict[id] = entity

