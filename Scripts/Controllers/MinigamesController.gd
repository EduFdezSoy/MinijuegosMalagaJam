extends Node

var currentMinigame: int
var roundController: RoundController

func StartMinigameController(roundC: RoundController) -> void:
	roundController = roundC

func NextMinigame() -> void:
	roundController.NextMinigame()
	if(roundController.IsRoundFinish()):
		print("Se acabó la ronda")
	else:
		SceneManager.LoadCurrentMinigame()
	
