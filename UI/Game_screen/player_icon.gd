extends TextureRect

@onready var image_omelas:Texture2D = load("res://Visual assets/Sprites/Character Icons/OMELAS.png")
@onready var image_anor_londo:Texture2D = load("res://Visual assets/Sprites/Character Icons/ANOR_LONDO.png")
@onready var image_stormwind:Texture2D = load("res://Visual assets/Sprites/Character Icons/STORMWIND.png")
@onready var image_menzoberranzan:Texture2D = load("res://Visual assets/Sprites/Character Icons/MENZOBERRANZAN.png")

@onready var image_atuan:Texture2D = load("res://Visual assets/Sprites/Character Icons/ATUAN.png")
@onready var image_rapture:Texture2D = load("res://Visual assets/Sprites/Character Icons/RAPTURE.png")
@onready var image_rivendell:Texture2D = load("res://Visual assets/Sprites/Character Icons/RIVENDELL.png")
@onready var image_gormenghast:Texture2D = load("res://Visual assets/Sprites/Character Icons/GORMENGHAST.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match MissionState.selected_character:
		"OMELAS":
			texture = image_omelas
			
		"ANOR LONDO":
			texture = image_anor_londo
			
		"STORMWIND":
			texture = image_stormwind
			
		"MENZOBERRANZAN":
			texture = image_menzoberranzan
			
		"ATUAN":
			texture = image_atuan
			
		"RAPTURE":
			texture = image_rapture
			
		"RIVENDELL":
			texture = image_rivendell
			
		"GORMENGHAST":
			texture = image_gormenghast
