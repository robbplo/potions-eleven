extends CharacterBody2D
class_name Player

const SPEED = 300.0

func _physics_process(delta: float) -> void:
	var input_vector := Input.get_vector("left", "right", "up", "down")
	velocity = input_vector * SPEED
	move_and_slide()
	look_at(get_global_mouse_position())

