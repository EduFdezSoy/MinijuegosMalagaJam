extends Node
class_name RoundController

# Escenas disponibles para jugar
@export var availableMinigames: Array[PackedScene] = []

# Cantidad de minijuegos que se jugarán en esta ronda
@export_range(1, 100) var minigamesInTheRound: int = 5

# Las escenas de minijuegos que se jugarán en la ronda
var scenesInRound: Array[PackedScene] = []

var currentMinigame: int = 0

func CreateRound() -> void:
	scenesInRound.clear()

	if availableMinigames.is_empty():
		push_error("No hay minijuegos!")
		return

	if minigamesInTheRound > availableMinigames.size():
		push_error("Has puesto más minijuegos en la ronda de los que hay disponibles")
		return

	# Creamos una copia para no cambiar la lista original
	var shuffledMinigames: Array[PackedScene] = availableMinigames.duplicate()

	shuffledMinigames.shuffle()

	scenesInRound = shuffledMinigames.slice(0, minigamesInTheRound)

	print("Ronda generada:")

	for i in range(scenesInRound.size()):
		print("Minijuego ", i + 1, ": ", scenesInRound[i].resource_path)

func GetCurrentMinigame() -> PackedScene:
	return scenesInRound[currentMinigame]
