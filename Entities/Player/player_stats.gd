extends Node2D

## Singleton which holds stats for the Player. Provides a global reference to the Player node for
## easy access from anywhere in the tree. This class also contains signals for player actions and
## stat updates.

signal potion_ammo_changed(idx: int, value: int)
signal potion_selected(idx: int)

var player: Player

## Get reference to Player node. Crashes if node cannot be found.
func get_player() -> Player:
	if not player:
		player = get_tree().get_first_node_in_group("Player")
	assert(player is Player, "player not found in scene tree")
	return player
