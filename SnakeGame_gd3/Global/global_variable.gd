extends Node

# This script is used for sharing global variables

var username 
var master_volume
var snake_skin


func _ready():
	username = "wosy"
	DatabaseUtils.connect("databaseConnected", self, "set_snake_skin")
	
	
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
