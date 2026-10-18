extends Node
@onready var roundController = get_node("../RoundController")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(!InputController.GameInitialized and  Input.is_action_just_pressed("start_button") and (PlayersController.GetPlayersCount() > 1)):
		roundController.CreateRound()
		ScoreManager.InitializeScores(PlayersController.GetCurrentPlayersIds())
		#Añadir espera para la transición
		InputController.GameInitialized = true
		SceneManager.LoadCurrentMinigame(roundController)
		PlayersController.SetPlayerButtonsState(false)
		print("Empieza el juego")
