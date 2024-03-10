extends Node2D

export var snake_seg : PackedScene
export var snake_head : PackedScene

#Snake motion vars
var snake_seg_offset = 20
var snake_length = 20
var snake_speed = 100
var prev_pos : Array
var current_pos : Array
var snake_body : Array

var start_pos : Vector2 = global_position
var move_dir : Vector2

var playercam = Camera2D.new()

func _ready():
	generate_snake()

func generate_snake():
	prev_pos.clear()
	current_pos.clear()
	snake_body.clear()
	
	add_head(start_pos, snake_length)
	for i in range(1, snake_length):
		add_segment(start_pos + Vector2(0, i), snake_length - i)
	playercam.make_current()
	playercam.zoom = Vector2(1.5, 1.5)
	snake_body[0].add_child(playercam)
	
func add_segment(pos, z_index):
	var seg = snake_seg.instance()
	current_pos.append(pos)
	seg.scale = Vector2(0.6, 0.6)
	seg.position = (pos*snake_seg_offset) + Vector2(0, snake_seg_offset)
	seg.z_index
	add_child(seg)
	snake_body.append(seg)

func add_head(pos, z_index):
	var head = snake_head.instance()
	current_pos.append(pos)
	head.scale = Vector2(0.6, 0.6)
	head.position = (pos*snake_seg_offset) + Vector2(0, snake_seg_offset)
	add_child(head)
	snake_body.append(head)

func move_snake():
	var segment_vect : Vector2
	segment_vect = get_global_mouse_position() - snake_body[0].global_position
	
	snake_body[0].velocity = (segment_vect).normalized()*snake_speed
	
	for i in range(1, snake_length):
		segment_vect = snake_body[i-1].global_position - snake_body[i].global_position
		if segment_vect.length() > 30:
			snake_body[i].velocity = (segment_vect).normalized()*snake_speed
		else:
			snake_body[i].velocity = snake_body[i].velocity.normalized()*snake_speed
			
	
func _physics_process(delta):
	move_snake()
	
func _input(event):
	if Input.is_action_pressed("speed_boost"):
		snake_speed = 300
	else:
		snake_speed = 100
