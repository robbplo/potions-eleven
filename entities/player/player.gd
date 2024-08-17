class_name Player extends CharacterBody2D

const SPEED := 300.0
const THROW_SPEED := 900.0
const EYE_MAX_MOVEMENT := Vector2(80, 60) * 0.25
const EYE_MAX_DISTANCE := Vector2(600.0, 300.0)

@onready var potion_belt: PotionBelt = $PotionBelt

func _ready():
	_set_character_icon()

func _physics_process(_delta: float) -> void:

	var input_vector := Input.get_vector("left", "right", "up", "down")
	velocity = input_vector * SPEED
	move_and_slide()
	_eye_look_at(get_global_mouse_position())

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("throw_potion"):
		potion_belt.throw_potion(get_global_mouse_position())

func die():
	PlayerStats.player_died.emit()
	queue_free()

func _eye_look_at(target: Vector2):
	var distance = (target - global_position).clamp(-EYE_MAX_DISTANCE, EYE_MAX_DISTANCE)
	var direction = global_position.direction_to(target)
	var movement_scale = (distance / EYE_MAX_DISTANCE) * direction.sign()
	$EyeIris.position = movement_scale * direction * EYE_MAX_MOVEMENT

func _set_character_icon():
	match MissionState.selected_character:
		"OMELAS":
			$EyeIris.texture = load("res://visuals/sprites/characters/player_layers/omelas_iris.png")
			$Body.texture = load("res://visuals/sprites/characters/player_layers/omelas_body.png")
		"ANOR LONDO":
			$EyeIris.texture = load("res://visuals/sprites/characters/player_layers/anor_londo_iris.png")
			$Body.texture = load("res://visuals/sprites/characters/player_layers/anor_londo_body.png")

		"STORMWIND":
			$EyeIris.texture = load("res://visuals/sprites/characters/player_layers/stormwind_iris.png")
			$Body.texture = load("res://visuals/sprites/characters/player_layers/stormwind_body.png")

		"MENZOBERRANZAN":
			$EyeIris.texture = load("res://visuals/sprites/characters/player_layers/menzoberranzan_iris.png")
			$Body.texture = load("res://visuals/sprites/characters/player_layers/menzoberranzan_body.png")

		"ATUAN":
			$EyeIris.texture = load("res://visuals/sprites/characters/player_layers/atuan_iris.png")
			$Body.texture = load("res://visuals/sprites/characters/player_layers/atuan_body.png")

		"RAPTURE":
			$EyeIris.texture = load("res://visuals/sprites/characters/player_layers/rapture_iris.png")
			$Body.texture = load("res://visuals/sprites/characters/player_layers/rapture_body.png")

		"RIVENDELL":
			$EyeIris.texture = load("res://visuals/sprites/characters/player_layers/rivendell_iris.png")
			$Body.texture = load("res://visuals/sprites/characters/player_layers/rivendell_body.png")

		"GORMENGHAST":
			$EyeIris.texture = load("res://visuals/sprites/characters/player_layers/gormenghast_iris.png")
			$Body.texture = load("res://visuals/sprites/characters/player_layers/gormenghast_body.png")
