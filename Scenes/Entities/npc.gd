extends Entity

@onready var CardOne = $CardHolder/Card
@onready var CardTwo = $CardHolder/Card2

@onready var NPCIndexActions = Rules.TurnActions.Ask_or_Pass_Cards

##DEALER LOGIC
func _ready() -> void:
	if NPCBehavior == 1:
		CardOne.BackCard()
	CardTwo.BackCard()
	

func _process(delta: float) -> void:
	match NPCBehavior:
		0:
			NpcLogic()
		1:
			DealerLogic()

## DEALER BEHAVIOR LOGIC
func DealerLogic():
	if NPCBehavior != 1:
		return
	match Rules.DealerActionIndex:
		Rules.TurnActionsDealer.Initial_Delivery:
			for Player in Globals.PlayerList:
				for i in range(2):
					Player.PersonalDeck.append(CompleteDeck.__DealersDeck.pop_back())
				Player.visible = true
			for i in range(2):
				self.PersonalDeck.append(CompleteDeck.__DealersDeck.pop_back())
			Globals.PlayerList[1].PlayerTurn = true
			Rules.DealerActionIndex += 1
		Rules.TurnActionsDealer.Consultation_Players:
			SignalManager.Connect("AskDealer", Callable(self, "DeliverCards"))
			if !Globals.PlayerList[0].PlayerTurn and !Globals.PlayerList[1].PlayerTurn:
					Rules.DealerActionIndex += 1
					self.PlayerTurn = true
		Rules.TurnActionsDealer.Dealer_Playing:
			CardTypeADecision()
			var NewCard = CompleteDeck.__DealersDeck.pop_back()
			var NewScene = load("res://Scenes/Entities/Card.tscn").instantiate()
			NewScene.SetCardFrame(CompleteDeck.__Deck.get(NewCard))
			get_parent().get_node("CardsHolder").add_spacer(true)
			get_parent().get_node("CardsHolder").get_child(0).add_child(NewScene)
			self.PersonalDeck.append(NewCard)
			
			if self.RealScore > Rules.SCORELIMIT:
				print("Dealer LOST")
				CardTwo.SetCardFrame(CompleteDeck.__Deck.get(self.PersonalDeck[1]))
				CardOne.SetCardFrame(CompleteDeck.__Deck.get(self.PersonalDeck[0]))
				Rules.DealerActionIndex += 1
				PlayerTurn = false
				Globals.PlayerList.append(self)
		Rules.TurnActionsDealer.End_Turn:
			for Player in Globals.PlayerList:
				print(Player.RealScore)
				if Player.RealScore == Rules.SCORELIMIT:
					print("Player: {}, win with {}".format([Player, Player.RealScore],"{}"))
					return
			print("The closest one was {}".format([Globals._FindClosestAlgorithm()], "{}"))

func DeliverCards():
	if !Rules.CardExchange:
		await get_tree().create_timer(1).timeout
		return
	var NewCard = CompleteDeck.__DealersDeck.pop_back()
	var NewScene = load("res://Scenes/Entities/Card.tscn").instantiate()
	NewScene.SetCardFrame(CompleteDeck.__Deck.get(NewCard))
	get_parent().get_node("CardsHolder").add_spacer(true)
	get_parent().get_node("CardsHolder").get_child(0).add_child(NewScene)
	SignalManager.CardGiven.emit(NewCard)
	Rules.CardExchange = false
	#SignalManager.Disconnect("AskDealer", Callable(self, "DeliverCards"))
	
	

## NORMAL NPC BEHAVIOR LOGIC
func NpcLogic():
	if NPCBehavior != 0 || NPCIndexActions == Rules.TurnActions.End_Turn:
		return
	if !PlayerTurn:
		return
		
	CardOne.SetCardFrame(CompleteDeck.__Deck.get(self.PersonalDeck[0]))
	CardTypeADecision()
	PartialScoreCalculation()
	
	if self.RealScore > Rules.SCORELIMIT:
		print("NPC LOST")
		CardTwo.SetCardFrame(CompleteDeck.__Deck.get(self.PersonalDeck[1]))
		SignalManager.PassTurn.emit()
		SignalManager.Disconnect("CardGiven", Callable(self, "GrabCard"))
		NPCIndexActions = Rules.TurnActions.End_Turn
		PlayerTurn = false

	if self.RealScore < self.FloorScore:
		Rules.CardExchange = true
		SignalManager.AskDealer.emit()
		SignalManager.Connect("CardGiven", Callable(self, "GrabCard"))
	elif self.RealScore > self.FloorScore:
		var LuckyAttempt = Dice.RollD2()
		if LuckyAttempt == 1:
			Rules.CardExchange = true
			SignalManager.AskDealer.emit()
			SignalManager.Connect("CardGiven", Callable(self, "GrabCard"))
		else:
			SignalManager.PassTurn.emit()
			SignalManager.Disconnect("CardGiven", Callable(self, "GrabCard"))
			NPCIndexActions = Rules.TurnActions.End_Turn
			PlayerTurn = false
	
	
func GrabCard(card):
	self.PersonalDeck.append(card)
