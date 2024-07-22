class_name PotionProjectile extends CharacterBody2D

var resource: PotionResource

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	_apply_resource()

func _physics_process(delta: float) -> void:
	resource.throw_strategy.apply_force(self, delta)

func set_target(target: Vector2):
	resource.throw_strategy.set_target(self, target)

func detonate() -> void:
	queue_free()

func _apply_resource():
	sprite.texture = resource.texture
	sprite.scale = Vector2.ONE * resource.texture_scale

