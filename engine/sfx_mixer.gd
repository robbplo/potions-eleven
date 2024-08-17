extends Node

var click1_n
@onready var click1 = $Click1/Click1
@onready var click2 = $Click1/Click2
@onready var click3 = $Click1/Click3

var click2_n
@onready var click2_1 = $Click2/Click2_1
@onready var click2_2 = $Click2/Click2_2
@onready var click2_3 = $Click2/Click2_3
@onready var click2_4 = $Click2/Click2_4

var screen_move_n

@onready var woosh1 = [
	$Woosh1/Woosh1,
	$Woosh1/Woosh2
]

@onready var bottles = [
	$BottleSelect/Bottle1,
	$BottleSelect/Bottle2,
	$BottleSelect/Bottle3,
	$BottleSelect/Bottle4
]

var sfx_volume: float = 1.0

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

func click_2():
	var i = randi_range(1,4)
	while i == click2_n:
		i = randi_range(1,4)
	match i:
		1: $Click2/Click2_1.play()
		2: $Click2/Click2_2.play()
		3: $Click2/Click2_3.play()
		4: $Click2/Click2_4.play()

func screen_move():
	var i = randi_range(1,3)
	while i == screen_move_n:
		i = randi_range(1,3)
	match i:
		1:
			$ScreenMove/ScreenMove1.play()

		2:
			$ScreenMove/ScreenMove2.play()

		3:
			$ScreenMove/ScreenMove3.play()
	screen_move_n = i

func woosh_1():
	var random_pitch = randf_range(0.7, 0.8)
	var woosh = woosh1.pick_random()
	woosh.pitch_scale = random_pitch
	woosh.play()

func bottle_select():
	var random_pitch = randf_range(0.95, 1.05)
	var bottle = bottles.pick_random()
	bottle.pitch_scale = random_pitch
	bottle.play()

func go_to_level():
	$GameTransition/go_to_level.play()
