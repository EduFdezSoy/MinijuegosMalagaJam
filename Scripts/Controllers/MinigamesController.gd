extends Node

var roundController: RoundController
signal MinigamesStarted

func StartMinigames() -> void:
	MinigamesStarted.emit()

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
	
