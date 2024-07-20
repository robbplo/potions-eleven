@tool

extends Polygon2D
var shape: Array

func _ready():
	pass
	#shape = polygon
	#outline.points = shape
	#occluder.occluder.polygon = shape
	#collision_shape.polygon = shape
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	
	if (Engine.is_editor_hint()):
		var outline: Line2D = $PolygonOutline
		var occluder: LightOccluder2D = $LightOccluder2D
		var collision_shape: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D
		
		#Get the location of each polygon vertex
		shape = polygon
		outline.points = shape
		occluder.occluder.polygon = shape
		collision_shape.polygon = shape
