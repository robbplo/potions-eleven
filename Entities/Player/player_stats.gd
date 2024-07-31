extends Node2D

## Singleton which holds stats for the Player. Provides a global reference to the Player node for
## easy access from anywhere in the tree. This class also contains signals for player actions and
## stat updates.

## Ammo count for potion was changed.
signal potion_ammo_changed(idx: int, value: int)
## Player selected a potion from their loadout.
signal potion_selected(idx: int)
## The objective has been picked up by the player.
signal objective_collected
## Player reached the exit with the objective.
signal objective_extracted
## YOU DIED
signal player_died

## Player node
var player
## Has the level objective been collected?
var has_objective := false

func _ready() -> void:
	MissionState.mission_restarted.connect(func(): player = null)
	

## Get reference to Player node. Crashes if node cannot be found.
func get_player() -> Player:
	print(player, is_instance_valid(player))
	if not player:
		player = get_tree().get_first_node_in_group("player")
	assert(player is Player, "player not found in scene tree")
	return player

## Gets the parent of the player node, which should be the level
func get_level() -> Node2D:
	return get_player().get_parent()

func collect_objective():
	has_objective = true
	objective_collected.emit()

func extract_objective():
	objective_extracted.emit()
	
