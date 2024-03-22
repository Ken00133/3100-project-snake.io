extends Control

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("pause"): # when "M" or "m" is pressed
		self.is_paused = ! is_paused
		
func set_is_paused(value):
	is_paused = value 
	get_tree().paused = is_paused
	visible = is_paused


func _on_Resume_button_down():
	self.is_paused = false

func _on_Return_to_title_page_button_down():
	self.is_paused = false
	get_tree().change_scene("res://title_page/title_page.tscn")


func _on_Exit_button_down():
	get_tree().quit()

func _on_Clear_High_Score_button_down():
	GlobalVariable.high_score = 0


func _on_Reset_button_down():
	self.is_paused = false
	get_tree().change_scene("res://Main.tscn")
