
class_name MinigameBase
extends Node2D

# Se emite cuando termina el minijuego
signal minigameFinished(results: Dictionary)

# Ids de los jugadores actuales
var activePlayerIds: Array[int] = []

var minigameEnabled: bool = false
var minigameTutorial: MinigamePreviewController
@export var minigameData: MinigameData


# Inicializa el minijuego con los jugadores
func Initialize(players: Array[int]) -> void:
	activePlayerIds = players.duplicate()

	if not InputController.playerButtonPressed.is_connected(OnInputPlayerPressed):
		InputController.playerButtonPressed.connect(OnInputPlayerPressed)

	ShowGameTutorialBeforeStart()

func ShowGameTutorialBeforeStart() -> void:
	var tutorialPrefab = load("res://Scenes/MinigamePreview.tscn") as PackedScene
	minigameTutorial = tutorialPrefab.instantiate()
	add_child(minigameTutorial)
	minigameTutorial.z_index = 10
	minigameTutorial.Initialize(self,minigameData)

func HideGameTutorialAndStart() -> void:
	minigameTutorial.hide()
	TransitionController.MakeTransition(0,.3)
	await get_tree().create_timer(1).timeout
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

func TransitionToNextMinigame() -> void:
	TransitionController.MakeTransition(1,0.4)
	await get_tree().create_timer(1.5).timeout
	MinigamesController.NextMinigame()


func StopMinigame() -> void:
	minigameEnabled = false
	if InputController.playerButtonPressed.is_connected(OnInputPlayerPressed):
		InputController.playerButtonPressed.disconnect(OnInputPlayerPressed)
