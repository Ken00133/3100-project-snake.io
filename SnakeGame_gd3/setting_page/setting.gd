extends Control


var master_bus = AudioServer.get_bus_index("Master")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HSlider_value_changed(value):
	#var db = 10.0 * log(value)
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value < 0:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
	


func _on_Button_button_down():
	get_tree().change_scene("res://title_page/title_page.tscn")
