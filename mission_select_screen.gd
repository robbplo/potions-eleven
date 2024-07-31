extends Control

signal button_pressed(button: String)

func _process(delta):
	if MissionState.selected_mission:
		$CenterContainer/VBoxContainer/Panel2/Description/NextButton.disabled = false
	else: 
		$CenterContainer/VBoxContainer/Panel2/Description/NextButton.disabled = true

func _on_prev_button_pressed() -> void:
	button_pressed.emit("Prev")

func _on_next_button_pressed() -> void:
	button_pressed.emit("Next")
