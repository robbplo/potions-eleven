extends CharacterBody2D
class_name Potion

const VELOCITY_DAMPING = .99
const BOUNCE_ANGLE := deg_to_rad(100)

func _physics_process(delta: float) -> void:
	var coll := move_and_collide(velocity * delta)
	if coll:
		if coll.get_collider() is CharacterBody2D:
			return detonate()

		var bounced_velocity = velocity.bounce(coll.get_normal())
		if abs(velocity.angle_to(bounced_velocity)) < BOUNCE_ANGLE:
			velocity = bounced_velocity
			return

		detonate()
	velocity *= VELOCITY_DAMPING

func detonate() -> void:
	queue_free()
