extends Control

signal button_pressed(button: String)

func _ready() -> void:
	var button := $CenterContainer/VBoxContainer/Panel2/Briefing/NextButton
	button.disabled = true
	MissionState.mission_selected.connect(func(_mission): button.disabled = false)

func _on_prev_button_pressed() -> void:
	button_pressed.emit("Prev")

func _on_next_button_pressed() -> void:
	button_pressed.emit("Next")
