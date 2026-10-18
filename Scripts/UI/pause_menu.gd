extends CanvasLayer

@onready var pause_scene = $"."
@onready var transition_menus = $AnimationPlayer

var pause_game = false

func _ready():
	%OptionsMenu.set_process_input(false)
	%Pause_Menu_Buttons.set_process_input(false)

func _input(event):
	if Input.is_action_just_pressed("exit_button"):
		if %OptionsMenu.visible == true:
			%OptionsMenu.set_process_input(false)
			transition_menus.play("Options_To_PauseMenu")
			return
		if pause_game == false:
			get_tree().paused = true
			game_pause()
		else:
			return_game()

func menu_options_button(extra_arg_0):
	if extra_arg_0 == "Return_Game":
		return_game()
	
	if extra_arg_0 == "PauseMenu_To_Options":
		transition_menus.play("PauseMenu_To_Options")
	
	if extra_arg_0 == "Options_To_PauseMenu":
		transition_menus.play("Options_To_PauseMenu")
	
	if extra_arg_0 == "Main_Menu":
		transition_menus.play("Return_To_MainMenu")
	

func _animation_finished(anim_name):
	if anim_name == "Return_To_Game":
		get_tree().paused = false
		pause_game = false
	if anim_name == "PauseMenu_To_Options":
		%OptionsMenu.set_process_input(true)
	if anim_name == "Options_To_PauseMenu":
		%Pause_Menu_Buttons.set_process_input(true)
	if anim_name == "Go_To_Pause":
		%Pause_Menu_Buttons.set_process_input(true)
	if anim_name == "Return_To_MainMenu":
		return_main_menu()

func game_pause():
	pause_game = true
	transition_menus.play("Go_To_Pause")

func return_game():
	transition_menus.play("Return_To_Game")

func return_main_menu():
	get_tree().change_scene_to_file("res://Scenes/Title_Screen.tscn")
