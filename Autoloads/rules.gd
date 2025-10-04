extends Node

## USER ACTIONS
enum TurnActions {
	Check_Cards, # Start turn by checking cards
	Ask_or_Pass_Cards, # Start turn by grabbing a card
	End_Turn
}

## DEALER ACTIONS
enum TurnActionsDealer {
	Initial_Delivery,
	Consultation_Players,
	Dealer_Playing,
	End_Turn
}
var DealerActionIndex: int = TurnActionsDealer.Initial_Delivery
var ActionIndex: int = TurnActions.Check_Cards

## TYPE OF PLAYERS
enum PlayerTypes {
	Player,
	Dealer
}

const SCORELIMIT: int = 21

@onready var CardExchange: bool = false

## GENERAL ACTIONS
### Player and NPC recieve the same sets of cards (2), one visible and the other not
### cards from the range 2-10 represent the values in the range of 2-10, 
### J, Q and K represent the value 10
### A can represent 1 or 11. 
### Player and NPC can keep asking for cards or pass with the dealer.
### Dealer at the end of the round will pull out cards from the pile,
### until they get equal or less than 21 points
### Entities have two score the public score and the real score
### the public score is the score of the visible cards
### the real score is the score of visible and non visible cards.

## WIN/LOSE CONDITIONS
### The entity who reach 21 wins.
### The closest entity to 21 wins, unless the dealer get 21 score or close enough to 21.
### The entity who surpass 21 lose instantly
