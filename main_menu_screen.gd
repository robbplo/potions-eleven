extends Control

func _on_play_gui_input(event:InputEvent) -> void:
	if event is InputEventMouse and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().change_scene_to_file("res://ui_level.tscn")
