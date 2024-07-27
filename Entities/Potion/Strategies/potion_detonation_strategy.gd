class_name PotionDetonationStrategy extends Resource

func detonate(potion: PotionProjectile) -> void:
	potion.queue_free()
