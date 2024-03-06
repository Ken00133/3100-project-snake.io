extends CharacterBody2D

@export var snake_seg : PackedScene

#Snake motion vars
var snake_seg_offset = 20
var snake_length = 20
var snake_speed = 100
var prev_pos : Array
var current_pos : Array
var snake_body : Array

var start_pos : Vector2 = global_position
var move_dir : Vector2

func _ready():
	generate_snake()

func generate_snake():
	prev_pos.clear()
	current_pos.clear()
	snake_body.clear()
	
	for i in range(snake_length):
		add_segment(start_pos + Vector2(0, i))

func add_segment(pos):
	current_pos.append(pos)
	var seg = snake_seg.instantiate()
	seg.scale = Vector2(0.6, 0.6)
	seg.position = (pos*snake_seg_offset) + Vector2(0, snake_seg_offset)
	add_child(seg)
	snake_body.append(seg)
	
func move_snake():
	var segment_distance : Vector2
	snake_body[0].velocity = (get_global_mouse_position() - snake_body[0].global_position).normalized()*snake_speed
	for i in range(1, snake_length):
		segment_distance = snake_body[i-1].global_position - snake_body[i].global_position
		if segment_distance.length() > 20:
			snake_body[i].velocity = (segment_distance).normalized()*snake_speed
		else:
			snake_body[i].velocity = Vector2(0, 0)

func _physics_process(delta):
	move_snake()
	
func _input(event):
	
	if Input.is_action_pressed("speed_boost"):
		snake_speed = 300
	else:
		snake_speed = 100
