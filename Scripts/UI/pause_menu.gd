extends Control

@onready var pause_scene = $"."
@onready var transition_menus = $AnimationPlayer

var pause_game = false

func _ready():
	pause_scene.set_process_input(false)
	$OptionsMenu.set_process_input(false)

func _input(event):
	if Input.is_action_just_pressed("exit_button"):
		if $OptionsMenu.visible == true:
			$OptionsMenu.set_process_input(false)
			transition_menus.play("Options_to_PauseMenu")
			return
		if pause_game == false:
			game_pause()
		else:
			transition_menus.play("Return_To_Game")

func menu_options_button(extra_arg_0):
	if extra_arg_0 == "Return_Game":
		transition_menus.play("Return_To_Game")
	
	if extra_arg_0 == "PauseMenu_To_Options":
		transition_menus.play("PauseMenu_To_Options")
	
	if extra_arg_0 == "Options_To_PauseMenu":
		transition_menus.play("Options_To_PauseMenu")
	
	if extra_arg_0 == "Main_Menu":
		transition_menus.play("Go_To_MainMenu")
	

func _animation_finished(anim_name):
	if anim_name == "Return_To_Game":
		return_game()
	if anim_name == "PauseMenu_To_Options":
		$OptionsMenu.set_process_input(true)
	if anim_name == "Options_To_PauseMenu":
		$Pause_Menu_Buttons.set_process_input(true)
	if anim_name == "Go_To_MainMenu":
		return_main_menu()

func game_pause():
	pause_game = true

func return_game():
	pause_game = false

func return_main_menu():
	pass
