extends Node2D

signal mission_selected(mission: String)
signal character_selected(character: String)

var selected_mission: String: set = set_mission
var selected_character: String: set = set_character

func set_mission(mission_name: String):
	selected_mission = mission_name
	mission_selected.emit(mission_name)

func set_character(character_name: String):
	selected_character = character_name
	character_selected.emit(character_name)

