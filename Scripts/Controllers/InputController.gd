extends Node

signal playerButtonPressed(playerId: int)
var GameInitialized: bool = false

const PLAYER_ACTIONS := {
	1: "p1_button",
	2: "p2_button",
	3: "p3_button",
	4: "p4_button"
}

func _process(_delta: float) -> void:
	for playerId in PLAYER_ACTIONS:
		var action: String = PLAYER_ACTIONS[playerId]

		if Input.is_action_just_pressed(action):
			playerButtonPressed.emit(playerId)
