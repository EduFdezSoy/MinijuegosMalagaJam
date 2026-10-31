extends Node
class_name PeopleLine
@export var firstInLinePosition : Node2D
@export var lastInLinePosition: Node2D
@export var secondInLinePosition: Node2D
@export var beforeLinePosition: Node2D

@export var originalScale: float
@export var scaleInFirstPosition: float

@export var peopleSprites : Array[Node2D]
@export var peopleInLine : int

func Initialize() -> void:
	peopleSprites.shuffle()
	peopleSprites[0].global_position = firstInLinePosition.global_position
	peopleSprites[0].scale = Vector2.ONE * scaleInFirstPosition
	
	for index in range(1,peopleInLine):
		var positionInLine: Vector2 = lerp(secondInLinePosition.global_position,lastInLinePosition.global_position,(index-1)/(float)(peopleInLine-2))
		peopleSprites[index].global_position = positionInLine
	

func MovePeopleToPosition() -> void:
	# quitamos a la primera persona de en medio y la ponemos al final del array
	print("Mueve a la persona fuera")
	MovePersonInLine(peopleSprites[0],firstInLinePosition.global_position + Vector2(700,0))
	
	await get_tree().create_timer(0.5).timeout
	#Ponemos al personajillo detras de la linea para que no se vea raro cuando vuelva
	peopleSprites[0].global_position = beforeLinePosition.global_position
	peopleSprites[0].scale = Vector2.ONE * originalScale
	peopleSprites.append(peopleSprites[0])
	peopleSprites.remove_at(0)
	
	
	
	MovePersonInLine(peopleSprites[0],firstInLinePosition.global_position)
	ScalePersonInLineTween(peopleSprites[0],scaleInFirstPosition)
	for index in range(1,peopleInLine):
		var positionInLine: Vector2 = lerp(secondInLinePosition.global_position,lastInLinePosition.global_position,(index-1)/(float)(peopleInLine-2))
		MovePersonInLine(peopleSprites[index],positionInLine)

func MovePersonInLine(person: Node2D, position: Vector2) -> void:
	var tween = create_tween()
	tween.tween_property(person, "global_position", position, 0.4)

func ScalePersonInLineTween(person: Node2D, scale: float) -> void:
	var tween = create_tween()
	tween.tween_property(person, "scale", Vector2.ONE * scale, 0.3)
