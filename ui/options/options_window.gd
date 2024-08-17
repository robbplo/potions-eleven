extends Control

func _ready():
	$Panel/CenterContainer/VBoxContainer/MusicVolume/MusicVolumeSlider.value = 0.8
	$Panel/CenterContainer/VBoxContainer/SFXVolume/SFXVolumeSlider.value = 0.8

	$Panel/CenterContainer/VBoxContainer/MusicVolume/MusicVolumeSlider.value_changed.connect(set_global_music_volume)
	$Panel/CenterContainer/VBoxContainer/SFXVolume/SFXVolumeSlider.value_changed.connect(set_global_sfx_volume)

func _on_button_button_up():
	visible = false
	SfxMixer.click_2()

func set_global_music_volume(new_volume: float):
	AudioServer.set_bus_volume_db(1, linear_to_db(new_volume))

func set_global_sfx_volume(new_volume: float):
	AudioServer.set_bus_volume_db(2, linear_to_db(new_volume))
	AudioServer.set_bus_volume_db(3, linear_to_db(new_volume))
	SfxMixer.click_2()
