extends Node2D

## Global dictionary containing entities which are currently illuminated.
## Keys are instance ids, which you can find with `Node.get_instance_id()`.
## Keeps a separate list of entities which are inside a 'shadow' raycast.

var dict := {}
var shadow_dict := {}

## Returns true if the instance id is illuminated and not inside a shadow.
func is_illuminated(id: int) -> bool:
	return dict.has(id) and not shadow_dict.has(id)

func add(id: int, entity: Node2D, is_shadow: bool = false) -> void:
	if is_shadow:
		shadow_dict[id] = entity
	else:
		dict[id] = entity

func erase(id: int, is_shadow: bool) -> void:
	if is_shadow:
		shadow_dict.erase(id)
	else:
		shadow_dict.erase(id)
