extends Node2D
class_name MinigamePreviewController

@export var playerReadyButtons : Array[MinigameReadyButton]
var readyNeededToStart: int
var minigameParent :MinigameBase

@export var tutorialSprite : TextureRect
@export var titleLabel: Label
@export var descriptionLabel: Label
@export var developersLabel : Label


func Initialize(minigame: MinigameBase, minigameData: MinigameData) -> void:
	minigameParent = minigame
	tutorialSprite.texture = minigameData.tutorialImage
	titleLabel.text = minigameData.minigameName
	descriptionLabel.text = minigameData.description
	
	developersLabel.text = ""
	for developer in minigameData.developersAndPosition.keys():
		developersLabel.text +=developer + ":" + minigameData.developersAndPosition[developer] + "\n"
	
	ActivePlayerButtons()
	

func ActivePlayerButtons() -> void:
	readyNeededToStart = 0
	InputController.playerButtonPressed.connect(PlayerButtonPressed)
	for playerId in PlayersController.activePlayers.size():
		if PlayersController.activePlayers[playerId]:
			readyNeededToStart +=1
		else:
			playerReadyButtons[playerId].hide();


func PlayerButtonPressed(playerId: int) -> void:
	if PlayersController.activePlayers[playerId]:
		if not playerReadyButtons[playerId].buttonPressed:
			readyNeededToStart -=1
			playerReadyButtons[playerId].Pressed()
			CheckIfEveryoneIsReady()

func CheckIfEveryoneIsReady() -> void:
	if readyNeededToStart == 0:
		minigameParent.HideGameTutorialAndStart()
