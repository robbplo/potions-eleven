class_name PotionBelt extends Node2D

@export var potion_scene: PackedScene
@export var loadout: Array[PotionResource]
var ammo: Array[int] = []
var selected: int = 0

func _ready() -> void:
	for potion in loadout:
		ammo.append(potion.count)

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("hotbar_1"):
		return select(0)
	if event.is_action_pressed("hotbar_2"):
		return select(1)
	if event.is_action_pressed("hotbar_3"):
		return select(2)
	if event.is_action_pressed("hotbar_4"):
		return select(3)

## Yeet
func throw_potion(target: Vector2) -> void:
	if loadout.size() <= selected || ammo[selected] <= 0:
		# Cannot throw when no is potion
		return

	var instance: PotionProjectile = potion_scene.instantiate()
	instance.global_position = global_position
	instance.resource = loadout[selected].duplicate(true)
	instance.set_target(target)
	PlayerStats.get_level().add_child(instance)

	ammo[selected] -= 1
	PlayerStats.potion_ammo_changed.emit(selected, ammo[selected])

	SfxMixer.woosh_1()

## Change selected potion
func select(idx) -> void:
	if idx <= loadout.size():
		selected = idx
		PlayerStats.potion_selected.emit(idx)
		SfxMixer.bottle_select()
