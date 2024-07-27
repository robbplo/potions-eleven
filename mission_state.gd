extends TextureButton

enum Screen {
	MAIN_MENU, 
	MISSION_SELECT, 
	CHARACTER_SELECT, 
	GAME_SCREEN
}

var selected_mission: String :set =set_mission
var selected_character: String :set =set_character
var current_screen: Screen = Screen.MAIN_MENU
var is_pressed: bool = false



func set_mission(mission_name: String):
	selected_mission = mission_name
	
func set_character(character_name: String):
	selected_character = character_name
	
func set_current_screen(screen: Screen):
	current_screen = screen
