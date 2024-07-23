extends Node2D

signal entity_seen(body: CharacterBody2D)
signal entity_lost(body: CharacterBody2D)

## Amount of rays to project across radial_angle.
@export var ray_count: int = 60
## Angle where rays will be cast.
@export var radial_angle: float = 360.0
## Range where illuminated entities can be seen.
@export var ray_range: float
## Range where raycast will mark enemies as illuminated.
@export var illumination_range: float

@onready var space_state = get_world_2d().direct_space_state
## Dictionary containing rays which are drawn if "Visible collision shapes" is true.
var debug_rays := {}
## Colliders in current frame. Keys are instance ids.
var colliders := {}
## Colliders in previous frame.
var delta_colliders := {}

func _ready() -> void:
	for_each_ray(func (ray_angle): debug_rays[ray_angle] = [Vector2.ZERO, Vector2.ZERO, Color.GRAY])

## Draw debug lines
func _draw() -> void:
	if get_tree().debug_collisions_hint:
		for ray in debug_rays.values():
			draw_line(to_local(ray[0]), to_local(ray[1]), ray[2])

func _physics_process(_delta: float) -> void:
	colliders = {}
	for_each_ray(cast_ray)
	_set_illuminated_entities()
	delta_colliders = colliders

## Call a function for every ray.
func for_each_ray(function: Callable):
	var angle_per_ray = radial_angle / ray_count
	for i in ray_count:
		var ray_angle = angle_per_ray * i
		ray_angle -= radial_angle / 2
		function.call(ray_angle)

## Raycast to angle. Collisions are added to the colliders dict
func cast_ray(ray_angle: float):
	var global_angle := deg_to_rad(ray_angle + global_rotation_degrees)
	var a := self.global_position
	var b := (a + Vector2(ray_range, 0).rotated(global_angle))
	var query := PhysicsRayQueryParameters2D.create(a, b)
	var result := space_state.intersect_ray(query)

	if get_tree().debug_collisions_hint:
		debug_rays[ray_angle][0] = a
		debug_rays[ray_angle][1] = b
		debug_rays[ray_angle][2] = Color.GRAY
		queue_redraw()

	if not result.is_empty():
		if get_tree().debug_collisions_hint:
			debug_rays[ray_angle][1] = result["position"]
		var collider := result["collider"] as Node2D
		if collider is CharacterBody2D:
			# add illuminated flag for future reference
			result["illuminated"] = _collision_result_illuminates(result)
			# add collider if not already present
			if not colliders.has(result["collider_id"]):
				colliders[result["collider_id"]] = result
			# show red debug line when colliding with character
			if get_tree().debug_collisions_hint:
				debug_rays[ray_angle][2] = Color.RED

## Check if the collision is within the illumination range
func _collision_result_illuminates(result: Dictionary) -> bool:
	return global_position.distance_to(result["position"]) <= illumination_range

## Update the illuminated entities singleton
func _set_illuminated_entities() -> void:
	# Check results from previous frame for illuminated colliders.
	# If they are not present in the current frame, remove from list.
	for collider_id in delta_colliders:
		if not colliders.has(collider_id):
			entity_lost.emit(delta_colliders[collider_id])
			if delta_colliders[collider_id]["illuminated"]:
				IlluminatedEntities.erase(collider_id)

	# Add any illuminated colliders from the current frame to the list.
	# If not in illumination range, entity is seen if already illuminated.
	for collider_id in colliders:
		var result = colliders[collider_id]
		if result["illuminated"]:
			IlluminatedEntities.add(collider_id, result["collider"])
			entity_seen.emit(result["collider"])
		elif IlluminatedEntities.has(collider_id):
			entity_seen.emit(result["collider"])

