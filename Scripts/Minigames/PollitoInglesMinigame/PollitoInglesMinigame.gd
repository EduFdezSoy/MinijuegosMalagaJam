extends MinigameBase

var playerPresses: Dictionary[int, int] = {}
@export var playersHorizontalMove: HorizontalPlayerMovement
@export var pollitoInglesCheck: PollitoInglesCheck

func OnMinigameStarted() -> void:
	for player_id in activePlayerIds:
		playerPresses[player_id] = 0
		
	playersHorizontalMove.SetPlayersPosition(activePlayerIds)
	pollitoInglesCheck.StartGame(playersHorizontalMove)
	if not pollitoInglesCheck.gameFinished.is_connected(GameEnded):
		pollitoInglesCheck.gameFinished.connect(GameEnded)

func GameEnded(winner:int)-> void:
	ScoreManager.AddScore(winner,1)
	StopMinigame()
	print("Se acabo el juego")
	await get_tree().create_timer(2).timeout
	MinigamesController.NextMinigame()
	

func OnPlayerPressed(playerId: int) -> void:
	playerPresses[playerId] += 1
	playersHorizontalMove.MovePlayer(playerId)
