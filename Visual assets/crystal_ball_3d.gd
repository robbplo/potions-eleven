@tool
extends Node3D

@export_group("Layer_1")
@export var scale_1: float = .8
@export var rotation_speed_1: float = 1.0
@export var undulate_amount_1: float = 1.0

@export_group("Layer_2")
@export var scale_2: float = .9
@export var rotation_speed_2: float = 1.0
@export var undulate_amount_2: float = 1.0

@export_group("Layer_3")
@export var scale_3: float = 1.0
@export var rotation_speed_3: float = 1.0
@export var undulate_amount_3: float = 1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Layer1.rotation.y = $Layer1.rotation.y + (delta*rotation_speed_1)
	$Layer2.rotation.y = $Layer2.rotation.y + (delta*rotation_speed_2)
	$Layer3.rotation.y = $Layer3.rotation.y + (delta*rotation_speed_3)
