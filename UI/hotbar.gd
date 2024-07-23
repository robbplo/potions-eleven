extends HBoxContainer

## Index of the currently selected item.
var current_selected: int = 0

func _ready() -> void:
	init_loadout()
	PlayerStats.potion_ammo_changed.connect(_on_potion_ammo_changed)
	PlayerStats.potion_selected.connect(_on_potion_selected)


func init_loadout():
	var player = PlayerStats.get_player()
	var loadout = player.potion_belt.loadout

	for idx in get_child_count():
		var item: HotbarItem = get_child(idx)
		if idx >= loadout.size():
			item.visible = false
			continue

		item.visible = true
		item.set_potion(loadout[idx])
		item.set_key(idx + 1)
		if idx == current_selected:
			item.set_active(true)

func _on_potion_ammo_changed(idx: int, value: int):
	get_child(idx).set_ammo(value)

func _on_potion_selected(idx: int):
	if current_selected == idx:
		return
	if current_selected != null:
		get_child(current_selected).set_active(false)

	get_child(idx).set_active(true)
	current_selected = idx
