@tool

extends Line2D

var shape: PackedVector2Array


func _ready():
	shape = get_parent().polygon
	points = shape
	
func _process(_delta):
		shape = get_parent().polygon
		points = shape
