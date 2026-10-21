extends Node

# El diccionario tiene: numero de jugador y puntuación
var playerScores: Dictionary[int, int] = {}

# Inicializa las puntuaciones de los jugadores de la partida
func InitializeScores(jugadoresEnPartida: Array[int]) -> void:
	playerScores.clear()

#Lo hacemos así y no con un array para que en el ranking final no tengamos que poner
# jugadores que no están jugando (en caso de que juegen 3 por ejemplo)
	for playerId in jugadoresEnPartida:
		playerScores[playerId] = 0


# Suma puntos a un jugador.
func AddScore(playerId: int, points: int) -> void:
	if(playerId == 0):
		print("No ganó nadie")
	
	if not playerScores.has(playerId):
		push_warning("El jugador %d no está registrado." % playerId)
		return

	playerScores[playerId] += points


# Devuelve un diccionario ordenado de mayor a menor score
func GetPlayersScoresInRanking() -> Dictionary[int, int]:
	var sortedScores: Dictionary[int, int] = playerScores.duplicate()

	var playerIds: Array[int] = []
	for playerId in sortedScores:
		playerIds.append(playerId)

	playerIds.sort_custom(
		func(a: int, b: int) -> bool:
			return sortedScores[a] > sortedScores[b]
	)

	var rankingDictionary: Dictionary[int, int] = {}

	for playerId in playerIds:
		rankingDictionary[playerId] = sortedScores[playerId]

	return rankingDictionary

func GetHigherWins() -> int:
	var higherWins: int = 0
	for index in playerScores.size():
		var playerId : int = playerScores.keys()[index]
		if playerScores[playerId] > higherWins:
			higherWins = playerScores[playerId]
	return higherWins
