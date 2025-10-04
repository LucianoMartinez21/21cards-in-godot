# Globals.gd
# All generic global flags go here. ~Starmancy
extends Node

# Enables Developer Console. Toggled with the ` key. 
var console_commands := {}
const gameVersion: String = "Prototype v0.1.5a"
const engineVersion: String = "Godot Engine v4.5.stable.official.77dcf97d8"

## DICE RNG VARIABLES
@warning_ignore("unused_private_class_variable")
var _RNG = RandomNumberGenerator.new()
@warning_ignore("unused_private_class_variable")
var _State
var _Seed

const TWO_SIDE_DICE : int = 2 
const FOUR_SIDE_DICE : int = 4
const SIX_SIDE_DICE : int = 6
const EIGHT_SIDE_DICE : int = 8
const TEN_SIDE_DICE : int = 10
const TWELVE_SIDE_DICE : int = 12
const TWENTY_SIDE_DICE : int = 20
const HUNDRED_SIDE_DICE : int = 100

var PlayerList: Array 

## Screen Configuraitons
var VSync : bool = false
var FullScreen: bool = false
### Resolution: R, Width: W, Height: H
var ResolutionListOptions: Dictionary = {
	"R_W640xH360": 		Vector2i(640, 360),
	"R_W854xH480": 		Vector2i(854, 480),
	"R_W960xH540": 		Vector2i(960, 540),
	"R_W1280xH720": 	Vector2i(1280, 720),
	"R_W1366xH768": 	Vector2i(1366, 768),
	"R_W1600xH900": 	Vector2i(1600, 900),
	"R_W1920xH1080": 	Vector2i(1920, 1080),
	"R_W2560xH1440": 	Vector2i(2560, 1440),
	"R_W3200xH1800": 	Vector2i(3200, 1800),
	"R_W3840xH2160": 	Vector2i(3840, 2160),
	"R_W5120xH2880": 	Vector2i(5120, 2880),
	"R_W7680xH4320": 	Vector2i(7680, 4320),
}
var ResolutionKeyIndex: String = "R_W640xH360"


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.
	
## DEBUG FUNCTIONS
func _GetSeed() -> void:
	print(_Seed)

func _FindClosestAlgorithm():
	var CloseAprox = PlayerList[0].RealScore
	for i in range(1, len(PlayerList)):
		if abs(PlayerList[i].RealScore - Rules.SCORELIMIT) <= abs(CloseAprox - Rules.SCORELIMIT):
			CloseAprox = PlayerList[i].RealScore
	return CloseAprox
		
	
