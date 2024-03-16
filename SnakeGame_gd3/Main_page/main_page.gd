extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


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
