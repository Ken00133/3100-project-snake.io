extends Control

var row = preload("res://leaderboard_page/row.tscn")
onready var table = get_node("VBoxContainer/PanelContainer2/ScrollContainer/VBoxContainer")
var sequence_index = 0
#var data = [{"username": "wosy", "high_score": "9", 
#			"highest_number_of_kills": "10", "highest_length": "100" }]
# Called when the node enters the scene tree for the first time.
func _ready():
	update_user_profile_database()
	var data = get_sorted_data()
	for i in range(0, data.size()):
		set_data(data[i])

func set_data(data:Dictionary):
	sequence_index = sequence_index + 1
	var instance = row.instance()
	instance.name = str(sequence_index)
	table.add_child(instance)
	
	get_node("VBoxContainer/PanelContainer2/ScrollContainer/VBoxContainer/" + instance.name + "/1").text = str(sequence_index)
	get_node("VBoxContainer/PanelContainer2/ScrollContainer/VBoxContainer/" + instance.name + "/2").text = data.username
	get_node("VBoxContainer/PanelContainer2/ScrollContainer/VBoxContainer/" + instance.name +"/3" ).text = data.high_score
	get_node("VBoxContainer/PanelContainer2/ScrollContainer/VBoxContainer/" + instance.name + "/4" ).text = data.highest_number_of_kills
	get_node("VBoxContainer/PanelContainer2/ScrollContainer/VBoxContainer/" + instance.name + "/5" ).text = data.highest_length
	
	
func get_sorted_data():
	var d = []
	var user_data = DatabaseUtils.database.execute("""
	BEGIN;
	SELECT username, high_score, highest_number_of_kills, highest_length FROM %s
	ORDER BY high_score, highest_number_of_kills, highest_length DESC;
	COMMIT;
	""" % ["user_profile"] )
	for temp in user_data[1].data_row:
		var dummy = {}
		dummy["username"] = temp[0]
		dummy["high_score"] = str(temp[1])
		dummy["highest_number_of_kills"] =  str(temp[2])
		dummy["highest_length"] = str(temp[3])
		d.append(dummy)
	var d_temporary = []
	for index in range(0, d.size()):
		d_temporary.append(d[d.size() - 1 - index])
	d.clear()
	return d_temporary
	
	
	
	
func update_user_profile_database():
	# update current user's high score, highest_number_of_kills, and highest_length
	
	DatabaseUtils.database.execute("""
	BEGIN;
	UPDATE %s SET high_score=%d, highest_length=%d, highest_number_of_kills=%d WHERE username='%s';
	COMMIT;
	""" % ["user_profile", GlobalVariable.high_score, GlobalVariable.highest_length,
		GlobalVariable.highest_number_of_kills, GlobalVariable.username] 
	)
	

func _on_Back_to_title_screen_button_down():
	get_tree().change_scene("res://title_page/title_page.tscn")
