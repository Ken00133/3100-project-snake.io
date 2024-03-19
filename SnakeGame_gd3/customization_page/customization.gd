extends Node2D

var snake_skin = GlobalVariable.snake_skin
var snakeplayer = preload("res://characters/snake/SnakePlayer.tscn")

func _ready():
	generate_snake()
	
func _on_Ball_1_button_down():
	snake_skin = 1
	change_display_snake_skin()
	
func _on_Ball_2_button_down():
	snake_skin = 2
	change_display_snake_skin()

func _on_Ball_3_button_down():
	snake_skin = 3
	change_display_snake_skin()

func _on_Ball_4_button_down():
	snake_skin = 4
	change_display_snake_skin()
	
func change_display_snake_skin():
	for i in range(1, snake_length):
		snake_body[i].change_skin(snake_skin)


#Snake motion vars
var snake_seg_offset = 20
var snake_length = 7
var snake_body : Array
var start_pos : Vector2 = Vector2(10, 9)
var snake_seg : PackedScene = preload("res://characters/snake/SnakeSegment.tscn")
var snake_head : PackedScene = preload("res://characters/snake/snakeHead.tscn")

func generate_snake():
	snake_body.clear()
	add_head(start_pos, snake_length)
	for i in range(1, snake_length):
		add_segment(start_pos + Vector2(0, i), snake_length - i, GlobalVariable.snake_skin)
	
func add_segment(pos, z_index, snake_skin):
	var seg = snake_seg.instance()
	seg.snake_skin = snake_skin
	seg.scale = Vector2(0.6, 0.6)
	seg.position = (pos*snake_seg_offset) + Vector2(0, snake_seg_offset)
	add_child(seg)
	snake_body.append(seg)

func add_head(pos, z_index):
	var head = snake_head.instance()
	head.scale = Vector2(0.6, 0.6)
	head.position = (pos*snake_seg_offset) + Vector2(0, snake_seg_offset)
	add_child(head)
	snake_body.append(head)
	
	
func _on_Confirm_button_down():
	DatabaseUtils.database.execute("""
	BEGIN;
	UPDATE %s SET snake_skin=%d WHERE username='%s';
	COMMIT;
	""" % ["user_profile", snake_skin, GlobalVariable.username] 
	)
	GlobalVariable.snake_skin = snake_skin
	

func _on_Bk_to_main_button_down():
	get_tree().change_scene("res://title_page/title_page.tscn")
