class_name PotionDetonationShadow extends PotionDetonationStrategy

@export var effect_scene: PackedScene
@export var light_texture_size := 1080.0
## Raycast radius is reduced by this value so that player is out of range when exiting the shadow
@export var player_size := 90.0

@export var radius := 250.0
@export var duration := 5.0

func detonate(potion: PotionProjectile) -> void:
	# TODO: most of this logic should be inside the effect scene
	potion.visible = false
	var instance := effect_scene.instantiate()
	instance.global_position = potion.global_position

	var shadow := instance.get_node("Shadow") as PointLight2D
	shadow.texture_scale = radius / (light_texture_size / 2)

	var raycast := instance.get_node("RadialRaycast") as RadialRaycast
	raycast.ray_range = radius - player_size
	raycast.illumination_range = radius - player_size
	raycast.is_shadow = true

	var occluder := (instance.get_node("LightOccluder2D") as LightOccluder2D).occluder
	occluder.polygon = _create_circle()

	var collision_shape := instance.get_node("StaticBody2D/CollisionShape2D").shape as CircleShape2D
	collision_shape.radius = radius

	PlayerStats.get_level().add_child(instance)

	await instance.get_tree().create_timer(duration).timeout
	potion.queue_free()
	instance.queue_free()

func _create_circle() -> PackedVector2Array:
	var points: PackedVector2Array = []
	var resolution = 100
	for i in resolution:
		var angle := (1.0/resolution) * i as float * TAU
		var point := (Vector2.UP * radius).rotated(angle)
		points.append(point)
	return points
