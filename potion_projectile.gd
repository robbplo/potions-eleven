extends CharacterBody2D
class_name PotionProjectile

const THROW_TIME := .5
const FUSE_TIME := 1.0

var throw_target: Vector2
var throw_distance := 0.0
var throw_progress := 0.0
var throw_time_progress := 0.0

var resource: PotionResource

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	_apply_resource()
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

func detonate() -> void:
	queue_free()

func _get_speed():
	var speed_mult = -1 * throw_progress**2 + 1
	return throw_distance * speed_mult * (1/THROW_TIME)

func _apply_resource():
	sprite.texture = resource.texture
	sprite.scale = Vector2.ONE * resource.texture_scale

