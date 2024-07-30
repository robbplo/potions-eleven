extends Panel

func _ready() -> void:
	PlayerStats.player_died.connect(show)

func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_back_button_pressed() -> void:
	MusicMixer.stop_heist_song()
	get_tree().change_scene_to_file("res://Menu_screens.tscn")
