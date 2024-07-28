## Global dictionary containing entities which are currently illuminated.
## Keys are instance ids, which you can find with `Node.get_instance_id()`.
## Keeps a separate list of entities which are inside a 'shadow' raycast.

extends Node2D

var raycast_nodes: Array[RadialRaycast] = []
## Colliders in current frame. Values are raycast query results.
var colliders := {}
## Which raycasts collided with each collider. Each key has a list of references to RadialRaycast.
var collider_raycasts := {}

func _physics_process(_delta: float) -> void:
	colliders = {}
	collider_raycasts = {}
	for raycast in raycast_nodes:
		_add_results_from_raycast(raycast)
	_send_raycast_signals()

func register_raycast(raycast: RadialRaycast) -> void:
	raycast_nodes.append(raycast)

func unregister_raycast(raycast: RadialRaycast) -> void:
	raycast_nodes.remove_at(raycast_nodes.find(raycast))

## Returns true if the instance id is illuminated and not inside a shadow.
func is_illuminated(id: int) -> bool:
	return colliders.has(id)

func _add_results_from_raycast(raycast: RadialRaycast) -> void:
	for result in raycast.query_colliders():
		var id: int = result["collider_id"]
		var existing_collider: Dictionary = colliders.get_or_add(id, result)
		if not existing_collider["illuminated"] and result["illuminated"]:
			colliders[id]["illuminated"] = true

		if collider_raycasts.has(id):
			collider_raycasts[id].append(raycast)
		else:
			collider_raycasts[id] = [raycast]

func _send_raycast_signals():
	for collider_id in collider_raycasts:
		var result := colliders[collider_id] as Dictionary
		if not result["illuminated"]:
			continue
		for raycast_node in collider_raycasts[collider_id]:
			(raycast_node as RadialRaycast).entity_seen.emit(result["collider"])
