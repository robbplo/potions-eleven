extends CharacterBody2D

enum State {
	FOLLOWING,
	RETURNING,
	ALERTED,
	ALERTED_WAITING
}

const PATROL_SPEED = 300.0
const ALERT_SPEED = 500.0
const JUMP_VELOCITY = -400.0
const APPROACH_DEADZONE = 5.0
const WAIT_BEFORE_RETURNING = 1.0
const ROTATION_SPEED = TAU

@onready var nav: NavigationAgent2D = $NavigationAgent2D

var state: State = State.FOLLOWING
var alert_target = Vector2(1000, 500)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			alert(event.global_position)
		else:
			state = State.RETURNING

func _physics_process(delta: float) -> void:
	match state:
		State.FOLLOWING: $"..".progress += PATROL_SPEED * delta
		State.ALERTED:
			if nav.is_target_reached():
				state = State.ALERTED_WAITING
				#await get_tree().create_timer(WAIT_BEFORE_RETURNING).timeout
				#return_to_path()
			else:
				move_toward_target(delta)
		State.RETURNING:
			if nav.is_target_reached():
				follow_path()
			else:
				move_toward_target(delta)

func alert(target: Vector2):
	nav.target_position = target
	state = State.ALERTED

func return_to_path():
	state = State.RETURNING
	nav.target_position = get_parent().global_position

func follow_path():
	position = Vector2.ZERO
	state = State.FOLLOWING
	rotation = 0


func move_toward_target(delta):
	if not nav.is_target_reachable():
		# TODO: pick valid nearby location
		print("target not reachable")
		return return_to_path()
	var direction = global_position.direction_to(nav.get_next_path_position())
	var target_angle = direction.angle()
	# Scale rotation to size of angle
	var rot_scale = abs(angle_difference(global_rotation, target_angle))
	var delta_rotation = ROTATION_SPEED * delta * rot_scale
	global_rotation = rotate_toward(global_rotation, target_angle, delta_rotation )

	velocity = direction * ALERT_SPEED
	move_and_slide()
