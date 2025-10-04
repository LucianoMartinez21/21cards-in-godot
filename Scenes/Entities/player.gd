extends Entity

@onready var CardOne = $CardHolder/Card
@onready var CardTwo = $CardHolder/Card2
 

func _ready() -> void:
	CardTwo.BackCard()

func _unhandled_input(event: InputEvent) -> void:
	if !PlayerTurn || Rules.ActionIndex == Rules.TurnActions.End_Turn:
		PlayerTurn = false
		return
	if event.is_action_pressed("PrimaryAction"):
		Rules.CardExchange = true
		SignalManager.AskDealer.emit()
		Rules.ActionIndex = Rules.TurnActions.Ask_or_Pass_Cards
		SignalManager.Connect("CardGiven", Callable(GrabCard))
		
	if event.is_action("SecundaryAction"):
		SignalManager.PassTurn.emit()
		PlayerTurn = false
		Rules.ActionIndex = Rules.TurnActions.End_Turn
		CardTwo.SetCardFrame(CompleteDeck.__Deck.get(self.PersonalDeck[1]))
		#SignalManager.Disconnect("CardGiven", Callable(self, "GrabCard"))

	if event.is_action_pressed("TertiaryAction"):
		Rules.ActionIndex = Rules.TurnActions.Check_Cards
		CardTwo.SetCardFrame(CompleteDeck.__Deck.get(self.PersonalDeck[1]))
	if event.is_action_released("TertiaryAction"):
		Rules.ActionIndex = Rules.TurnActions.Ask_or_Pass_Cards
		CardTwo.BackCard()

func _process(delta: float) -> void:
	if !PlayerTurn && Rules.ActionIndex != Rules.TurnActions.End_Turn: 
		SignalManager.Connect("PassTurn", Callable(self, "_CheckGetTurn"))
		return
	CardOne.SetCardFrame(CompleteDeck.__Deck.get(self.PersonalDeck[0]))
	PartialScoreCalculation()
	CardTypeADecision()
	DealWithUI()
	

func _CheckGetTurn():
	PlayerTurn = true
	await get_tree().create_timer(1).timeout
	var ClearHolder = get_node("/root/Main")._GetCardsHolder()
	for Item in ClearHolder.get_children():
		Item.queue_free()

func GrabCard(card):
	self.PersonalDeck.append(card)
	

func DealWithUI():
	var PlayerGUI = GUI.GetPlayerUI()
	PlayerGUI.ChangeText("ParcialScoreLabel", str(self.PartialScore))
	PlayerGUI.ChangeText("RealScoreLabel", str(self.RealScore))
	#print(ClearHolder.get_children())
	

func RealScoreCalculation():
	if RealScore < FloorScore:
		pass
