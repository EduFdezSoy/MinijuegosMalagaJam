extends Node2D

@export_range(1,4) var playerId: int = 1

@onready var playerController = get_node("../PlayersController")
	
var playerSelected: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var action_name := "p%d_button" % playerId
	if Input.is_action_just_pressed(action_name):
		PlayerButtonPressed()
	

func PlayerButtonPressed() -> void:
	if(!playerSelected):
		playerController.PlayerSelect(playerId)
		playerSelected = true
		var target_scale = Vector2(1.2, 1.2) 
		scale = target_scale
	else:
		print("Jugador ",playerId, " ha pulsado el botón")
