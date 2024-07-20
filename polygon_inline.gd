@tool

extends Line2D

var shape: PackedVector2Array
var points_num: int


func _ready():
	shape = get_parent().polygon
	points_num = get_parent().polygon.size()
	
	points.resize(points_num)
	points = shape
	
func _process(_delta):
	if (Engine.is_editor_hint()):
		shape = get_parent().polygon
		points_num = get_parent().polygon.size()
		
		points.resize(points_num)
		points = shape
