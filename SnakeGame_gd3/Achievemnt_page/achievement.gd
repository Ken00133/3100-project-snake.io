extends Control



# Called when the node enters the scene tree for the first time.
func _ready():	
	for i in GlobalVariable.achievement.size():
		get_node("achievement_list/check_box/a" + str(i + 1)+ "_checkBox").pressed = GlobalVariable.achievement[i]

	
func parse_achievement(achievement_list):
	var temp_list = []
	for num in achievement_list:
		if num == 116:
			temp_list.append(true)
		elif num == 102:
			temp_list.append(false)
			
	return temp_list
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Back_to_title_screen_button_down():
	get_tree().change_scene("res://title_page/title_page.tscn")
