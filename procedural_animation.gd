## Procedural animation using second order systems
##
## reference: https://www.youtube.com/watch?v=KPoeNZZ6H4s

@tool
class_name ProceduralAnimation extends Node2D

var xp: Vector2
var y: Vector2
var yd: Vector2
var k1: float
var k2: float
var k3: float
var x0 := Vector2.ZERO

## Frequency of the system in Hz. [br]
## Affects the overall speed of the system. [br]
@export_range(-10.0, 10, .1) var frequency := 1.0

## Damping coefficient 'zeta'. [br]
## Describes how the system settles. [br]
## 0 is no damping or infinite oscillation. [br]
## Between 0 and 1 there is some vibration and overshooting. [br]
## Greater than one there is no vibration and the system settles without overshooting. [br]
@export_range(-10.0, 10, .1) var damping := 1.0

## Controls the initial response to a change in the system. [br]
## At 0 the system will have a delayed response to changes. [br]
## At 1 the system will respond immediately. [br]
## At greater than 1 the system will overshoot its value. [br]
## At negative values the system will start by moving in the opposite direction. [br]
@export_range(-3.0, 3, .1) var response := 0.5

## Node which should be followed.
@export var target: Node2D:
	set(value):
		target = value
		update_configuration_warnings()

func _enter_tree():
	if Engine.is_editor_hint():
		setup()

func _ready():
	if not Engine.is_editor_hint():
		setup()

func _process(delta):
	if target:
		global_position = update(delta, target.global_position)

func setup():
	if not _get_configuration_warnings().is_empty():
		push_error("No target node was selected.")
		return

	x0 = target.global_position
	k1 = damping / (PI * frequency)
	k2 = 1 / ((2 * PI * frequency) * (2 * PI * frequency))
	k3 = response * damping / (2 * PI * frequency)
	xp = x0
	y = x0
	yd = Vector2.ZERO

func update(T: float, x: Vector2, xd: Vector2 = Vector2.ZERO) -> Vector2:
	if not xd:
		xd = (x - xp) / T
		xp = x
	var k2_stable = max(k2, T*T/2 + T*k1/2, T*k1)
	y = y + T * yd
	yd = yd + T * (x + k3*xd - y - k1*yd) / k2_stable
	return y

func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	if not target:
		warnings.append("No target node was selected.")
	return warnings
