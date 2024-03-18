extends Node2D

export var snake_seg : PackedScene
export var snake_head : PackedScene

#Snake motion vars
var snake_seg_offset = 20
var snake_length = 5 #initial snake length
var snake_speed = 100 #initial snake speed
var snake_width = Vector2(0.6, 0.6)

var snake_body : Array
var current_pos : Vector2 = global_position
var move_dir : Vector2

var playercam = Camera2D.new()
var player_score = 0
var player_level = 1
var last_z = 100

func _ready():
	generate_snake()

func generate_snake():
	snake_body.clear()
	
	add_head(current_pos, snake_width, snake_length)
	for i in range(1, snake_length):
		add_segment(current_pos + Vector2(0, i), snake_width, last_z - 1)
	playercam.make_current()
	playercam.zoom = Vector2(1.5, 1.5)
	snake_body[0].add_child(playercam)
	
func add_segment(pos, scale, z_index):
	var seg = snake_seg.instance()
	seg.scale = scale
	seg.position = pos
	seg.z_index = z_index
	last_z = z_index
	add_child(seg)
	snake_body.append(seg)

func add_head(pos, scale, z_index):
	var head = snake_head.instance()
	head.scale = scale
	head.position = pos
	head.z_index = z_index
	last_z = z_index
	add_child(head)
	snake_body.append(head)

func move_snake():
	var segment_vect : Vector2
	segment_vect = get_global_mouse_position() - snake_body[0].global_position
	
	snake_body[0].velocity = (segment_vect).normalized()*snake_speed
	
	for i in range(1, snake_length):
		segment_vect = snake_body[i-1].global_position - snake_body[i].global_position
		if segment_vect.length() > snake_seg_offset:
			snake_body[i].velocity = (segment_vect).normalized()*snake_speed
		else:
			snake_body[i].velocity = snake_body[i].velocity.normalized()*snake_speed
	
	current_pos = snake_body[0].global_position
			
func update_snake_params():
	add_segment(snake_body[-1].position, snake_width, last_z - 1)
	snake_length += 1
	for i in range(0, snake_length):
		snake_body[i].scale += Vector2(0.1, 0.1)
	snake_width = snake_body[0].scale
	snake_seg_offset += 5
			
func _process(_delta):
	player_score = snake_body[0].score
	var level = 1 + round(player_score/10)
	if player_level < level:
		update_snake_params()
		player_level = level
		playercam.zoom += Vector2(0.1, 0.1)
		
func _physics_process(_delta):
	move_snake()
	
func _input(event):
	if Input.is_action_pressed("speed_boost"):
		snake_speed = 300
	else:
		snake_speed = 100
	
	


