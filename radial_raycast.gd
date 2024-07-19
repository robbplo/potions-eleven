extends Node2D

@export var ray_count: int = 60
@export var radial_angle: float = 360.0
@export var ray_range: float
@export var illumintes_entites: bool = true

var debug_rays := {}
var delta_colliders := {}

func _ready() -> void:
	for_rays(func (ray_angle): debug_rays[ray_angle] = [Vector2.ZERO, Vector2.ZERO, Color.GRAY])

func _draw() -> void:
	if get_tree().debug_collisions_hint:
		for ray in debug_rays.values():
			draw_line(to_local(ray[0]), to_local(ray[1]), ray[2])

func _physics_process(_delta: float) -> void:
	var space_state = get_world_2d().direct_space_state
	var colliders := {}
	var cast_ray = func (ray_angle):
		var global_angle = deg_to_rad(ray_angle + global_rotation_degrees)
		var a = self.global_position
		var b = (a + Vector2(ray_range, 0).rotated(global_angle))
		var query = PhysicsRayQueryParameters2D.create(a, b)
		var result := space_state.intersect_ray(query)

		if get_tree().debug_collisions_hint:
			debug_rays[ray_angle][0] = a

		if not result.is_empty():
			if get_tree().debug_collisions_hint:
				debug_rays[ray_angle][1] = result["position"]
			var collider = result["collider"]
			if collider is CharacterBody2D:
				if not colliders.has(result["collider_id"]):
					colliders[result["collider_id"]] = result["collider"]
				if get_tree().debug_collisions_hint:
					debug_rays[ray_angle][2] = Color.RED

		elif get_tree().debug_collisions_hint:
			debug_rays[ray_angle][1] = b
			debug_rays[ray_angle][2] = Color.GRAY
		queue_redraw()

	for_rays(cast_ray)
	for collider_id in delta_colliders:
		if not colliders.has(collider_id):
			IlluminatedEntities.erase(collider_id)
	for collider_id in colliders:
		IlluminatedEntities.add(collider_id, colliders[collider_id])
	delta_colliders = colliders


func for_rays(function: Callable):
	var angle_per_ray = radial_angle / ray_count
	for i in ray_count:
		var ray_angle = angle_per_ray * i
		ray_angle -= radial_angle / 2
		function.call(ray_angle)
		# use global coordinates, not local to node
