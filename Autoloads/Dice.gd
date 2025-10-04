#Dice.gd
#Prototype of a dice ~Wakler

extends Node

#Initialize the Random Number Generator
func initialize() -> void:
	Globals._RNG.randomize()
	Globals._State = Globals._RNG.state
	Globals._Seed = Globals._RNG.seed

## ROLL DICE FUNCTIONS
func RollDice(Sides: int) -> int: return Globals._RNG.randi_range(1, Sides)
func RollD2() -> int: return RollDice(Globals.TWO_SIDE_DICE)
func RollD4() -> int: return RollDice(Globals.FOUR_SIDE_DICE)
func RollD6() -> int: return RollDice(Globals.SIX_SIDE_DICE)
func RollD8() -> int: return RollDice(Globals.EIGHT_SIDE_DICE)
func RollD10() -> int: return RollDice(Globals.TEN_SIDE_DICE)
func RollD12() -> int: return RollDice(Globals.TWELVE_SIDE_DICE)
func RollD20() -> int: return RollDice(Globals.TWENTY_SIDE_DICE)
func RollD100() -> int: return RollDice(Globals.HUNDRED_SIDE_DICE)
func RollRangeDice(MinNumber: int, MaxNumber: int) -> int: return Globals._RNG.randi_range(MinNumber, MaxNumber)
