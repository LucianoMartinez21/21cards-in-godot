extends HBoxContainer

@onready var ParcialScoreLabel = $ParcialScoreLabel
@onready var RealScoreLabel = $RealScoreLabel

func ChangeText(String_Name: StringName, Text: String):
	if String_Name == "ParcialScoreLabel":
		ParcialScoreLabel.text = "= " + Text
	if String_Name == "RealScoreLabel":
		RealScoreLabel.text = "= " + Text
