extends Node
class_name FoodChecker

@export var peopleLine : PeopleLine
@export var actionButtons : MinigameActionButton
var food : Dictionary[String,int] = {"Patatas"=0,"Palmera"=1,"Tortelini"=2,"Pizza"=3}
# Representa el id de jugador y su comida asignada
var currentFoodAvailableForPlayers: Dictionary[int,String]

@export var foodSprites : Array[Node2D]

var nextFood : String
var foodIndex : int
var miniGameLunchTime : MinigameLunchTime

# Called when the node enters the scene tree for the first time.
func Initialize(miniGame: MinigameLunchTime) -> void:
	miniGameLunchTime = miniGame
	HideSprites()
	currentFoodAvailableForPlayers = SetRandomFoodToPlayers()
	actionButtons.SetButtonSprites(currentFoodAvailableForPlayers,food)
	SetNextFood()
	peopleLine.Initialize()

func PlayerPressedButton(playerId: int) -> bool:
	print("Player ",playerId," send: ",currentFoodAvailableForPlayers[playerId], " next food is: ",nextFood)
	if(currentFoodAvailableForPlayers[playerId] == nextFood):
		#Sonidito y efecto de acierto
		ShowNextFood()
		return true
	else:
		#Sonidito y efecto de error
		actionButtons.DeletePlayer(playerId,food[currentFoodAvailableForPlayers[playerId]])
		RemovePlayer(playerId)
		if currentFoodAvailableForPlayers.size() == 1:
			print("SE ACABÓ")
			miniGameLunchTime.GameEnded(currentFoodAvailableForPlayers.keys()[0]+1)
		return false


func ShowNextFood() -> void:
	HideSprites()
	nextFood = ""
	peopleLine.MovePeopleToPosition()
	await get_tree().create_timer(0.5).timeout
	SetNextFood()
	

func SetNextFood() -> void:
	var availableFood = currentFoodAvailableForPlayers.values()
	availableFood.shuffle()
	nextFood = availableFood[0]
	var index = food[nextFood]
	foodSprites[index].show()

func RemovePlayer(playerId:int) -> void:
	#Quitar el jugador y las comidas de ese jugador de la lista
	currentFoodAvailableForPlayers.erase(playerId)
	pass

func HideSprites() -> void:
	for sprite in foodSprites:
		sprite.hide()

func SetRandomFoodToPlayers() -> Dictionary[int,String]:
	var shuffledFood = food.keys().duplicate()
	shuffledFood.shuffle()
	shuffledFood.slice(0,PlayersController.activePlayerCount)
	var playersIds = PlayersController.GetCurrentPlayersIds()
	var foodDictionary : Dictionary[int,String]
	
	for index in playersIds.size():
		foodDictionary.set(playersIds[index]-1,shuffledFood[index])
		print("Jugador ",playersIds[index]-1," tiene ", shuffledFood[index])
	
	return foodDictionary
