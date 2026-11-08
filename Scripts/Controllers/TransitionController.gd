extends Node


signal TransitionSignal(targetProgress:float ,direction:Vector2, duration : float)

func MakeTransition(targetProgress:float, duration : float) -> void:
	var direction:Vector2 = Vector2(randf_range(-1.0, 1.0),randf_range(-1.0, 1.0))
	TransitionSignal.emit(targetProgress,direction,duration)
