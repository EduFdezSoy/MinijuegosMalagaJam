extends Node
class_name IncrementalCountDown

@export var initialCountDownTime : float
var lastCountDown : float
@export var minimumCountDownTime : float = 0.2
@export var incrementalTimeValue : float = 0.1
@export var  progress :TextureProgressBar
var currentCountDown : float
var countDownActive : bool
signal CountDownFinished



func StartCountDown() -> void:
	currentCountDown = initialCountDownTime
	lastCountDown = currentCountDown
	countDownActive = true

func NextCountDown() -> void:
	currentCountDown = max(lastCountDown - incrementalTimeValue, minimumCountDownTime)
	lastCountDown = currentCountDown
	countDownActive = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if countDownActive:
		if(currentCountDown > 0) : 
			currentCountDown -= delta
		
		if currentCountDown <= 0:
			countDownActive = false
			CountDownFinished.emit()
		
		progress.value = (currentCountDown / lastCountDown) * 100
	
func StopCountDown() -> void:
	countDownActive = false
