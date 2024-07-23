extends CharacterBody2D

enum State {
	IDLE,
	PATROLLING,
	ALERTED,
	ALERTED_SEARCHING
}

const PATROLLING_SPEED := 100.0
const ALERTED_SPEED := 200.0
const PATROLLING_ROTATE_SPEED := PI
const ALERTED_ROTATE_SPEED := PI * 2
const RETURN_TIMEOUT := 2.0

var return_timer: SceneTreeTimer
var last_player_pos := Vector2.ZERO
var player_velocity := Vector2.ZERO
var predicted_player_pos := Vector2.ZERO

@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var path: Path2D = $Path2D

var state: State = State.IDLE
# Index of the point in the Path 2D which should be navigated to
var path_current_point := 0

func alert(target: Vector2):
	if last_player_pos != Vector2.ZERO:
		player_velocity = target - last_player_pos
	last_player_pos = target
	nav.target_position = target
	state = State.ALERTED

func patrol():
	var curve_points := path.curve.get_baked_points()
	nav.target_position = curve_points[path_current_point] + path.global_position
	last_player_pos = Vector2.ZERO
	predicted_player_pos = Vector2.ZERO
	state = State.PATROLLING

func search(delta):
	state = State.ALERTED_SEARCHING
	if player_velocity != Vector2.ZERO and last_player_pos != Vector2.ZERO:
		predicted_player_pos = last_player_pos + (player_velocity / delta)
		nav.target_position = predicted_player_pos

func is_alerted() -> bool:
	return state in [State.ALERTED_SEARCHING,State.ALERTED]

func _ready() -> void:
	# Wait for navigation map to be ready
	await NavigationServer2D.map_changed
	patrol()

func _physics_process(delta: float) -> void:
	match state:
		State.PATROLLING:
			if nav.is_navigation_finished():
				var curve_points := path.curve.get_baked_points()
				path_current_point = (path_current_point + 1) % curve_points.size()
				patrol()
			else:
				_move_toward_target(delta)
		State.ALERTED:
			if nav.is_navigation_finished():
				search(delta)
			else:
				_move_toward_target(delta)
		State.ALERTED_SEARCHING:
			if nav.is_navigation_finished():
				return_timer = get_tree().create_timer(RETURN_TIMEOUT)
				await return_timer.timeout
				if state == State.ALERTED_SEARCHING:
					patrol()
			else:
				_move_toward_target(delta)

func _move_toward_target(delta):
	var direction := global_position.direction_to(nav.get_next_path_position())
	velocity = direction * _get_speed()
	move_and_slide()

	if state == State.ALERTED and last_player_pos != Vector2.ZERO:
		direction = global_position.direction_to(last_player_pos)
	elif state == State.ALERTED_SEARCHING and predicted_player_pos != Vector2.ZERO:
		direction = global_position.direction_to(predicted_player_pos)

	var angle := direction.angle()
	# Scale rotation to angle between self and target
	var rot_scale: float = abs(angle_difference(global_rotation, angle)) * randf_range(0.9, 1.1)
	var delta_rotation: float = _get_rotation_speed() * delta * rot_scale
	global_rotation = rotate_toward(global_rotation, angle, delta_rotation)

func _get_speed():
	if is_alerted():
		return ALERTED_SPEED
	return PATROLLING_SPEED

func _get_rotation_speed():
	if is_alerted():
		return ALERTED_ROTATE_SPEED
	return PATROLLING_ROTATE_SPEED

func _on_radial_raycast_entity_seen(body: CharacterBody2D) -> void:
	if body is Player:
		alert(body.global_position)

func _on_kill_area_body_entered(body:Node2D) -> void:
	if is_alerted() and body is Player:
		body.die()
		state = State.IDLE
