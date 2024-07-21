extends CharacterBody2D
class_name Player

const SPEED := 300.0
const THROW_SPEED = 900.0
const POTION_SCENE := preload("res://potion.tscn")

func _physics_process(_delta: float) -> void:
	var input_vector := Input.get_vector("left", "right", "up", "down")
	velocity = input_vector * SPEED
	move_and_slide()
	look_at(get_global_mouse_position())

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			throw_potion(event.global_position)

func throw_potion(target: Vector2):
	var instance: Potion = POTION_SCENE.instantiate()
	instance.throw_target = target
	instance.global_position = global_position
	get_tree().root.add_child(instance)

func die():
	queue_free()
