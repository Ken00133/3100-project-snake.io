extends Node2D

var snake_skin = GlobalVariable.snake_skin

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Ball_1_button_down():
	snake_skin = 1

func _on_Ball_2_button_down():
	snake_skin = 2

func _on_Ball_3_button_down():
	snake_skin = 3

func _on_Ball_4_button_down():
	snake_skin = 4


func _on_Confirm_button_down():
	print("Confim:" ,snake_skin)
	DatabaseUtils.database.execute("""
	BEGIN;
	UPDATE %s SET snake_skin=%d WHERE username='%s';
	COMMIT;
	""" % ["user_profile", snake_skin, GlobalVariable.username] 
	)
	GlobalVariable.snake_skin = snake_skin
	

func _on_Bk_to_main_button_down():
	get_tree().change_scene("res://title_page/title_page.tscn")
