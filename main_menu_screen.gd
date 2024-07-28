extends Control

signal button_pressed(button: String)

func _on_play_pressed() -> void:
	button_pressed.emit("Play")
