# SignalManager.gd
# WIP Global Signal Handler for Far Nodes communication
## TODO: make it a singleton?

extends Node

signal AskDealer
signal PassTurn
signal CardGiven

var IsConnected : bool = false

func Connect(SignalName : StringName, callable : Callable):
	if is_connected(SignalName, callable):
		return
	connect(SignalName, callable)

func Disconnect(SignalName : StringName, callable : Callable):
	if !is_connected(SignalName, callable):
		return
	disconnect(SignalName, callable)
