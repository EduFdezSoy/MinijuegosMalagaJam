extends MinigameBase
class_name MinigameLunchTime
@export var foodChecker: FoodChecker

func OnMinigameStarted() -> void:
	foodChecker.Initialize(self)

func GameEnded(winner:int)-> void:
	ScoreManager.AddVictoryToPlayer(winner)
	#Hace que no pueda recibir más input el minijuego
	StopMinigame()
	await get_tree().create_timer(1).timeout
	TransitionToNextMinigame()

func OnPlayerPressed(playerId: int) -> void:
	foodChecker.PlayerPressedButton(playerId)
	if not foodChecker.IsPlayerEliminated(playerId):
		activePlayerIds.erase(playerId)
		
