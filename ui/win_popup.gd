extends Panel

func _ready() -> void:
	PlayerStats.objective_extracted.connect(show)

func _on_button_pressed() -> void:
	MissionState.to_main_menu()
