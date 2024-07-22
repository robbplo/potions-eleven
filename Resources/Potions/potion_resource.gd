class_name PotionResource extends Resource

## Texture applied to the potion
@export var texture: Texture2D
## Scale for the texture. The collider is a circle with a 16px radius.
@export_range(0.01, 10) var texture_scale := 1.0
## Amount of potions that player starts with
@export var count: int
## Throwing behavior
@export var throw_strategy: PotionThrowStrategy
