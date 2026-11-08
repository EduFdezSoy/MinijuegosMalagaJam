extends Node
@export var transitionTextureRect: TextureRect
var material : ShaderMaterial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TransitionController.TransitionSignal.connect(TransitionAnimation)
	material = transitionTextureRect.material as ShaderMaterial
	material.set_shader_parameter("reveal_progress",0)

func TransitionAnimation(targetProgress:float,direction: Vector2, duration: float) -> void:
	var shaderMaterial = material as ShaderMaterial
	
	var currentProgress : float = shaderMaterial.get_shader_parameter("reveal_progress")
	shaderMaterial.set_shader_parameter("reveal_direction",direction)
	var tween = create_tween()
	tween.tween_method(
		func(value: float):
			shaderMaterial.set_shader_parameter("reveal_progress", value),
		currentProgress,
		targetProgress,
		duration)
