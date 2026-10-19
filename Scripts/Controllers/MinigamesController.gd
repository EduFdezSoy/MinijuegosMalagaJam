extends Node

var roundController: RoundController

func StartMinigameController(roundC: RoundController) -> void:
	roundController = roundC

func NextMinigame() -> void:
	roundController.NextMinigame()
	if(roundController.IsRoundFinish()):
		print("Se acabó la ronda")
		# Mostrar pantalla de resultados
		SceneManager.LoadScoreScene()
	else:
		SceneManager.LoadCurrentMinigame()
	
