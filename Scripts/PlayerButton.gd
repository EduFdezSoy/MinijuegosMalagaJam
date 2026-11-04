extends Node2D
class_name PlayerButton

@export_range(0,3) var playerId: int = 0
var playerSelected: bool = false
var buttonState: bool = true

func _ready() -> void:
	if not PlayersController.PlayerSelectionChangeState.is_connected(SetButtonState):
			PlayersController.PlayerSelectionChangeState.connect(SetButtonState)
	SetButtonState(true)
	
	
func ButtonPressed(playerIdPressed: int) -> void:
	if(playerIdPressed == playerId):
		PlayerButtonPressed()

func SetButtonState(state:bool) -> void:
	buttonState = state
	print("Se ha puesto el estado del botón en: ", state)
	if(buttonState):
		show()
		if not InputController.playerButtonPressed.is_connected(ButtonPressed):
			InputController.playerButtonPressed.connect(ButtonPressed)
			
	else:
		hide()
		if InputController.playerButtonPressed.is_connected(ButtonPressed):
			InputController.playerButtonPressed.disconnect(ButtonPressed)
			

func PlayerButtonPressed() -> void:
	if(not playerSelected):
		PlayersController.PlayerSelect(playerId)
		playerSelected = true
		var target_scale = Vector2(1.2, 1.2) 
		scale = target_scale
		print("Jugador ",playerId, " ha pulsado el botón en el inicio")
	else:
		print("Jugador ",playerId, " ha pulsado el botón en el inicio")
