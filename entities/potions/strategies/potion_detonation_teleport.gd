class_name PotionDetonationTeleport extends PotionDetonationStrategy

@export var effect_scene: PackedScene
@export var origin_scene: PackedScene

@export var timer := 1.0

func detonate(potion: PotionProjectile) -> void:
	potion.visible = false

	var origin = origin_scene.instantiate()
	var effect = effect_scene.instantiate()
	effect.global_position = potion.global_position
	effect.timer = timer
	effect.origin = origin

	PlayerStats.get_player().add_child(origin)
	PlayerStats.get_level().add_child(effect)
	potion.queue_free()
