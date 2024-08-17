## Raycast used for light and shadow.
## NOTE: only the player is added to IlluminatedEntities

class_name RadialRaycast extends Node2D

const DEBUG_RAY_COLOR = Color.GRAY
const DEBUG_RAY_COLLIDE_COLOR = Color.RED

## When a body entered the radius while illuminated
signal entity_seen(body: CharacterBody2D)

## Amount of rays to project across radial_angle.
@export var ray_count: int = 60
## Angle where rays will be cast.
@export var radial_angle: float = 360.0
## Range where illuminated entities can be seen.
@export var ray_range: float
## Range where raycast will mark enemies as illuminated.
@export var illumination_range: float
## If set to true, this raycast will add entities to the shadow list.
## Otherwise, entities are added to the illumination list.
@export var is_shadow := false

@onready var space_state = get_world_2d().direct_space_state

## Dictionary containing rays which are drawn if "Visible collision shapes" is true.
var debug_rays := {}
## Colliders in current frame. Keys are instance ids.
var colliders: Array[Dictionary] = []

func _ready() -> void:
	IlluminatedEntities.register_raycast(self)
	for_each_ray(func (ray_angle): debug_rays[ray_angle] = [Vector2.ZERO, Vector2.ZERO, Color.WHITE])

func _exit_tree() -> void:
	IlluminatedEntities.unregister_raycast(self)

func query_colliders() -> Array[Dictionary]:
	colliders = []
	for_each_ray(cast_ray)
	return colliders

## Draw debug lines
func _draw() -> void:
	if get_tree().debug_collisions_hint:
		for ray in debug_rays.values():
			draw_line(to_local(ray[0]), to_local(ray[1]), ray[2])

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
	var start := self.global_position
	var end := start + Vector2(ray_range, 0).rotated(global_angle)
	var query := PhysicsRayQueryParameters2D.create(start, end)
	if get_parent() is PhysicsBody2D:
		query.exclude = [get_parent().get_rid()]
	query.hit_from_inside = true
	var result := space_state.intersect_ray(query)
	var debug_ray := []

	if get_tree().debug_collisions_hint:
		queue_redraw()
		debug_ray = [start, end, DEBUG_RAY_COLOR]

	if not result.is_empty():
		var collider := result["collider"] as Node2D

		if get_tree().debug_collisions_hint:
			debug_ray[1] = result["position"]

		if collider is CharacterBody2D:
			# add illuminated flag for future reference
			result["illuminated"] = _collision_result_illuminates(result)
			colliders.append(result)
			# show debug line when colliding with character
			if get_tree().debug_collisions_hint:
				debug_ray[2] = DEBUG_RAY_COLLIDE_COLOR

	if get_tree().debug_collisions_hint:
		debug_rays[ray_angle] = debug_ray

## Check if the collision is within the illumination range
func _collision_result_illuminates(result: Dictionary) -> bool:
	return self.global_position.distance_to(result["position"]) <= illumination_range
