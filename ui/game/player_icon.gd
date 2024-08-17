extends TextureRect

@onready var image_omelas:Texture2D = load("res://visuals/sprites/characters/player/omelas.png")
@onready var image_anor_londo:Texture2D = load("res://visuals/sprites/characters/player/anor_londo.png")
@onready var image_stormwind:Texture2D = load("res://visuals/sprites/characters/player/stormwind.png")
@onready var image_menzoberranzan:Texture2D = load("res://visuals/sprites/characters/player/menzoberranzan.png")
@onready var image_atuan:Texture2D = load("res://visuals/sprites/characters/player/atuan.png")
@onready var image_rapture:Texture2D = load("res://visuals/sprites/characters/player/rapture.png")
@onready var image_rivendell:Texture2D = load("res://visuals/sprites/characters/player/rivendell.png")
@onready var image_gormenghast:Texture2D = load("res://visuals/sprites/characters/player/gormenghast.png")

func _ready() -> void:
	MissionState.character_selected.connect(set_icon)

func set_icon(character: String):
	match character:
		"omelas": texture = image_omelas
		"ANOR LONDO": texture = image_anor_londo
		"stormwind": texture = image_stormwind
		"menzoberranzan": texture = image_menzoberranzan
		"atuan": texture = image_atuan
		"rapture": texture = image_rapture
		"rivendell": texture = image_rivendell
		"gormenghast": texture = image_gormenghast
