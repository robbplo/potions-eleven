class_name PotionThrowPitch extends PotionThrowStrategy

@export var initial_speed := 3000.0
@export var drag := 0.95

var direction := Vector2.ZERO

func set_target(potion: PotionProjectile, target: Vector2):
	direction = potion.global_position.direction_to(target)
	potion.velocity = direction * initial_speed

func apply_force(potion: PotionProjectile, delta: float):
	potion.velocity = potion.velocity * drag
	var movement := potion.velocity * delta

	var coll := potion.move_and_collide(movement)
	if coll:
		potion.velocity = potion.velocity.bounce(coll.get_normal())
