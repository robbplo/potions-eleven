class_name MenuScreens extends Control

enum Screen {
	MAIN_MENU,
	MISSION_SELECT,
	CHARACTER_SELECT,
	GAME_SCREEN
}

signal go_to_level

var screen_width: int = 2000
var current_screen: Screen = Screen.MAIN_MENU:
	set(value):
		current_screen = value
		move_to_screen(value)

func move_to_screen(screen: Screen):
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", Vector2(-screen_width * screen, position.y) , .6)

func _on_main_menu_button_pressed(button: String) -> void:
	match button:
		"Play": 
			current_screen = Screen.MISSION_SELECT
			SfxMixer.screen_move()
	print(current_screen)

func _on_mission_select_button_pressed(button: String) -> void:
	match button:
		"Prev": 
			current_screen = Screen.MAIN_MENU
			SfxMixer.screen_move()
		"Next": 
			current_screen = Screen.CHARACTER_SELECT
			SfxMixer.screen_move()

func _on_character_select_button_pressed(button: String) -> void:
	match button:
		"Prev": 
			current_screen = Screen.MISSION_SELECT
			SfxMixer.screen_move()
		"Next": 
			current_screen = Screen.GAME_SCREEN
			SfxMixer.screen_move()
			SfxMixer.go_to_level()
			go_to_level.emit()
			
