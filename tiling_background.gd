class_name TilingBackground extends Node2D

@export var texture_size = 32.0
@export var tile_scale := 16.0
@export var tiles_x := 10
@export var tiles_y := 10

func _ready() -> void:
	var tile_node: Sprite2D = $Tile
	tile_node.queue_free()
	for y in tiles_y:
		for x in tiles_x:
			var new_tile: Sprite2D = tile_node.duplicate()
			var pos := Vector2(texture_size * x, texture_size * y) * tile_scale
			new_tile.position = pos
			new_tile.scale = Vector2.ONE * tile_scale
			add_child(new_tile)
