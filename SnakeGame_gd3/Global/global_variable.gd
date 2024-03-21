extends Node

# This script is used for sharing global variables

var username 
var master_volume 
var snake_skin
var background_theme
var high_score


func _ready():
	username = "wosy"
	DatabaseUtils.connect("databaseConnected", self, "set_snake_skin")
	DatabaseUtils.connect("databaseConnected", self, "set_background_theme")
	DatabaseUtils.connect("databaseConnected", self, "set_high_score")
	
	
func set_snake_skin():
	
	# query snake skin of the user 
	var snake_skin_data = DatabaseUtils.database.execute("""
	BEGIN;
	SELECT snake_skin FROM %s WHERE username='%s';
	COMMIT;
	""" % ["user_profile", username] )
	
	# set snake_skin
	for temp in snake_skin_data[1].data_row:
		snake_skin = temp[0]

func set_background_theme():
	var background_theme_data = DatabaseUtils.database.execute("""
	BEGIN;
	SELECT background_theme FROM %s WHERE username='%s';
	COMMIT;
	""" % ["user_profile", username] )
	
	# set snake_skin
	for temp in background_theme_data[1].data_row:
		background_theme = temp[0]
		
func set_high_score():
	var high_score_data = DatabaseUtils.database.execute("""
	BEGIN;
	SELECT high_score FROM %s WHERE username='%s';
	COMMIT;
	""" % ["user_profile", username] )
	
	# set snake_skin
	for temp in high_score_data[1].data_row:
		high_score = temp[0]
	
