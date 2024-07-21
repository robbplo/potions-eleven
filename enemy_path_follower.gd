extends CharacterBody2D

enum State {
	IDLE,
	PATROLLING,
	ALERTED,
	ALERTED_WAITING
}

const PATROLLING_SPEED = 100.0
const ALERTED_SPEED = 200.0
const JUMP_VELOCITY = -400.0
const APPROACH_DEADZONE = 5.0
const RETURN_TIMEOUT = 2.0
const PATROLLING_ROTATE_SPEED = PI
const ALERTED_ROTATE_SPEED = PI * 2

var return_timer: SceneTreeTimer

@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var path: Path2D = $Path2D

var state: State = State.IDLE
# Index of the path point which should be navigated to
var path_current_point := 0

func _ready() -> void:
	patrol()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			alert(event.global_position)
		else:
			patrol()

func _physics_process(delta: float) -> void:
	match state:
		State.PATROLLING:
			move_toward_target(delta)
			if nav.is_target_reached():
				var curve_points := path.curve.get_baked_points()
				path_current_point = (path_current_point + 1) % curve_points.size()
				patrol()
		State.ALERTED:
			if nav.is_target_reached():
				state = State.ALERTED_WAITING
				return_timer = get_tree().create_timer(RETURN_TIMEOUT)
				await return_timer.timeout
				if state == State.ALERTED_WAITING:
					patrol()
			else:
				move_toward_target(delta)

func alert(target: Vector2):
	nav.target_position = target
	state = State.ALERTED

func patrol():
	var curve_points := path.curve.get_baked_points()
	nav.target_position = curve_points[path_current_point] + path.global_position
	state = State.PATROLLING


func move_toward_target(delta):
	if nav.get_final_position() != Vector2.ZERO and not nav.is_target_reachable():
		print("target not reachable: ", nav.target_position)
		return patrol()
	var direction := global_position.direction_to(nav.get_next_path_position())
	var target_angle := direction.angle()
	# Scale rotation to angle between self and target
	var rot_scale: float = abs(angle_difference(global_rotation, target_angle)) * randf_range(0.9, 1.1)
	var delta_rotation: float = get_rotation_speed() * delta * rot_scale
	global_rotation = rotate_toward(global_rotation, target_angle, delta_rotation)

	velocity = direction * get_speed()
	move_and_slide()

func get_speed():
	if state == State.ALERTED:
		return ALERTED_SPEED
	return PATROLLING_SPEED

func get_rotation_speed():
	if state == State.ALERTED:
		return ALERTED_ROTATE_SPEED
	return PATROLLING_ROTATE_SPEED


func _on_radial_raycast_entity_seen(body: CharacterBody2D) -> void:
	if body is Player:
		alert(body.global_position)

