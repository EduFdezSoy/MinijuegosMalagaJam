extends TextureButton

var audio_play = false

@export var in_dialogue:bool

func _ready():
	mouse_entered.connect(_on_mouse_entered)

func _on_mouse_entered():
	audio_play = true
	audio_button()

func audio_button():
	if audio_play:
		#Poner aqui pista de audio
		audio_play = false
	else:
		pass
