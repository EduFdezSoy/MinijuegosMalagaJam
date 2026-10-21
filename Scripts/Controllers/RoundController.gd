extends Node
class_name RoundController

# Escenas disponibles para jugar
@export var availableMinigames: Array[PackedScene] = []

# Cantidad de minijuegos que se jugarán en esta ronda
@export_range(1, 100) var winsNeededToFinish: int = 5

# Las escenas de minijuegos que se jugarán en la ronda
var scenesInRound: Array[PackedScene] = []

var currentMinigame: int = 0

func _ready() -> void:
	PlayersController.Initialize()
	SceneManager.InitializeSceneManager(self)
	MinigamesController.StartMinigameController(self)
	InputController.GameInitialized = false

func CreateRound() -> void:
	scenesInRound.clear()

	if availableMinigames.is_empty():
		push_error("No hay minijuegos!")
		return

	# Creamos una copia para no cambiar la lista original
	var shuffledMinigames: Array[PackedScene] = availableMinigames.duplicate()

	shuffledMinigames.shuffle()

	scenesInRound = shuffledMinigames

	print("Ronda generada:")

	for i in range(scenesInRound.size()):
		print("Minijuego ", i + 1, ": ", scenesInRound[i].resource_path)

func NextMinigame() -> void:
	currentMinigame += 1
	if currentMinigame >= scenesInRound.size():
		currentMinigame = 0

func IsRoundFinish() -> bool:
	var maxWins: int = ScoreManager.GetHigherWins()
	return maxWins >= winsNeededToFinish

func GetCurrentMinigame() -> PackedScene:
	return scenesInRound[currentMinigame]
