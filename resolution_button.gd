extends OptionButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_item_selected(index):
	match index:
		0: 
			DisplayServer.window_set_size(Vector2i(1920,1080))
			#DisplayServer.scale
		1: DisplayServer.window_set_size(Vector2i(1600,800))
		2: DisplayServer.window_set_size(Vector2i(1280,720))
		
