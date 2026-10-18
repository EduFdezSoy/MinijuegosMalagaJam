
class_name MinigameBase
extends Node2D

# Se emite cuando termina el minijuego.
signal minigameFinished(results: Dictionary)

# Identificadores de los jugadores que participan.
var activePlayerIds: Array[int] = []

var minigameEnabled: bool = false


# Inicializa el minijuego con los jugadores
func Initialize(players: Array[int]) -> void:
	activePlayerIds = players.duplicate()

	if not InputController.playerButtonPressed.is_connected(
		OnInputPlayerPressed
	):
		InputController.playerButtonPressed.connect(
			OnInputPlayerPressed
		)

	minigameEnabled = true
	OnMinigameStarted()


# Para heredar en otras clases y setear lo que necesite el minijuego
func OnMinigameStarted() -> void:
	pass


# Detecta cuando se pulsan los botones y filtra para no pillar botones de personas que no estén jugando
func OnInputPlayerPressed(playerId: int) -> void:
	if not minigameEnabled:
		return

	if not activePlayerIds.has(playerId):
		return

	OnPlayerPressed(playerId)


# Cada minijuego implementará que pasa cuando se pulsa el botón de cada jugador
func OnPlayerPressed(playerId: int) -> void:
	pass


# Termina el minijuego y emite la signal
func FinishMinigame(results: Dictionary) -> void:
	if not minigameEnabled:
		return

	minigameEnabled = false
	minigameFinished.emit(results)


func StopMinigame() -> void:
	minigameEnabled = false
