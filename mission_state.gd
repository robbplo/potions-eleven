extends Node2D

const DEFAULT_MISSION_SCENE = "res://Xanthosis.tscn"

signal mission_selected(mission: String)
signal character_selected(character: String)
## Mission started, not emitted on restart
signal mission_started
signal mission_restarted
signal pause_toggled(paused: bool)

var selected_mission: String: set = set_mission
var selected_character: String: set = set_character
var paused := false: set = set_paused

func set_mission(mission_name: String):
	selected_mission = mission_name
	mission_selected.emit(mission_name)

func set_character(character_name: String):
	selected_character = character_name
	character_selected.emit(character_name)

func set_paused(value: bool):
	if paused != value:
		paused = value
		pause_toggled.emit(value)
		get_tree().paused = value

func get_selected_mission_scene() -> String:
	match selected_mission:
		"TUTORIAL": return "res://tutorial_level.tscn"
		"XANTHOSIS": return "res://Xanthosis.tscn"
		"NEWT'S CRYSTAL": return "res://newts_crystal.tscn"
		"VOID LABORATORY": return "res://void_laboratory.tscn"
		"ANIMI": return "res://animi.tscn"
		_: return DEFAULT_MISSION_SCENE

func to_main_menu() -> void:
	paused = false
	MusicMixer.stop_heist_song()
	get_tree().change_scene_to_file("res://Menu_screens.tscn")

func restart_mission() -> void:
	paused = false
	mission_restarted.emit()
