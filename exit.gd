extends Node2D

var active := false

func _ready() -> void:
	PlayerStats.objective_collected.connect(_on_objective_collected)

func _on_objective_collected() -> void:
	active = true
	$Sprite2D.modulate = Color.hex(0x00bebeb4)

func _on_area_2d_body_entered(body:Node2D) -> void:
	if active and body is Player:
		PlayerStats.extract_objective()

