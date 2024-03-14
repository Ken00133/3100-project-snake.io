extends Node2D

class_name customization

signal skin_change_signal(skin_id)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_button_down():
	
	#print(dum)
	var skin_id
	skin_id = "2"
	emit_signal("skin_change_signal", skin_id)
	print("in setting" + skin_id)
	#var snake = get_node("res://characters/snake/SnakeSegment.tscn").get_children()
	#print(snake)

