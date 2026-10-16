extends Node
class_name PlayerController

var activePlayers: Array[bool] = [false, false, false, false]
var activePlayerCount: int = 0

func PlayerSelect(playerId: int) -> void:
	var index = playerId -1
	#Para evitar que le lleguen jugadores que no son validos
	if(index < 0 or index >= activePlayers.size()):
		return
	
	#En caso de que ya se haya seleccionado este jugador, return
	if(activePlayers[index]):
		return
		
	activePlayers[index] = true;
	activePlayerCount+=1
	print("Jugador ",index," se ha unido")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
