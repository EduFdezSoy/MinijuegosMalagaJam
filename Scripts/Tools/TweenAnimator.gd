extends Node

func ShakeNode2D(node: Node2D, duration: float = 0.3, strength: float = 5.0) -> void:
	var originalPosition: Vector2 = node.position
	var elapsedTime: float = 0.0

	while elapsedTime < duration:
		var random_offset := Vector2(randf_range(-strength, strength),randf_range(-strength, strength))
		node.position = originalPosition + random_offset
		
		var step := minf(0.03, duration - elapsedTime)
		await get_tree().create_timer(step).timeout
		elapsedTime += step

	node.position = originalPosition

func FadeInOutColorRect(colorRect: ColorRect, color: Color, alpha : float, time:float) -> void:
	colorRect.color = color
	colorRect.color.a = 0.0
	var tween := create_tween()
	# Fade In
	tween.tween_property(colorRect,"color:a",alpha,time / 2.0)
	# Fade Out
	tween.tween_property(colorRect,"color:a",0.0,time / 2.0)

func PunchNode2D(node : Node2D, targetSize: Vector2, duration: float) -> void:
	var originalSize = node.scale
	
	var tween = create_tween()
	tween.tween_property(node, "scale", targetSize, duration / 2.0).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(node, "scale", originalSize, duration / 2.0).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
