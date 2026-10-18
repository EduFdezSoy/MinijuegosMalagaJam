extends Node
@onready var roundController = get_node("../RoundController")
@onready var playerController = get_node("../PlayersController")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("start_button") and (playerController.GetPlayersCount() > 1)):
		roundController.CreateRound()
		ScoreManager.InitializeScores(playerController.GetCurrentPlayersIds())
		#Añadir espera para la transición
		SceneManager.LoadCurrentMinigame(roundController)
