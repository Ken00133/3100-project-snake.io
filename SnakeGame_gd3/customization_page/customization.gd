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
	snake_body[0].change_head_skin(snake_skin)
	for i in range(1, snake_length):
		snake_body[i].change_skin(snake_skin)


#Snake motion vars
var snake_seg_offset = 20
var snake_length = 7
var snake_body : Array
var start_pos : Vector2 = Vector2(9, 9)
var snake_seg : PackedScene = preload("res://characters/snake/SnakeSegment.tscn")
var snake_head : PackedScene = preload("res://characters/snake/snakeHead.tscn")
var id = get_instance_id()

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
	head.snake_skin = snake_skin
	head.scale = Vector2(0.6, 0.6)
	head.position = (pos*snake_seg_offset) + Vector2(0, snake_seg_offset)
	add_child(head)
	snake_body.append(head)
	
	
func _on_Confirm_button_down():
	GlobalVariable.snake_skin = snake_skin
	get_tree().change_scene("res://title_page/title_page.tscn")
	
func _on_Bk_to_main_button_down():
	get_tree().change_scene("res://title_page/title_page.tscn")


func _on_skin_5_button_down():
	snake_skin = 5
	change_display_snake_skin()

func _on_skin_6_button_down():
	snake_skin = 6
	change_display_snake_skin()

func _on_skin_7_button_down():
	snake_skin = 7
	change_display_snake_skin()


func _on_skin_8_button_down():
	snake_skin = 8
	change_display_snake_skin()


func _on_skin_9_button_down():
	snake_skin = 9
	change_display_snake_skin()


func _on_skin_10_button_down():
	snake_skin = 10
	change_display_snake_skin()


func _on_skin_11_button_down():
	snake_skin = 11
	change_display_snake_skin()


func _on_skin_12_button_down():
	snake_skin = 12
	change_display_snake_skin()


func _on_skin_13_button_down():
	snake_skin = 13
	change_display_snake_skin()


func _on_skin_14_button_down():
	snake_skin = 14
	change_display_snake_skin()

func _on_skin_15_button_down():
	snake_skin = 15
	change_display_snake_skin()
