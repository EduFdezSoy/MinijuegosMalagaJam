extends Node
class_name MinigameReadyButton

@export var readyLabel : Label
@export var buttonSprite : Sprite2D
var buttonPressed :bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	readyLabel.hide()

func Pressed() -> void:
	readyLabel.show()
	buttonSprite.scale = Vector2.ONE * 0.4
	buttonPressed = true
