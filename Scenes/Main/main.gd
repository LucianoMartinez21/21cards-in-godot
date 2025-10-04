extends Node2D

var PlayersElements = [
	"res://Scenes/Entities/PLAYER.tscn",
	"res://Scenes/Entities/NPC.tscn"
	
]

func SpawnPlayers() -> void:
	for Item in PlayersElements:
		var NewScene = load(Item).instantiate()
		NewScene.NPCBehavior = Rules.PlayerTypes.Player
		$PlayerToPlace/HBoxContainer.add_spacer(true)
		$PlayerToPlace/HBoxContainer.get_child(0).add_child(NewScene, true)
		NewScene.hide()
		Globals.PlayerList.append(NewScene)
		

func _ready() -> void:
	SpawnPlayers()

func _process(delta: float) -> void:
	pass

func _GetCardsHolder():
	return $CardsHolder
