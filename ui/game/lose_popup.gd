extends Panel

func _ready() -> void:
	PlayerStats.player_died.connect(show)
	MissionState.mission_restarted.connect(hide)

func _on_retry_button_pressed() -> void:
	MissionState.restart_mission()

func _on_back_button_pressed() -> void:
	MissionState.to_main_menu()
