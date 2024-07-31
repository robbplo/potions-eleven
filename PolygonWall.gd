@tool

extends Polygon2D

## As much as possible, use only the export values to change wall properties.
## If export values prove insufficient, add the export value in code and then tweak.

#@export_group("Shape")
#@export var radius: int = 100
#@export var smoothness: int = 4

@export_group("Wall")
@export var wall_color: Color
## The shader materials make the walls and outlines unshaded. This is done with
## "render_mode unshaded;" in the shder code. Otherwise, go ham with it. 
@export var wall_material: ShaderMaterial

@export_group("Outline")
@export var has_outline: bool
@export var outline_color: Color
@export var outline_material: ShaderMaterial

@export_group("Properties")
@export var occludes: bool
@export var collisions_disabled: bool

@export_group("Debug")
@export var collisions_visible: bool

var shape: PackedVector2Array

## Collisionshapes seem to stick strictly to their parent even when sharing resources.
@onready var collision_shape: CollisionPolygon2D = $StaticBody2D/WallCollision

## To avoid resource sharing causing problems, new nodes are made for each wall piece.
@onready var outline = Line2D.new()
@onready var occluder = LightOccluder2D.new()
@onready var occluder_polygon =  OccluderPolygon2D.new()


func _ready():
	## DO NOT SET MATERIALS IN REALTIME.
	material = wall_material
	_create_outline()
	_create_occluder()
	
	_update_polygons()
	_update_properties()
	
	print_tree_pretty()

func _process(_delta):
	
	## this only runs in the editor and automatically handles setting properties
	if (Engine.is_editor_hint()):
		if not shape == polygon:
			shape = polygon
			_update_polygons()
		_update_properties()
	
	## this only runs in the game environment
	## preferably the polygon and property update only needs to be done once,
	## but this doens't work yet
	if not Engine.is_editor_hint():
		if not shape == polygon:
			shape = polygon
			_update_polygons()
			_update_properties()

func _create_occluder():
	#occluder.set_owner(self)
	occluder.set_name("Occluder")
	occluder.set_occluder_polygon(occluder_polygon)
	occluder.occluder.cull_mode = OccluderPolygon2D.CULL_CLOCKWISE
	occluder.clip_children = CanvasItem.CLIP_CHILDREN_ONLY
	add_child(occluder)
	
func _create_outline():
	#outline.set_owner(self)
	outline.set_name("Outline")
	outline.closed = true
	outline.width = 4
	outline.joint_mode = Line2D.LINE_JOINT_ROUND
	outline.set_material(outline_material)
	add_child(outline)
	
## Set occluder, outline and collision to be the same shape as the polygon
func _update_polygons():
	if shape.size() > 2:
		outline.points = shape
		occluder.occluder.polygon = shape
		collision_shape.polygon = shape

## Set relevant properties of wall and child nodes to the export values.
func _update_properties():
	color = wall_color
	outline.visible = has_outline
	outline.default_color = outline_color
	occluder.visible = occludes
	collision_shape.disabled = collisions_disabled
	collision_shape.visible = collisions_visible
