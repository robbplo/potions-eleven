extends Panel

func _ready() -> void:
	MissionState.pause_toggled.connect(set_visible)
	MissionState.mission_restarted.connect(hide)

func _on_restart_button_pressed() -> void:
	MissionState.restart_mission()

func _on_back_button_pressed() -> void:
	MissionState.to_main_menu()
