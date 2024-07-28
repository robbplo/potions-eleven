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

## Player node
var player: Player
## Has the level objective been collected?
var has_objective := false

## Get reference to Player node. Crashes if node cannot be found.
func get_player() -> Player:
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
	print("gottem")

func extract_objective():
	objective_extracted.emit()
	print("level complentened")
