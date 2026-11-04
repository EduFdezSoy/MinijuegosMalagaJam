extends Node

@export var scoreText : Array[Label]
@export var playerNodes : Array[Sprite2D]
@export var rankingPositions: Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Escena Score start")
	SetRankingTexts()

func SetRankingTexts() -> void:
	ResetRankingInfo()
	
	var rankings : Dictionary[int, int] = ScoreManager.GetPlayersScoresInRanking()

	for positions in rankings.size():
		var playerId = rankings.keys()[positions]
		playerNodes[playerId].show()
		playerNodes[playerId].position = rankingPositions[positions].position
		scoreText[positions].text = str(rankings[playerId])

func ResetRankingInfo() -> void:
	for i in playerNodes.size():
		scoreText[i].text = ""
		playerNodes[i].hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
