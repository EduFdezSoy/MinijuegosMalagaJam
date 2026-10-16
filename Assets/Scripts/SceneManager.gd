extends Node

var currentMinigame: Node = null

#Usar esta función justo despues de hacer la transición de salida de un minijuego
func LoadCurrentMinigame(roundController: RoundController) -> void:
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


func UnloadMinigame() -> void:
	if is_instance_valid(currentMinigame):
		currentMinigame.queue_free()

	currentMinigame = null
