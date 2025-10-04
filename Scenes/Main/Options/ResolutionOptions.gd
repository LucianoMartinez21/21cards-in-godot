extends VBoxContainer

@onready var ResolutionDropdown = $OptionButton
@onready var FullScreenCheckBox = $FullScreenCheckBox

func _ready() -> void:
	AddResolutionItems()
	ConsistencyCheckButtons()

## Add items in a dropdown list.
func AddResolutionItems() -> void:
	var CurrentResolution = get_window().get_size()
	var ID = 0
	
	for R in Globals.ResolutionListOptions:
		ResolutionDropdown.add_item(R, ID)
		
		if Globals.ResolutionListOptions[R] == CurrentResolution:
			ResolutionDropdown.select(ID)
			
		ID += 1

## Check consistency in settings mode and what is shown on screen.
func ConsistencyCheckButtons():
	var _Window = get_window()
	var Mode = _Window.get_mode()
	
	if Mode == Window.MODE_FULLSCREEN:
		FullScreenCheckBox.set_pressed_no_signal(true)

## Center the window through calculations.
func CenterWindow():
	var CenterScreen = DisplayServer.screen_get_position() + DisplayServer.screen_get_size()/2
	var WindwoSize = get_window().get_size_with_decorations()
	get_window().set_position(CenterScreen-WindwoSize/2)
	
## Signals
func _on_option_button_item_selected(index: int) -> void:
	var ID = ResolutionDropdown.get_item_text(index)
	get_window().set_size(Globals.ResolutionListOptions[ID])
	Globals.ResolutionKeyIndex = ID
	CenterWindow()


func SetResolutionText() -> void:
	ResolutionDropdown.set_text(Globals.ResolutionKeyIndex)

func _on_full_screen_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		get_window().set_mode(Window.MODE_FULLSCREEN)
	else:
		get_window().set_mode(Window.MODE_WINDOWED)
		CenterWindow()
	get_tree().create_timer(.05).timeout.connect(SetResolutionText)
