class_name Player extends CharacterBody2D

const SPEED := 300.0
const THROW_SPEED := 900.0
const EYE_MAX_MOVEMENT := Vector2(80, 60)
const EYE_MAX_DISTANCE := Vector2(600.0, 300.0)

@onready var potion_belt: PotionBelt = $PotionBelt

func _physics_process(_delta: float) -> void:
	var input_vector := Input.get_vector("left", "right", "up", "down")
	velocity = input_vector * SPEED
	move_and_slide()
	_eye_look_at(get_global_mouse_position())

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			potion_belt.throw_potion(event.global_position)

func die():
	queue_free()

func _eye_look_at(target: Vector2):
	var distance = (target - global_position).clamp(-EYE_MAX_DISTANCE, EYE_MAX_DISTANCE)
	var direction = global_position.direction_to(target)
	var movement_scale = (distance / EYE_MAX_DISTANCE) * direction.sign()
	$EyeIris.position = movement_scale * direction * EYE_MAX_MOVEMENT
