extends Control

# Load sound
const HOVER_SOUND = preload('res://Assets/Sounds/OnHoverButtons.ogg')

func _ready():
	# $Buttons/StartButton.grab_focus() # It do works keys (up, down, left & right)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	print('==> Loaded main menu')


# ------( Start button functions )------
func _on_start_button_pressed():
	get_tree().change_scene_to_file('res://Scenes/World/World.tscn')

func _on_start_button_mouse_entered():
	playSoundOnHoverButton()
# ------( End Start Button Functions )------


# ------( Exit button functions )------
func _on_exit_button_pressed():
	get_tree().quit()

func _on_exit_button_mouse_entered():
	playSoundOnHoverButton()
# ------( End exit button functions )------


# ------(General functions)------
func playSoundOnHoverButton():
	if !$Buttons/OnHoverButtons.is_playing():
		$Buttons/OnHoverButtons.stream = HOVER_SOUND
		$Buttons/OnHoverButtons.play()
# ------(End general functions)------
