extends CanvasLayer

var GuiComponents = [
	"res://Scenes/Main/Options/OptionSettings.tscn",
	"res://Scenes/Main/PlayerUI/PlayerUI.tscn"
]

func _ready() -> void:
	for Item in GuiComponents:
		var NewScene = load(Item).instantiate()
		add_child(NewScene)
		NewScene.hide()
	get_node_or_null("PlayerUi").visible = true 

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ToggleMenu"):
		var OptionMenu = get_node("OptionSettings")
		OptionMenu.visible = !OptionMenu.visible
		
		if OptionMenu.visible:
			pass
			#OptionMenu.get_node("OptionSettings/HBoxContainer/ResolutionOptions").AddResolutionItems()
			#OptionMenu.get_node("OptionSettings/HBoxContainer/ResolutionOptions").ConsistencyCheckButtons()

func _process(delta: float) -> void:
	pass

func GetPlayerUI():
	return get_node("PlayerUi/HBoxContainer")
