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
			$EyeIris.texture = load("res://Visual assets/Sprites/Character Icons/Player character layers/OMELAS_iris.png")
			$Body.texture = load("res://Visual assets/Sprites/Character Icons/Player character layers/OMELAS_body.png")
			
		"ANOR LONDO":
			$EyeIris.texture = load("res://Visual assets/Sprites/Character Icons/Player character layers/ANOR_LONDO_iris.png")
			$Body.texture = load("res://Visual assets/Sprites/Character Icons/Player character layers/ANOR_LONDO_body.png")
			
		"STORMWIND":
			$EyeIris.texture = load("res://Visual assets/Sprites/Character Icons/Player character layers/STORMWIND_iris.png")
			$Body.texture = load("res://Visual assets/Sprites/Character Icons/Player character layers/STORMWIND_body.png")
			
		"MENZOBERRANZAN":
			$EyeIris.texture = load("res://Visual assets/Sprites/Character Icons/Player character layers/MENZOBERRANZAN_iris.png")
			$Body.texture = load("res://Visual assets/Sprites/Character Icons/Player character layers/MENZOBERRANZAN_body.png")
			
		"ATUAN":
			$EyeIris.texture = load("res://Visual assets/Sprites/Character Icons/Player character layers/ATUAN_iris.png")
			$Body.texture = load("res://Visual assets/Sprites/Character Icons/Player character layers/ATUAN_body.png")
			
		"RAPTURE":
			$EyeIris.texture = load("res://Visual assets/Sprites/Character Icons/Player character layers/RAPTURE_iris.png")
			$Body.texture = load("res://Visual assets/Sprites/Character Icons/Player character layers/RAPTURE_body.png")
			
		"RIVENDELL":
			$EyeIris.texture = load("res://Visual assets/Sprites/Character Icons/Player character layers/RIVENDELL_iris.png")
			$Body.texture = load("res://Visual assets/Sprites/Character Icons/Player character layers/RIVENDELL_body.png")
			
		"GORMENGHAST":
			$EyeIris.texture = load("res://Visual assets/Sprites/Character Icons/Player character layers/GORMENGHAST_iris.png")
			$Body.texture = load("res://Visual assets/Sprites/Character Icons/Player character layers/GORMENGHAST_body.png")
