extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MinigamesController.MinigamesStarted.connect(HideContent)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func HideContent() -> void:
	MinigamesController.MinigamesStarted.disconnect(HideContent)
	hide()
