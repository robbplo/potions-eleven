class_name PotionThrowLob extends PotionThrowStrategy

@export var throw_time := .5
@export var fuse_time := 1.0

var fuse_started := false
var throw_distance := 0.0
var throw_progress := 0.0
var throw_time_progress := 0.0

func set_target(potion: PotionProjectile, target: Vector2):
	throw_distance = potion.global_position.distance_to(target)
	potion.velocity = potion.global_position.direction_to(target) * _get_speed()

func apply_force(potion: PotionProjectile, delta: float):
	potion.velocity = potion.velocity.normalized() * _get_speed()
	var movement := potion.velocity * delta
	if not fuse_started and throw_time_progress >= throw_time:
		start_fuse(potion)

	var coll := potion.move_and_collide(movement)
	if coll:
		potion.velocity = potion.velocity.bounce(coll.get_normal())

	throw_time_progress += delta
	throw_progress += movement.length() / throw_distance

func start_fuse(potion: PotionProjectile):
	fuse_started = true
	await potion.get_tree().create_timer(fuse_time).timeout
	potion.detonate()

func _get_speed() -> float:
	var speed_mult = -1 * throw_progress**2 + 1
	return throw_distance * speed_mult * (1/throw_time)
