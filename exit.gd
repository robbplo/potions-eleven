extends Node2D

const ACTIVE_COLOR := 0x00bebedb

var active := false

func _ready() -> void:
	PlayerStats.objective_collected.connect(_on_objective_collected)

func _on_objective_collected() -> void:
	active = true
	$Sprite2D.modulate = Color.hex(ACTIVE_COLOR)

func _on_area_2d_body_entered(body:Node2D) -> void:
	if active and body is Player:
		PlayerStats.extract_objective()
