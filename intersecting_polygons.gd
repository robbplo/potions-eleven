extends Node2D

@onready var p1: Polygon2D = $Polygon2D
@onready var p2: Polygon2D = $Polygon2D2
@onready var p3: Polygon2D = $Polygon2D3

func _process(_delta: float) -> void:
	p2.global_position = get_global_mouse_position()
	var vertex1 := p1.global_transform * p1.polygon
	var vertex2 := p2.global_transform * p2.polygon

	var clipped := Geometry2D.clip_polygons(vertex1, vertex2)
	if clipped.is_empty():
		# vertex2 encloses vertex1
		p3.polygon = []
		p3.polygons = []
		return

	if clipped.size() == 1:
		p3.polygon = p1.global_transform.inverse() * clipped[0]
		p3.polygons = []
		return

	var new_polygon = []
	var new_polygons = []
	for polygon in clipped:
		var start_idx = new_polygon.size()
		new_polygon.append_array(p1.global_transform.inverse() * polygon)
		var indices = PackedInt32Array()
		for vert_index in polygon.size():
			indices.append(start_idx + vert_index)
		new_polygons.append(indices)
	p3.polygon = new_polygon
	p3.polygons = new_polygons
