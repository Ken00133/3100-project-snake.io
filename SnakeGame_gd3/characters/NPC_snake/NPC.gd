extends Node2D

var snake_seg = load("res://characters/NPC_snake/NPCSnakeSegment.tscn")
var snake_head = load("res://characters/NPC_snake/NPCSnakeHead.tscn")

# Snake motion vars
var npc_snake_seg_offset = 20
var npc_snake_length = 6
var npc_snake_speed = 500
var npc_snake_body: Array = []

var npc_start_pos: Vector2
var npc_move_dir: Vector2 = Vector2.ZERO

func _ready():
	randomize()  # Initialize random number generator
	generate_snake()

func generate_snake():
	npc_snake_body.clear()
	npc_start_pos = global_position + Vector2(100, 100)
	add_head(npc_start_pos, npc_snake_length)
	for i in range(1, npc_snake_length):
		add_segment(npc_start_pos + Vector2(0, i * npc_snake_seg_offset), npc_snake_length - i)
	npc_move_dir = random_direction()

func add_segment(pos, z_index):
	var seg = snake_seg.instance()
	seg.scale = Vector2(0.6, 0.6)
	seg.position = pos
	add_child(seg)
	npc_snake_body.append(seg)

func add_head(pos, z_index):
	var head = snake_head.instance()
	head.scale = Vector2(0.6, 0.6)
	head.position = pos
	add_child(head)
	npc_snake_body.append(head)

func move_snake(delta):
	var arena_height = 2000
	var arena_width = 3000
	var margin = 50 # Margin from the boundary where the snake starts turning
	var pos = npc_snake_body[0].position

	##if pos.x < margin:
	#	npc_move_dir.x = abs(npc_move_dir.x)
	#if pos.x > arena_width - margin:
	#	npc_move_dir.x = -abs(npc_move_dir.x)
	#if pos.y < margin:
	#	npc_move_dir.y = abs(npc_move_dir.y)
	#if pos.y > arena_height - margin:
	#	npc_move_dir.y = -abs(npc_move_dir.y)
		
	#else:  # Occasionally change direction randomly
	#	npc_move_dir = random_direction()
	npc_move_dir = random_direction()
	
	if npc_snake_body.size() > 0:
		npc_snake_body[0].position += npc_move_dir * npc_snake_speed * delta
		for i in range(1, npc_snake_length):
			var segment_vect = npc_snake_body[i-1].position - npc_snake_body[i].position
			if segment_vect.length() > npc_snake_seg_offset * 1.5:
				npc_snake_body[i].position += segment_vect.normalized() * npc_snake_speed * delta

func random_direction() -> Vector2:
	return Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized()

func _physics_process(delta):
	move_snake(delta)
