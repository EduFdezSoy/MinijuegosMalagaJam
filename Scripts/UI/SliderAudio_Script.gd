extends HSlider

@export var bus_name = "" ##Poner aquí el nombre del BUS
var audio_play = false

func _ready():
	mouse_entered.connect(_on_mouse_entered)

func _on_mouse_entered():
	audio_play = true
	audio_button()

func _on_value_changed(value: float):
	var db = linear_to_db(value)
	
	var audio_bus = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(audio_bus,db)

func audio_button():
	if audio_play:
		#Poner aqui pista de audio
		audio_play = false
	else:
		pass
