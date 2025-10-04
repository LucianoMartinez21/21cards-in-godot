extends Node2D
class_name Entity
@export_enum("Player", "Dealer") var NPCBehavior

var PartialScore: int = 0
var RealScore: int = 0

# Set the bare limit to achieve, if that limit is surpased the npc will roll dices to go far beyond 
var FloorScore: int = Dice.RollRangeDice(18, 21)

@onready var PlayerTurn: bool = false


@onready var PersonalDeck: Array = []


func PartialScoreCalculation():
	var ScoreCalculation = 0
	for Idx in self.PersonalDeck:
		var result = CompleteDeck.ScoreBehavior(Idx)
		if is_instance_of(result, TYPE_INT) and Idx != self.PersonalDeck[1]:
			ScoreCalculation += result
	self.PartialScore = ScoreCalculation

func CardTypeADecision():
	var ScoreCalculation: int = 0
	for Idx in self.PersonalDeck:
		var result = CompleteDeck.ScoreBehavior(Idx)
		if is_instance_of(result, TYPE_INT):
			ScoreCalculation += result
		if is_instance_of(result, TYPE_STRING):
			if self.RealScore < self.FloorScore and self.RealScore + 11 < Rules.SCORELIMIT:
				ScoreCalculation += 11
			elif self.RealScore > self.FloorScore:
				ScoreCalculation += 1
	self.RealScore = ScoreCalculation
