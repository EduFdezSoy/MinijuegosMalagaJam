extends Node

signal PlayerSelectionChangeState(state: bool)
var activePlayers: Array[bool] = [false, false, false, false]
var activePlayerCount: int = 0


func _ready() -> void:
	SetPlayerButtonsState(true)

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
	print("Jugador %d se ha unido" % index)

func SetPlayerButtonsState(state:bool) -> void:
	PlayerSelectionChangeState.emit(state)

func GetPlayersCount() -> int:
	return activePlayerCount

func GetCurrentPlayersIds() -> Array[int]:

#Preparamos un array con el id de los jugadores
	var playerIds: Array[int] = []
	for playerId in activePlayers.size():
		if(activePlayers[playerId]):
			playerIds.append(playerId + 1)

	return playerIds;
