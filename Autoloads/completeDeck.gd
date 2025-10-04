extends Node

@onready var __DealersDeck : Array = [
	"A_Trebol", "2_Trebol", "3_Trebol",
	"4_Trebol", "5_Trebol", "6_Trebol",
	"7_Trebol", "8_Trebol", "9_Trebol",
	"10_Trebol", "J_Trebol", "Q_Trebol", "K_Trebol",
	"A_Diamond", "2_Diamond", "3_Diamond",
	"4_Diamond", "5_Diamond", "6_Diamond",
	"7_Diamond", "8_Diamond", "9_Diamond",
	"10_Diamond", "J_Diamond", "Q_Diamond", "K_Diamond",
	"A_Heart", "2_Heart", "3_Heart",
	"4_Heart", "5_Heart", "6_Heart",
	"7_Heart", "8_Heart", "9_Heart",
	"10_Heart", "J_Heart", "Q_Heart", "K_Heart",
	"A_Spade", "2_Spade", "3_Spade",
	"4_Spade", "5_Spade", "6_Spade",
	"7_Spade", "8_Spade", "9_Spade",
	"10_Spade", "J_Spade", "Q_Spade", "K_Spade",
]

@onready var PlayableDeck : Array
@onready var WastePile : Array
func shuffle(card : Array, n : int):
	for i in range(n):
		var r = i + (randi_range(0, 52) % (52 - i))
		var temp = card[i]
		card[i] = card[r]
		card[r] = temp
	PlayableDeck = card
	
func _ready() -> void:
	shuffle(__DealersDeck, 52)


const __Deck : Dictionary = {
	"A_Trebol": 12,
	"2_Trebol": 0,
	"3_Trebol": 1,
	"4_Trebol": 2,
	"5_Trebol": 3,
	"6_Trebol": 4,
	"7_Trebol": 5,
	"8_Trebol": 6,
	"9_Trebol": 7,
	"10_Trebol": 8,
	"J_Trebol": 9,
	"Q_Trebol": 10,
	"K_Trebol": 11,
	"A_Diamond": 25,
	"2_Diamond": 13,
	"3_Diamond": 14,
	"4_Diamond": 15,
	"5_Diamond": 16,
	"6_Diamond": 17,
	"7_Diamond": 18,
	"8_Diamond": 19,
	"9_Diamond": 20,
	"10_Diamond": 21,
	"J_Diamond": 22,
	"Q_Diamond": 23,
	"K_Diamond": 24,
	"A_Heart": 38,
	"2_Heart": 26,
	"3_Heart": 27,
	"4_Heart": 28,
	"5_Heart": 29,
	"6_Heart": 30,
	"7_Heart": 31,
	"8_Heart": 32,
	"9_Heart": 33,
	"10_Heart": 34,
	"J_Heart": 35,
	"Q_Heart": 36,
	"K_Heart": 37,
	"A_Spade": 51,
	"2_Spade": 39,
	"3_Spade": 40,
	"4_Spade": 41,
	"5_Spade": 42,
	"6_Spade": 43,
	"7_Spade": 44,
	"8_Spade": 45,
	"9_Spade": 46,
	"10_Spade": 47,
	"J_Spade": 48,
	"Q_Spade": 49,
	"K_Spade": 50,
	"Joker": 52,
}

const SCORETABLE: Dictionary = {
	"2": 2,
	"3": 3,
	"4": 4,
	"5": 5,
	"6": 6,
	"7": 7,
	"8": 8,
	"9": 9,
	"10": 10,
	"1": 10,
	"J": 10,
	"Q": 10,
	"K": 10,
}

enum PileOptions{
	None,
	Stockpile,
	Wastepile,
	Taken
}

func ScoreBehavior(card: String):
	var Regex = RegEx.new()
	Regex.compile("[23456789]|[10]|[AJKQ]")
	var result: String = Regex.search(card).get_string()
	if result != "A":
		return SCORETABLE.get(result)
	return result
