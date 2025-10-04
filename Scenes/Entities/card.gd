extends Node2D

@onready var counter: int = 0

func next_card():
	$Sprite2D.frame = counter
	counter += 1
	if counter >= 53:
		counter = 0

func GetCardFromTheDeck() -> void:
	var Stuff = CompleteDeck.PlayableDeck.pop_back()
	if Stuff == null:
		return
	HandleAnimation()
	CompleteDeck.WastePile.push_front(Stuff)
	counter = CompleteDeck.__Deck[Stuff]
	$Sprite2D.frame = counter

func HandleAnimation():
	if CompleteDeck.PlayableDeck.size() > 79:
		get_parent().get_node("Stockpile").play("FullDeck")
	if CompleteDeck.PlayableDeck.size() > 52 && CompleteDeck.PlayableDeck.size() < 79:
		get_parent().get_node("Stockpile").play("HalfDeck")
	if CompleteDeck.PlayableDeck.size() < 52:
		get_parent().get_node("Stockpile").play("AlmostEmptyDeck")
	if CompleteDeck.PlayableDeck.size() <= 0:
		get_parent().get_node("Stockpile").play("EmptyDeck")

func BackCard():
	SetCardFrame(53)

func SetCardFrame(Frame: int):
	if Frame >= 0 || Frame <= 53:
		$Sprite2D.frame = Frame

func GetCardFrame():
	return $Sprite2D.frame

func MatchCardFrame(Frame: int) -> bool:
	if Frame >= 0 || Frame <= 53:
		if GetCardFrame() != Frame:
			return false
		return true
	return false 

func _ready() -> void:
	pass
	#GetCardFromTheDeck()
