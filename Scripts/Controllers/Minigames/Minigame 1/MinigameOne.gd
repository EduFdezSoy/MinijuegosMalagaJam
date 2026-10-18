extends MinigameBase

var playerPresses: Dictionary[int, int] = {}


func OnMinigameStarted() -> void:
	for player_id in activePlayerIds:
		playerPresses[player_id] = 0


func OnPlayerPressed(playerId: int) -> void:
	playerPresses[playerId] += 1

	print(
		"Jugador ", playerId,
		" ha pulsado ", playerPresses[playerId],
        " veces."
	)
func FinishMinigame(results: Dictionary) -> void:
	pass
