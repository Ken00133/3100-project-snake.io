extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	var achievement_data = DatabaseUtils.database.execute("""
	BEGIN;
	SELECT achievement FROM %s WHERE username='%s';
	COMMIT;
	""" % ["user_profile", GlobalVariable.username] )
	
	var achievement = parse_achievement(achievement_data[1].data_row[0][0])
	
	for i in achievement.size():
		get_node("achievement_list/check_box/a" + str(i + 1)+ "_checkBox").pressed = achievement[i]
	
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
