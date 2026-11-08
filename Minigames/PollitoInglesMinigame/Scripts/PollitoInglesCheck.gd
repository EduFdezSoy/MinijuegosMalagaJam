
extends Node
class_name PollitoInglesCheck

signal playerEliminated(playerId: int)
signal playerWon(playerId: int)
signal gameFinished(winner: int)

@export var spriteCheck: Sprite2D

var playerMovement: HorizontalPlayerMovement
@export var winningXPosition: float = 1000.0

@export var minMovementTime: float = 2.0
@export var maxMovementTime: float = 5.0
@export var minLookingTime: float = 1.0
@export var maxLookingTime: float = 4.0

var gameRunning: bool = false
var isLooking: bool = false

var playersInGame: Array[int] = []
var winners: Array[int] = []
var eliminatedPlayers: Array[int] = []


func StartGame(playerMov: HorizontalPlayerMovement) -> void:
	playerMovement = playerMov
	
	playersInGame = playerMovement.activePlayersInGame.duplicate()
	winners.clear()
	eliminatedPlayers.clear()

	if playersInGame.is_empty():
		push_warning("No hay jugadores en la partida.")
		return

	gameRunning = true
	isLooking = false

	RunGameLoop()


func RunGameLoop() -> void:
	while gameRunning:
		# Fase 1: los jugadores pueden moverse.
		isLooking = false
		spriteCheck.modulate = Color.GREEN
		await get_tree().create_timer(randf_range(minMovementTime, maxMovementTime)).timeout

		if not gameRunning:
			return

		# Fase 2: el pollito está mirando.
		isLooking = true
		spriteCheck.modulate = Color.RED
		await get_tree().create_timer(randf_range(minLookingTime, maxLookingTime)).timeout

		if not gameRunning:
			return


func _process(_delta: float) -> void:
	if not gameRunning:
		return

	var positions := playerMovement.GetPlayerCurrentPositions()
	var pendingTimes := playerMovement.GetPlayersPendingMovementTime()

	for playerId in playersInGame.duplicate():
		if winners.has(playerId) or eliminatedPlayers.has(playerId):
			continue

		var index: int = playerId

		if index < 0 or index >= positions.size():
			continue

		# Comprobar si el jugador ha llegado a la meta.
		if positions[index].x >= winningXPosition:
			FinishPlayer(playerId, true)
			continue

		# Si el pollito está mirando, si alguien se mueve, se elimina
		if isLooking and pendingTimes[index] > 0.0:
			FinishPlayer(playerId, false)

	# La partida termina cuando gana alguien o todos son eliminados
	if (winners.size() >= 1) or eliminatedPlayers.size() >= playersInGame.size():
		gameRunning = false
		isLooking = false
		if(winners.size()>=1):
			gameFinished.emit(winners[0])
		else:
			gameFinished.emit(0)

		
func FinishPlayer(playerId: int, won: bool) -> void:
	var index: int = playerId

	if won:
		winners.append(playerId)
		playerWon.emit(playerId)
	else:
		eliminatedPlayers.append(playerId)
		playerEliminated.emit(playerId)

	# Detener el movimiento pendiente del jugador.
	playerMovement.pendingMovementTime[index] = 0.0
	playerMovement.playersPositions[index] = playerMovement.players[index].position

	# Quitamos al jugador de la partida para que no pueda seguir moviendose
	playerMovement.activePlayersInGame.erase(playerId)
