extends Node2D
func ready():
	pass

signal PlayerOverStockpile
signal PlayerOverWastepile

var PlayerTurn: bool = false

var PileUserOptionConsideration: int = 0

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	#if PlayerTurn:
	#	HandleLogic()
	pass



func HandleLogic():
	if PileUserOptionConsideration == CompleteDeck.PileOptions.Taken:
		return

	if Input.is_action_just_released("left_action"):
		TextureShader.ApplyShader($Stockpile, "Shining")
		TextureShader.UnapplyShader($Card/Sprite2D)
		PileUserOptionConsideration = CompleteDeck.PileOptions.Stockpile
		
	if Input.is_action_just_released("right_action"):
		TextureShader.ApplyShader($Card/Sprite2D, "Shining")
		TextureShader.UnapplyShader($Stockpile)
		PileUserOptionConsideration = CompleteDeck.PileOptions.Wastepile
		
	if Input.is_action_just_released("primary_action"):
		match PileUserOptionConsideration:
			CompleteDeck.PileOptions.Stockpile:
				emit_signal("PlayerOverStockpile")
			CompleteDeck.PileOptions.Wastepile:
				emit_signal("PlayerOverWastepile")
			CompleteDeck.PileOptions.None:
				return
		TextureShader.UnapplyShader($Stockpile)
		TextureShader.UnapplyShader($Card/Sprite2D)
		PileUserOptionConsideration = CompleteDeck.PileOptions.Taken
		if PileUserOptionConsideration != CompleteDeck.PileOptions.None:
			pass


func _on_player_beginning_grab() -> void:
	$Card.visible = true
	$Card.GetCardFromTheDeck()
	PlayerTurn = true


func _PlaceCardOnWastepile(card: Variant) -> void:
	$Card/Sprite2D.frame = CompleteDeck.__Deck[card]
	#PileUserOptionConsideration = CompleteDeck.PileOptions.None
