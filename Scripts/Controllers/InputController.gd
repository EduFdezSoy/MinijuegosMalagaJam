extends Node

signal playerButtonPressed(playerId: int)
signal playerButtonReleased(playerId: int)
var playerButtonIsBeingPressed : Array[bool]
var GameInitialized: bool = false

const PLAYER_ACTIONS := {
	0: "p1_button",
	1: "p2_button",
	2: "p3_button",
	3: "p4_button"
}

func _process(_delta: float) -> void:
	for playerId in PLAYER_ACTIONS:
		var action: String = PLAYER_ACTIONS[playerId]
		playerButtonIsBeingPressed[playerId] = Input.is_action_pressed(action)
		
		if Input.is_action_just_pressed(action):
			playerButtonPressed.emit(playerId)
		if Input.is_action_just_released(action):
			playerButtonReleased.emit(playerId)
		
