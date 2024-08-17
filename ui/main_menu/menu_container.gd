extends CenterContainer

@onready var button_options: TextureButton = $ScreenItems/MenuItems/Option
@onready var button_credits: TextureButton = $ScreenItems/MenuItems/Credits
@onready var button_quit: TextureButton = $ScreenItems/MenuItems/Quit

@onready var window_options: Control = $OptionsWindow
@onready var window_credits: Control = $CreditsWindow

# Called when the node enters the scene tree for the first time.
func _ready():
	window_options.visible = false
	window_credits.visible = false

	button_options.button_down.connect(_options_window)
	button_credits.button_down.connect(_credits_window)
	button_quit.button_down.connect(_quit)

func _options_window():
	window_options.visible = true

func _credits_window():
	window_credits.visible = true

func _quit():
	get_tree().quit()
