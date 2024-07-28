extends Control

signal button_pressed(button: String)

func _on_prev_button_pressed() -> void:
	button_pressed.emit("Prev")

func _on_next_button_pressed() -> void:
	button_pressed.emit("Next")

