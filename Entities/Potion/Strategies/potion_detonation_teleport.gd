class_name PotionDetonationTeleport extends PotionDetonationStrategy

const EFFECT := preload("res://Entities/Potion/Strategies/potion_detonation_teleport_effect.tscn")
const ORIGIN := preload("res://Entities/Potion/Strategies/potion_detonation_teleport_origin.tscn")

@export var timer := 1.0

func detonate(potion: PotionProjectile) -> void:
	potion.visible = false

	var origin = ORIGIN.instantiate()

	var effect = EFFECT.instantiate()
	effect.global_position = potion.global_position
	effect.timer = timer
	effect.origin = origin

	PlayerStats.get_player().add_child(origin)
	PlayerStats.get_level().add_child(effect)
	potion.queue_free()
