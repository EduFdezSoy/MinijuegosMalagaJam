extends Node
class_name HorizontalPlayerMovement
@export var players: Array[Node2D]
var activePlayersInGame: Array[int]
var playersPositions: Array[Vector2]
var pendingMovementTime: Array[float] = []
@export var playersInitialXPosition = 30
@export var horizontalMovementPerClick: float = 10
@export var movementDuration: float = 0.2

func SetPlayersPosition(activePlayers: Array[int]) -> void:
	activePlayersInGame = activePlayers
	InitializePlayersPositions(activePlayers.size())
	

func MovePlayer(id: int) -> void:
	var index: int = id

	if index < 0 or index >= players.size():
		return

	if not activePlayersInGame.has(id):
		return

	playersPositions[index].x += horizontalMovementPerClick
	pendingMovementTime[index] += movementDuration

func _process(delta: float) -> void:
	MovePlayersToCurrentPosition(delta)

#Cada frame se mueven los jugadores a la posición que deberían estar, con una velocidad fija
func MovePlayersToCurrentPosition(delta: float) -> void:
	var movementSpeed: float = horizontalMovementPerClick / movementDuration

	for playerNumber in players.size():
		if pendingMovementTime[playerNumber] <= 0.0:
			continue

		var timeToMove: float = minf(delta,pendingMovementTime[playerNumber])

		var distanceToMove: float = movementSpeed * timeToMove

		players[playerNumber].position.x = move_toward(players[playerNumber].position.x,playersPositions[playerNumber].x,distanceToMove)

		pendingMovementTime[playerNumber] -= timeToMove

		if pendingMovementTime[playerNumber] < 0.001:
			pendingMovementTime[playerNumber] = 0.0

#Inicializamos los Node2D de los jugadores
func InitializePlayersPositions(playersNumber:int) -> void:
	var screenSize: Vector2 = DisplayServer.window_get_size()
	var playerScreenSize: float = screenSize.y / playersNumber
	var screenYPosition: float =  + (playerScreenSize / 2.0)
	var screenXPosition: float = playersInitialXPosition

	playersPositions.clear()
	pendingMovementTime.clear()

	playersPositions.resize(players.size())
	pendingMovementTime.resize(players.size())
	pendingMovementTime.fill(0.0)

	for player in range(players.size()):
		if activePlayersInGame.has(player):
			players[player].show()
			players[player].position = Vector2(screenXPosition,screenYPosition)
			screenYPosition += playerScreenSize
			
			playersPositions[player] = players[player].position
		else:
			players[player].hide()
			playersPositions[player] = Vector2.ZERO

func GetPlayerCurrentPositions() -> Array[Vector2]:
	var current_positions: Array[Vector2] = []

	for player in players:
		current_positions.append(player.position)

	return current_positions

func GetPlayersPendingMovementTime() -> Array[float]:
	return pendingMovementTime
