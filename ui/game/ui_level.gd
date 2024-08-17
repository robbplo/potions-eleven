extends Control

var mission_scene: PackedScene

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_ESCAPE:
		MissionState.paused = !MissionState.paused

func _ready():
	MissionState.mission_restarted.connect(_on_mission_restarted)
	
	_load_animation()
	MusicMixer.heist_song_global_volume = 1.0
	MusicMixer.play_heist_song()
	MusicMixer.heist_song_danger_volume = 0.0
	$Star_background.background_color = Color("160e1b")
	
	_load_selected_level()
	_instantiate_selected_level()

func _load_animation():
	$CircleOverlay.scale = Vector2(5.0, 5.0)
	var tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN)
	tween.tween_property($CircleOverlay, "scale", Vector2(0.0, 0.0) , 1)


func _load_selected_level():
	mission_scene = load(MissionState.get_selected_mission_scene())

func _instantiate_selected_level():
	if not mission_scene:
		push_warning("Level instantiated without loading scene first.")
		_load_selected_level()
	var viewport: SubViewport = $"Main Screen/LevelScreenContainer/LevelScreen/LevelViewport"
	for child in viewport.get_children():
		viewport.remove_child(child)
	viewport.add_child(mission_scene.instantiate())
	MissionState.mission_started.emit()

func _on_mission_restarted():
	_load_animation()
	_instantiate_selected_level()
