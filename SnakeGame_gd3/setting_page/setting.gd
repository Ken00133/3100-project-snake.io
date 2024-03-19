extends Control


var master_bus = AudioServer.get_bus_index("Master")
var master_volume

# Called when the node enters the scene tree for the first time.
func _ready():
	master_volume = GlobalVariable.master_volume
	
	# initialize the master volume
	AudioServer.set_bus_volume_db(master_bus, master_volume)
	get_node("HSlider").value = master_volume


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HSlider_value_changed(value):
	#var db = 10.0 * log(value)
	print("in setting :", value)
	master_volume = value
	AudioServer.set_bus_volume_db(master_bus, value)
	if value < 0:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
	


func _on_Button_button_down():
	save_master_volume(master_volume)
	GlobalVariable.master_volume = master_volume
	get_tree().change_scene("res://title_page/title_page.tscn")
	
func save_master_volume(volume):
	
	DatabaseUtils.database.execute("""
	BEGIN;
	UPDATE %s SET master_volume=%d WHERE username='%s';
	COMMIT;
	""" % ["user_profile", volume, GlobalVariable.username] 
	)
