extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Play_button_down():
	get_tree().change_scene("res://Main.tscn")
	
func _on_Exit_button_down():
	get_tree().quit()

func _on_Customize_button_down():
	get_tree().change_scene("res://customization/customization.tscn")


func _on_Setting_button_down():
	get_tree().change_scene("res://setting_page/setting.tscn")



var instruction = preload("res://title_page/Instruction.tscn")
var instruct_to_play = instruction.instance()
var just_pressed_how_to_play:bool = false

func _on_How_to_play_button_down():
	if not just_pressed_how_to_play:
		add_child(instruct_to_play)
		just_pressed_how_to_play = true
	else:
		remove_child(instruct_to_play)
		just_pressed_how_to_play = false


