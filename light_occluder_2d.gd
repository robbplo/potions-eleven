@tool

extends LightOccluder2D

var shape: PackedVector2Array
var points: int

# Called when the node enters the scene tree for the first time.
func _ready():
	shape = get_parent().polygon
	points = get_parent().polygon.size()
	#position = get_parent().position
	
	
	occluder.polygon.resize(points)
	occluder.polygon = shape
	
func _process(_delta):
	shape = get_parent().polygon
	points = get_parent().polygon.size()
	#position = get_parent().position
		
	occluder.polygon.resize(points)
	occluder.polygon = shape
