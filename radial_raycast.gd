extends Node2D

@export var ray_count: int = 60
@export var radial_angle: float = 360.0
@export var ray_range: float

var debug_rays := {}

func _ready() -> void:
	for_rays(func (ray_angle): debug_rays[ray_angle] = [Vector2.ZERO, Vector2.ZERO, Color.GRAY])

func _draw() -> void:
	if get_tree().debug_collisions_hint:
		for ray in debug_rays.values():
			draw_line(to_local(ray[0]), to_local(ray[1]), ray[2])

func _physics_process(delta: float) -> void:
	var space_state = get_world_2d().direct_space_state
	var cast_ray = func (ray_angle):
		var a = self.global_position
		var b = (a + Vector2(0, ray_range).rotated(deg_to_rad(ray_angle)))
		var query = PhysicsRayQueryParameters2D.create(a, b)
		var result := space_state.intersect_ray(query)
		if get_tree().debug_collisions_hint:
			debug_rays[ray_angle][0] = a
		if not result.is_empty():
			var collider = result["collider"]
			if collider is CharacterBody2D:
				# handle collisions
				pass
			if get_tree().debug_collisions_hint:
				debug_rays[ray_angle][1] = result["position"]
				debug_rays[ray_angle][2] = Color.RED
		elif get_tree().debug_collisions_hint:
			debug_rays[ray_angle][1] = b
			debug_rays[ray_angle][2] = Color.GRAY
		queue_redraw()

	for_rays(cast_ray)

func for_rays(function: Callable):
	var angle_per_ray = radial_angle / ray_count
	for i in ray_count:
		function.call(angle_per_ray * i)
		# use global coordinates, not local to node


