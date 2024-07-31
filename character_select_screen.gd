extends Control

signal button_pressed(button: String)

func _process(delta):
	if MissionState.selected_character:
		$CenterContainer/VBoxContainer/Panel2/NextButton.disabled = false
	else:
		$CenterContainer/VBoxContainer/Panel2/NextButton.disabled = true

func _on_prev_button_pressed() -> void:
	button_pressed.emit("Prev")

func _on_next_button_pressed() -> void:
	button_pressed.emit("Next")
