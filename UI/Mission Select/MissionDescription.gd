extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	match MissionState.selected_mission:
		"XANTHOSIS":
			text = "XANTHOSIS"
			_set_global_BBCode()
			
		"NEWT'S CRYSTAL":
			text = "NEWT'S CRYSTAL"
			_set_global_BBCode()
		
		"VOID LABORATORY":
			text = "VOID LABORATORY"
			_set_global_BBCode()
		
		"ANIMI":
			text = "ANIMI"
			_set_global_BBCode()
			
		"TUTORIAL":
			text = "TUTORIAL"
			_set_global_BBCode()

func _set_global_BBCode():
	text = "[center]" + text + "[/center]"
