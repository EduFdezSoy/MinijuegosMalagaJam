extends Node
class_name MinigameActionButton
@export var playerButtonPosition : Array[Node2D]
@export var buttonFoodSprites : Array[Sprite2D]
@export var buttonSprites : Array[Sprite2D]
@export var buttonRedCross : Array[Sprite2D]

@export var playerEliminatedColor : Color


func SetButtonSprites(playerFoods: Dictionary[int,String], foodIndex: Dictionary[String,int]) -> void:
	
	for index in foodIndex.size():
		if playerFoods.has(index):
			var foodSpriteIndex = foodIndex[playerFoods[index]]
			buttonSprites[index].show()
			buttonFoodSprites[foodSpriteIndex].show()
			var position = playerButtonPosition[index].global_position
			buttonRedCross[index].hide()
			buttonSprites[index].global_position = position
			buttonRedCross[index].global_position = position
			buttonFoodSprites[foodSpriteIndex].global_position = position
			

func DeletePlayer(playerId : int, foodId: int) -> void:
	TweenAnimator.ShakeSprite(buttonSprites[playerId])
	buttonSprites[playerId].modulate = playerEliminatedColor
	buttonRedCross[playerId].show()
	buttonFoodSprites[foodId].hide()
