extends Node

var currentMinigame: MinigameBase = null
var roundController: RoundController
var scoreSceneInstance: Node

#Usar esta función justo despues de hacer la transición de salida de un minijuego
func InitializeSceneManager(roundC: RoundController) -> void:
	roundController = roundC
	if is_instance_valid(currentMinigame):
		currentMinigame.queue_free()
		currentMinigame = null
	if is_instance_valid(scoreSceneInstance):
		scoreSceneInstance.queue_free()
		scoreSceneInstance = null
	
func LoadCurrentMinigame() -> void:
	LoadMinigame(roundController.GetCurrentMinigame())


func LoadMinigame(scene: PackedScene) -> void:
	if scene == null:
		push_error("No se ha especificado una escena de minijuego.")
		return

	# Descargar el minijuego anterior.
	if is_instance_valid(currentMinigame):
		currentMinigame.queue_free()
		currentMinigame = null

	currentMinigame = scene.instantiate()

	# Obtener el contenedor de minijuegos de la escena principal.
	var main_scene := get_tree().current_scene
	var container := main_scene.get_node_or_null("MinigameContainer")

	if container == null:
		push_error("No se encuentra MinigameContainer en la escena principal.")
		currentMinigame.queue_free()
		currentMinigame = null
		return

	container.add_child(currentMinigame)
	var playersIds: Array[int] = PlayersController.GetCurrentPlayersIds()
	#El objeto de las escenas debe tener el script heredado de MinigameBase para poder inicializarlo
	currentMinigame.Initialize(playersIds)

func LoadScoreScene() -> void:
	# Descargar el minijuego anterior.
	if is_instance_valid(currentMinigame):
		currentMinigame.queue_free()
		currentMinigame = null
		
	var scoreScene : PackedScene = load("res://Scenes/ScoreScene.tscn")
	scoreSceneInstance = scoreScene.instantiate()
	var main_scene := get_tree().current_scene
	var container := main_scene.get_node_or_null("MinigameContainer")
	container.add_child(scoreSceneInstance)

func UnloadMinigame() -> void:
	if is_instance_valid(currentMinigame):
		currentMinigame.queue_free()

	currentMinigame = null
