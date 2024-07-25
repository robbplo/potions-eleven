class_name EnemyPathFollower extends CharacterBody2D

signal state_changed(from: State, to: State)
signal alert_changed(alerted: bool)

enum State {
	IDLE, # Not moving
	PATROLLING, # Following Path2D node
	PATROLLING_PAUSED, # Patrolling, but not currently moving
	PURSUING, # Actively chasing the player
	SEARCHING, # Searching after player goes out of sight during pursuit
	DEAD, # Yup
	STUNNED, # Incapacitated, unable to move or attack
}

const BASE_SPEED := 100.0
const ALERTED_SPEED := 200.0
const BASE_ROTATE_SPEED := PI
const ALERTED_ROTATE_SPEED := PI * 2
const SEARCHING_TIMEOUT := 2.0

@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var path: Path2D = $Path2D

## Current state which defines the enemy's behavior.
var state: State = State.IDLE: set = _set_state
## True when enemy is aware of player's presence.
var is_alert := false:
	set(value):
		is_alert = value
		alert_changed.emit(value)
## Target position when last seen, used to calculate velocity.
var prev_target_pos := Vector2.ZERO
## Used to predict player position.
var target_velocity := Vector2.ZERO
## Becomes the target position.
var predicted_player_pos := Vector2.ZERO
## Starts when searching destination is reached, returns to patrol after
var searching_timer: SceneTreeTimer
## Baked points of Path2D.
@onready var path_points: PackedVector2Array = path.curve.get_baked_points()
## Index of the point in the Path2D which should be navigated to.
var path_current_idx := 0:
	set(value):
		if path_points.is_empty():
			path_current_idx = value
			return
		path_current_idx = value % path_points.size()

func _ready() -> void:
	# call is deferred to prevent blocking the thread
	call_deferred("_setup")

func _setup() -> void:
	# Wait for nav server, then start patrolling.
	await NavigationServer2D.map_changed
	state = State.PATROLLING

func _physics_process(delta: float) -> void:
	if state in [State.PATROLLING, State.PURSUING, State.SEARCHING]:
		_move_toward_target(delta)
		# Target reached, find next target

## Set a new navigation target.
func set_target(target: Vector2):
	if prev_target_pos != Vector2.ZERO:
		target_velocity = target - prev_target_pos
	prev_target_pos = target
	nav.target_position = target

## Set the enemy state, applying any state-specific logic.
## Used as setter for `state` variable.
func _set_state(new_state: State):
	var old_state = state
	# Handle transition from old state
	match old_state:
		pass

	# Handle transition into new state
	match new_state:
		State.PATROLLING:
			# Set navigation to the current path point
			nav.target_position = path_points[path_current_idx] + path.global_position
			prev_target_pos = Vector2.ZERO
			predicted_player_pos = Vector2.ZERO

	state = new_state
	state_changed.emit(old_state, new_state)

## Move toward the navigation target. Also handles rotation.
func _move_toward_target(delta):
	# Movement
	var direction := global_position.direction_to(nav.get_next_path_position())
	velocity = direction * _get_speed()
	move_and_slide()

	# Rotation
	if state == State.PURSUING and prev_target_pos != Vector2.ZERO:
		direction = global_position.direction_to(prev_target_pos)
	elif state == State.SEARCHING and predicted_player_pos != Vector2.ZERO:
		direction = global_position.direction_to(predicted_player_pos)
	var angle := direction.angle()
	# Scale rotation so large rotations are faster than small rotations
	var rot_scale: float = abs(angle_difference(global_rotation, angle)) * randf_range(0.9, 1.1)
	var delta_rotation: float = _get_rotation_speed() * delta * rot_scale
	global_rotation = rotate_toward(global_rotation, angle, delta_rotation)

	if nav.is_navigation_finished():
		_handle_navigation_finished(delta)

## Current movement speed
func _get_speed() -> float:
	if state in [State.DEAD, State.STUNNED]:
		return 0.0
	if is_alert:
		return ALERTED_SPEED
	return BASE_SPEED

## Current rotation speed
func _get_rotation_speed() -> float:
	if state in [State.DEAD, State.STUNNED]:
		return 0.0
	if is_alert:
		return ALERTED_ROTATE_SPEED
	return BASE_ROTATE_SPEED

## Decide next behavior when navigation target is reached based on current state.
func _handle_navigation_finished(delta):
	print(state)
	match state:
		State.PATROLLING:
			path_current_idx += 1
			# Set state again to set new nav target
			state = State.PATROLLING
		State.PURSUING:
			if target_velocity != Vector2.ZERO and prev_target_pos != Vector2.ZERO:
				predicted_player_pos = prev_target_pos + (target_velocity / delta)
				nav.target_position = predicted_player_pos
			state = State.SEARCHING
		State.SEARCHING:
			searching_timer = get_tree().create_timer(SEARCHING_TIMEOUT)
			await searching_timer.timeout
			if searching_timer:
				searching_timer = null
				state = State.PATROLLING

func _on_radial_raycast_entity_seen(body: CharacterBody2D) -> void:
	if body is Player:
		is_alert = true
		set_target(body.global_position)
		state = State.PURSUING

func _on_kill_area_body_entered(body:Node2D) -> void:
	if is_alert and body is Player:
		body.die()
		state = State.IDLE
