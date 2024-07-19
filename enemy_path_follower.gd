extends CharacterBody2D

const PATROL_SPEED = 300.0
const ALERT_SPEED = 500.0
const JUMP_VELOCITY = -400.0
const APPROACH_DEADZONE = 5.0
const WAIT_BEFORE_RETURNING = 1.0

@onready var nav: NavigationAgent2D = $NavigationAgent2D

enum State {
	FOLLOWING,
	RETURNING,
	ALERTED,
	ALERTED_WAITING
}
var state: State = State.FOLLOWING
var alert_target = Vector2(1000, 500)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			nav.target_position = event.global_position
			state = State.ALERTED
		else:
			state = State.RETURNING


func _physics_process(delta: float) -> void:
	if state == State.FOLLOWING:
		$"..".progress += PATROL_SPEED * delta
	if state == State.ALERTED:
		if nav.is_target_reached():
			state = State.ALERTED_WAITING
			await get_tree().create_timer(WAIT_BEFORE_RETURNING).timeout
			state = State.RETURNING
			nav.target_position = get_parent().global_position
		else:
			var direction = global_position.direction_to(nav.get_next_path_position())
			velocity = direction * ALERT_SPEED
			move_and_slide()
	if state == State.RETURNING:
		if nav.is_target_reached():
			position = Vector2.ZERO
			state = State.FOLLOWING
		else:
			var direction = global_position.direction_to(nav.get_next_path_position())
			velocity = direction * ALERT_SPEED
			move_and_slide()
