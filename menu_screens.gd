extends Control


func _ready():
	MusicMixer.play_menu_song_with_riser()
	MusicMixer.menu_song_volume = 1.0
	$Star_background.background_color = Color("fffef7")
	$Menu_Mover/Panel/crystal_ball_container/TextureRect.scale = Vector2(0.0, 0.0)
	$Menu_Mover/Panel/crystal_ball_container/SubViewportContainer.scale = Vector2(0.0, 0.0)
	$Menu_Mover/Panel/crystal_ball_container/TextureRect2.scale =  Vector2(0.0, 0.0)
func _process(delta):
	pass


func _on_menu_mover_go_to_level():
	print("moving to level")
	var tween_music = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC)
	tween_music.tween_property(MusicMixer, "menu_song_volume", 0.0, 3)
	
	var tween_bg = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR).set_parallel(true)
	tween_bg.tween_interval(2)
	tween_bg.tween_property($Star_background, "background_color", Color("160e1b"), 2.0)
	
	var tween_ball = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC).set_parallel(true)
	tween_ball.tween_property($Menu_Mover/Panel/crystal_ball_container/TextureRect, "scale", Vector2(0.83, 0.83), 1.7)
	tween_ball.tween_property($Menu_Mover/Panel/crystal_ball_container/SubViewportContainer, "scale", Vector2(1.0, 1.0), 1.7)
	tween_ball.set_parallel(false)
	tween_ball.tween_property($Menu_Mover/Panel/crystal_ball_container/TextureRect, "modulate", Color("ffffff", 0.0), 1.5)
	tween_ball.set_ease(Tween.EASE_IN)
	tween_ball.tween_property($Menu_Mover/Panel/crystal_ball_container/SubViewportContainer, "scale", Vector2(5.0, 5.0), 1)
	
	var tween_mask = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC).set_parallel(false)
	tween_mask.tween_interval(3.5)
	tween_mask.tween_property($Menu_Mover/Panel/crystal_ball_container/TextureRect2, "scale", Vector2(5.0, 5.0), 1.0)
	
	tween_mask.finished.connect(func(): get_tree().change_scene_to_file("res://ui_level.tscn"))
