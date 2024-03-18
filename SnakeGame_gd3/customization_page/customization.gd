extends Node2D

var skin_id = 1 # latter should be retrieved from database

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
	print("in setting" + skin_id)
	#var snake = get_node("res://characters/snake/SnakeSegment.tscn").get_children()
	#print(snake)



func _on_Ball_1_button_down():
	skin_id = 1

func _on_Ball_2_button_down():
	skin_id = 2

func _on_Ball_3_button_down():
	skin_id = 3

func _on_Ball_4_button_down():
	skin_id = 4


func _on_Confirm_button_down():
	print("Confim:" ,skin_id)
	DatabaseUtils.database.execute("""
	BEGIN;
	UPDATE %s SET snake_skin=%d WHERE username='%s';
	COMMIT;
	""" % ["user_profile", skin_id, GlobalVariable.username] 
	)
	


func _on_Bk_to_main_button_down():
	get_tree().change_scene("res://title_page/title_page.tscn")
