extends Node

func ShakeSprite(sprite: Sprite2D, duration: float = 0.3, strength: float = 5.0) -> void:
	var originalPosition: Vector2 = sprite.position
	var elapsedTime: float = 0.0

	while elapsedTime < duration:
		var random_offset := Vector2(randf_range(-strength, strength),randf_range(-strength, strength))
		sprite.position = originalPosition + random_offset
		
		var step := minf(0.03, duration - elapsedTime)
		await get_tree().create_timer(step).timeout
		elapsedTime += step

	sprite.position = originalPosition
