extends MinigameBase
class_name MinigameLunchTime
@export var foodChecker: FoodChecker

func OnMinigameStarted() -> void:
	foodChecker.Initialize(self)

func GameEnded(winner:int)-> void:
	ScoreManager.AddScore(winner,1)
	StopMinigame()
	await get_tree().create_timer(1).timeout
	FinishTransition()
	print("Se acabo el juego")
	await get_tree().create_timer(1.5).timeout
	MinigamesController.NextMinigame()
	

func OnPlayerPressed(playerId: int) -> void:
	foodChecker.PlayerPressedButton(playerId)
	if not foodChecker.IsPlayerEliminated(playerId):
		activePlayerIds.erase(playerId)
		
