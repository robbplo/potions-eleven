extends Panel

func _ready() -> void:
	PlayerStats.objective_extracted.connect(show)

func _on_button_pressed() -> void:
	MusicMixer.stop_heist_song()
	get_tree().change_scene_to_file("res://Menu_screens.tscn")
