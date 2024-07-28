extends RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	match MissionState.selected_character:
		"OMELAS":
			text = "Insists they’re actually just a really convincing illusion themselves."
			_add_global_BBCode()
		
		"ANOR LONDO":
			text = "Whenever some mechanical thing is broken and ANOR LONDO takes a look at it, it’s no longer broken. "
			_add_global_BBCode()
		
		"STORMWIND":
			text = "Carving and recarving magic runes takes knowledge and a steady hand. At least one steady hand."
			_add_global_BBCode()
		
		"MENZOBERRANZAN":
			text = "Once spent 3 years pretending to be a healer on a warship so they could cross the vast expanse. Surprisingly few surgeries were fatal."
			_add_global_BBCode()
			
		"ATUAN":
			text = "Love potions are a popular choice among her clientele, and she knows its potency well."
			_add_global_BBCode()
			
		"RAPTURE":
			text = "Prefers a more physical approach to solving problems. His handwriting has gotten much worse since he got his new limbs."
			_add_global_BBCode()
			
		"RIVENDELL":
			text = "A very talented bat that was turned into a human. The trapeze is their favourite. "
			_add_global_BBCode()
			
		"GORMENGHAST":
			text = "GORMENGHAST snuck into hell and ever since hasn’t been as hesitant to take people there."
			_add_global_BBCode()
			
			
func _add_global_BBCode():
	text = "[center]" + text + "[/center]"
