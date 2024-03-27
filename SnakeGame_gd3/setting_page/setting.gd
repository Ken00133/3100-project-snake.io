extends Control


var master_bus = AudioServer.get_bus_index("Master")
var master_volume
var iterative_variable = GlobalVariable.background_theme - 1
var background_imgs = [preload("res://images/gui/setting_img/bg_1.png"), preload("res://images/gui/setting_img/bg_2.png"),
						preload("res://images/gui/setting_img/bg_3.png"), preload("res://images/gui/setting_img/bg_4.png"),
						preload("res://images/gui/setting_img/bg_5.png"), preload("res://images/gui/setting_img/bg_6.png")]
var unlock_theme_thresholds = [0, 0, 0, 0, 40, 60]

# Called when the node enters the scene tree for the first time.
func _ready():
	master_volume = GlobalVariable.master_volume
	
	# initialize the master volume
	AudioServer.set_bus_volume_db(master_bus, master_volume)
	get_node("HSlider").value = master_volume
	get_node("Background_CanvasLayer/ArenaBackground").texture = background_imgs[iterative_variable]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HSlider_value_changed(value):
	master_volume = value
	AudioServer.set_bus_volume_db(master_bus, value)
	if value < 0:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
	


func _on_Button_button_down():
	GlobalVariable.master_volume = master_volume
	get_tree().change_scene("res://title_page/title_page.tscn")
	
	
func _on_next_theme_image_button_down():
	if  0 <= iterative_variable and iterative_variable < background_imgs.size() - 1 :
		iterative_variable = iterative_variable + 1
		get_node("Background_CanvasLayer/ArenaBackground").texture = background_imgs[iterative_variable]
		if unlock_theme_thresholds[iterative_variable] > GlobalVariable.high_score:
			get_node("Background_CanvasLayer/Lock").visible = true
		else:
			GlobalVariable.background_theme = iterative_variable + 1
			get_node("Background_CanvasLayer/Lock").visible = false


func _on_previous_theme_image_button_down():
	if  0 < iterative_variable and iterative_variable < background_imgs.size():
		iterative_variable = iterative_variable - 1
		get_node("Background_CanvasLayer/ArenaBackground").texture = background_imgs[iterative_variable]
		if unlock_theme_thresholds[iterative_variable] > GlobalVariable.high_score:
			get_node("Background_CanvasLayer/Lock").visible = true
		else:
			GlobalVariable.background_theme = iterative_variable + 1
			get_node("Background_CanvasLayer/Lock").visible = false


