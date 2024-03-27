extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	display_message()
	
# display player's rank, level and score
func display_message():
	var label = get_node("died_message")
	var rank = GlobalVariable.player_rank
	var score = GlobalVariable.player_score
	label.text = "You died\n" + "Your rank: " + str(rank) + "\nYour score: " + str(score)



func _on_Restart_button_down():
	get_tree().change_scene("res://Main.tscn")


func _on_BK_to_title_page_button_down():
	get_tree().change_scene("res://title_page/title_page.tscn")
