class_name PotionResource extends Resource

## Ingame texture of the projectile
@export var proj_texture: Texture2D
## Scale for the texture. The collider is a circle with a 16px radius.
@export_range(0.01, 10) var proj_texture_scale := 1.0
@export var ui_texture: Texture2D
## Amount of potions that player starts with
@export var count: int
## Throwing behavior
@export var throw_strategy: PotionThrowStrategy
## Detonation behavior
@export var detonation_strategy: PotionDetonationStrategy
