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

var background_imgs = [preload("res://images/gui/setting_img/bg_1.png"), preload("res://images/gui/setting_img/bg_2.jpg"),
						preload("res://images/gui/setting_img/bg_3.jpg") ]
var iterative_variable = 0
func _on_next_theme_image_button_down():
	if  0 <= iterative_variable and iterative_variable < background_imgs.size() -1 :
		iterative_variable = iterative_variable + 1
		get_node("ArenaBackground").texture = background_imgs[iterative_variable]


func _on_previous_theme_image_button_down():
	if  0 < iterative_variable and iterative_variable < background_imgs.size():
		iterative_variable = iterative_variable - 1
		get_node("ArenaBackground").texture = background_imgs[iterative_variable]

