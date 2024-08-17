extends RichTextLabel

func _process(_delta):
	match MissionState.selected_mission:
		"XANTHOSIS":
			text = "XANTHOSIS. [code] The [/code] yellow [code] stage. It's stored somewhere at the [/code] far end [code] of this [/code] warehouse.[code] Mind the [/code] guards."
			_set_global_BBCode()

		"NEWT'S CRYSTAL":
			text = "NEWT [code] is one of the best. I can't make crystals quite like they do. but we can [/code] Steal it. [code] the [/code] crystal [code] is somewhere in one of these [/code]rooms. The exit is bottom left."
			_set_global_BBCode()

		"VOID LABORATORY":
			text = "VOID LABORATORY"
			_set_global_BBCode()

		"ANIMI":
			text = "ANIMI"
			_set_global_BBCode()

		"TUTORIAL":
			text = "[code] the two roaming guards might be a problem... [/code]"
			_set_global_BBCode()

func _set_global_BBCode():
	text = "[center]" + text + "[/center]"
