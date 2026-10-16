extends Node
@onready var roundController = get_node("../RoundController")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("start_button")):
		roundController.CreateRound()
		#Añadir espera para la transición
		SceneManager.LoadCurrentMinigame(roundController)
