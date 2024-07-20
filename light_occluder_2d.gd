@tool

extends LightOccluder2D
var shape: PackedVector2Array

# Called when the node enters the scene tree for the first time.
func _ready():
	shape = get_parent().polygon
	occluder.polygon = shape
	
func _process(_delta):
	shape = get_parent().polygon
	occluder.polygon = shape
