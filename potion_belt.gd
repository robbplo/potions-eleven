class_name PotionBelt extends Node2D

const POTION_SCENE := preload("res://Entities/Potion/potion_projectile.tscn")

@export var loadout: Array[PotionResource]
var amounts: Array[int] = []
var selected: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for potion in loadout:
		amounts.append(potion.count)

func throw_potion(target: Vector2):
	if amounts[selected] <= 0:
		# Cannot throw when no is potion
		return

	var instance: PotionProjectile = POTION_SCENE.instantiate()
	instance.global_position = global_position
	instance.resource = loadout[selected].duplicate(true)
	instance.set_target(target)
	get_tree().root.add_child(instance)
	amounts[selected] -= 1
