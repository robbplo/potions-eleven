extends CharacterBody2D
class_name Potion

const SPEED := 900.0
const THROW_TIME := .5
const FUSE_TIME := 1.0

var throw_target: Vector2
var throw_distance := 0.0
var throw_progress := 0.0
var throw_time_progress := 0.0

func _ready() -> void:
	throw_distance = global_position.distance_to(throw_target)
	velocity = global_position.direction_to(throw_target) * _get_speed()

func _physics_process(delta: float) -> void:
	velocity = velocity.normalized() * _get_speed()
	var movement := velocity * delta
	if throw_time_progress >= THROW_TIME:
		start_fuse()

	var coll := move_and_collide(movement)
	if coll:
		var bounced_velocity = velocity.bounce(coll.get_normal())
		velocity = bounced_velocity
	throw_time_progress += delta
	throw_progress += movement.length() / throw_distance

func start_fuse():
	await get_tree().create_timer(FUSE_TIME).timeout
	detonate()

func _get_speed():
	var speed_mult = -1 * throw_progress**2 + 1
	return throw_distance * speed_mult * (1/THROW_TIME)

func detonate() -> void:
	queue_free()
