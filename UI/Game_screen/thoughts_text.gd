extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStats.potion_selected.connect(_potion_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _potion_changed(idx):
	match idx:
		0: text = "Liquid shadow. Gotta be careful not to get it on my clothes"
		1: text = "Are these rock potions enchanted? they throw really fast! ... And they're insanely heavy!"
		2: text = "God I wish these warp potions warped faster. Can't LOS SANTOS just come along with these missions?"
		3: text = "Is this an invisibility potion? no, there's actually nothing there. Huh."
	text = "[typewriter speed=0.01][center]" + text
