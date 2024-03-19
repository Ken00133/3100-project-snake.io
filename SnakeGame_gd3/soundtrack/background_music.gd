extends AudioStreamPlayer2D



var master_bus = AudioServer.get_bus_index("Master")

# Called when the node enters the scene tree for the first time.
func _ready():
	DatabaseUtils.connect("databaseConnected", self, "set_initial_master_volume")


func set_initial_master_volume():
	var master_volume
	# query master volume of the user 
	var master_volume_data = DatabaseUtils.database.execute("""
	BEGIN;
	SELECT master_volume FROM %s WHERE username='%s';
	COMMIT;
	""" % ["user_profile", GlobalVariable.username] )
	for temp in master_volume_data[1].data_row:
		master_volume = temp[0] 
	# initialize the master volume
	#get_node("/root/AudioStreamPlayer2d").volume_db = master_volume
	AudioServer.set_bus_volume_db(master_bus, master_volume)
	if master_volume < 0:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
		
	# set master volume in global script
	GlobalVariable.master_volume = master_volume

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
