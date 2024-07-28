extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match MissionState.selected_mission:
		"XANTHOSIS":
			text = "Get the yellow crystal. It is of utmost importance to our cause."
			_set_global_BBCode()
			
		"NEWT'S CRYSTAL":
			text = "I just like this little ball. Go get it."
			_set_global_BBCode()
		
		"VOID LABORATORY":
			text = "I saw this 'void laboratories' in the papers and thought it sounded neat. go get some of that void for me, okay?"
			_set_global_BBCode()
		
		"ANIMI":
			text = "Apparently, these little guys can bring you back to life. Could be useful."
			_set_global_BBCode()

func _set_global_BBCode():
	text = "[center]" + text + "[/center]"
