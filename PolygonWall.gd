@tool

extends Polygon2D
var shape: PackedVector2Array

@onready var outline: Line2D = $StaticBody2D/Line2D
@onready var occluder: LightOccluder2D = $StaticBody2D/LightOccluder2D
@onready var collision_shape: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D

@export var wall_color: Color
@export var has_outline: bool
@export var outline_color: Color
@export var occludes: bool
@export var collisions_disabled: bool

func _process(_delta):
	
	## this only runs in the editor and automatically handles setting properties
	## The properties do not need to be set again during runtime.
	if (Engine.is_editor_hint()):
		if not shape == polygon:
			shape = polygon
			_update_polygons()
		color = wall_color
		outline.visible = has_outline
		outline.default_color = outline_color
		occluder.visible = occludes
		collision_shape.disabled = collisions_disabled
		
##Set occluder, outline and collision to be the same shape as the polygon
func _update_polygons():
		#outline.points = shape
		#occluder.occluder.polygon = shape
		collision_shape.polygon = shape
