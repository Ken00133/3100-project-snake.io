class_name Snake extends Node2D

# Snake componements
var snake_seg : PackedScene = preload("res://characters/snake/SnakeSegment.tscn")
var snake_head : PackedScene = preload("res://characters/snake/snakeHead.tscn")

# Snake motion vars
var snake_length = 5 # initial snake length
var snake_width = Vector2(0.6, 0.6)
var snake_seg_offset = 20
var snake_speed = 100 # initial snake speed
var snake_rotation_speed = 2 # initial rotational speed
# Snake body and position
var snake_body : Array
var current_pos : Vector2 = global_position
var current_velocity : Vector2

# Speed boost parameters
var max_boost_energy : float = snake_length*100
var current_boost_energy = max_boost_energy
var energy_recover_speed = 1 #How fast speed boost energy is replenished

# First (head) z-index
var last_z = 100
# Unique id of character
var id = get_instance_id()

# Spawn the whole snake body and nudge it
func generate_snake(snake_name : String) -> void:
	snake_body.clear()
	add_head(current_pos, snake_width, snake_length, snake_name)
	add_segment_range(snake_length)
	
	snake_body[0].velocity = Vector2(snake_speed, 0)

func add_segment_range(length : int) -> void:
	for i in range(1, length):
		add_segment(current_pos + Vector2(0, i), snake_width, last_z - 1)

# Spawn a snake segment
func add_segment(pos : Vector2, scale : Vector2, z_index : int):
	var seg = snake_seg.instance()
	seg.scale = scale
	seg.position = pos
	seg.z_index = z_index
	last_z = z_index
	add_child(seg)
	snake_body.append(seg)
	return seg

# Spawn a snake head
func add_head(pos, scale, z_index, name):
	var head = snake_head.instance()
	head.scale = scale
	head.position = pos
	head.z_index = z_index
	head.uname = name
	
	last_z = z_index
	add_child(head)
	snake_body.append(head)
	return head

# Move the snake frame by frame
func move_snake(current_velocity):
	
	snake_body[0].velocity = current_velocity
	
	var segment_vect : Vector2
	for i in range(1, snake_length):
		segment_vect = snake_body[i-1].global_position - snake_body[i].global_position
		if segment_vect.length() > snake_seg_offset:
			snake_body[i].velocity = (segment_vect).normalized()*snake_speed
		else:
			snake_body[i].velocity = snake_body[i].velocity.normalized()*snake_speed
	
	current_pos = snake_body[0].global_position
	
	if snake_speed == 300 and current_boost_energy >= 2:
		current_boost_energy -= 2
	elif current_boost_energy < max_boost_energy:
		current_boost_energy += energy_recover_speed
	snake_body[0].energy = Vector2((current_boost_energy/max_boost_energy), 1.0)
	
# Level up the snake when invoked
func update_snake_params():
	
	add_segment(snake_body[-1].position, snake_width, last_z - 1)
	
	snake_length += 1
	max_boost_energy = snake_length*100
	energy_recover_speed += 1
	snake_rotation_speed *= 0.89
	
	for i in range(0, snake_length):
		snake_body[i].scale += Vector2(0.1, 0.1)
	
	snake_width = snake_body[0].scale
	snake_seg_offset += 5
