extends Node

@onready var click1 = $Click1/Click1
@onready var click2 = $Click1/Click2
@onready var click3 = $Click1/Click3
@onready var click4 = $Click1/Click4

@onready var woosh1 = $Woosh1/Woosh1
@onready var woosh2 = $Woosh1/Woosh2

@onready var bottle1 = $BottleSelect/Bottle1
@onready var bottle2 = $BottleSelect/Bottle2
@onready var bottle3 = $BottleSelect/Bottle3
@onready var bottle4 = $BottleSelect/Bottle4

var sfx_volume: float = 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(delta):
	pass
	
func set_sfx_volume(normalised_volume :float):
	sfx_volume = normalised_volume
	
func click_1():
	var random_pitch = randf_range(0.95, 1.05)
	var i = randi_range(1,3)
	match i:
		1: 
			click1.pitch_scale = random_pitch
			$Click1/Click1.play()
			
		2: 
			click2.pitch_scale = random_pitch
			$Click1/Click2.play()
			
		3: 
			click3.pitch_scale = random_pitch
			$Click1/Click3.play()

func woosh_1():
	var random_pitch = randf_range(0.7, 0.8)
	var i = randi_range(2,2)
	match i:
		1: 
			woosh1.pitch_scale = random_pitch
			woosh1.play()
			
		2: 
			woosh2.pitch_scale = random_pitch
			woosh2.play()
			
func bottle_select():
	var random_pitch = randf_range(0.95, 1.05)
	var i = randi_range(0,4)
	match i:
		1: 
			bottle1.pitch_scale = random_pitch
			bottle1.play()
			
		2: 
			bottle2.pitch_scale = random_pitch
			bottle2.play()
			
		3: 
			bottle3.pitch_scale = random_pitch
			bottle3.play()
			
		4: 
			bottle4.pitch_scale = random_pitch
			bottle4.play()
