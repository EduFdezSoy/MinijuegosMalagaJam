extends Control

@onready var transition_menus = $AnimationPlayer

func _ready():
	$OptionsMenu.set_process_input(false)
	$LeaderBoardMenu.set_process_input(false)
	$CreditsMenu.set_process_input(false)

func _input(event):
	if Input.is_action_just_pressed("exit_button"):
		if $OptionsMenu.visible == true:
			$OptionsMenu.set_process_input(false)
			transition_menus.play("Options_to_MainMenu")
			return
		
		if $LeaderBoardMenu.visible == true:
			$LeaderBoardMenu.set_process_input(false)
			transition_menus.play("LeaderBoard_to_MainMenu")
			return
		
		if $CreditsMenu.visible == true:
			$CreditsMenu.set_process_input(false)
			transition_menus.play("Credits_to_MainMenu")
			return

func start_game():
	pass

func menu_options_button(extra_arg_0):
	if extra_arg_0 == "Options" or extra_arg_0 == "LeaderBoard" or extra_arg_0 == "Credits":
		$MainMenu.set_process_input(false)
	
	if extra_arg_0 == "Options":
		transition_menus.play("MainMenu_to_Options")
	
	if extra_arg_0 == "LeaderBoard":
		transition_menus.play("MainMenu_to_LeaderBoard")
	
	if extra_arg_0 == "Credits":
		transition_menus.play("MainMenu_to_Credits")
	
	if extra_arg_0 == "ToMainMenu_In_Options":
		transition_menus.play("Options_to_MainMenu")
	
	if extra_arg_0 == "ToMainMenu_In_LeaderBoard":
		transition_menus.play("LeaderBoard_to_MainMenu")
	
	if extra_arg_0 == "ToMainMenu_In_Credits":
		transition_menus.play("Credits_to_MainMenu")

func _animation_finished(anim_name):
	if anim_name == "LeaderBoard_to_MainMenu" or anim_name == "Credits_to_MainMenu" or anim_name == "Options_to_MainMenu":
		$MainMenu.set_process_input(true)
	
	if anim_name == "MainMenu_to_Options":
		$OptionsMenu.set_process_input(true)
	
	if anim_name == "MainMenu_to_LeaderBoard":
		$LeaderBoardMenu.set_process_input(true)
	
	if anim_name == "MainMenu_to_Credits":
		$CreditsMenu.set_process_input(true)
