extends AudioStreamPlayer2D



var master_bus = AudioServer.get_bus_index("Master")

# Called when the node enters the scene tree for the first time.
func _ready():
	AudioServer.set_bus_mute(master_bus, true)
	GlobalVariable.connect("OK_to_set_master_volume", self, "set_initial_master_volume")


func set_initial_master_volume():
	# initialize the master volume
	#get_node("/root/AudioStreamPlayer2d").volume_db = master_volume
	AudioServer.set_bus_volume_db(master_bus, GlobalVariable.master_volume)
	if GlobalVariable.master_volume < 0:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
