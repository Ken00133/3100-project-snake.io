extends Node2D
class_name PlayerSnake

# Snake componements
export var snake_seg : PackedScene
export var snake_head : PackedScene

# Player's camera
var playercam = Camera2D.new()
var init_zoom = Vector2(1,1)

# Snake motion vars
var snake_length = 5 # initial snake length
var snake_width = Vector2(0.6, 0.6)
var snake_seg_offset = 20
var snake_speed = 100 # initial snake speed
var snake_rotation_speed = 2 # initial rotational speed
var current_velocity : Vector2

# Speed boost parameters
var max_boost_energy : float = snake_length*100
var boost_energy = max_boost_energy
var recover_speed = 1 #How fast speed boost energy is replenished

# Snake body and position
var snake_body : Array
var current_pos : Vector2 = global_position

# Player score and level
var player_score = 0
var player_level = 1

# First (head) z-index
var last_z = 100

#==============================================================================#

func _ready():
	generate_snake()

func _process(_delta):
	player_score = snake_body[0].score
	var level = 1 + round(player_score/10)
	if player_level < level:
		update_snake_params()
		player_level = level
		playercam.zoom += Vector2(0.1, 0.1)

func _physics_process(_delta):
	move_snake()

func _input(_event):
	if Input.is_action_pressed("speed_boost") and boost_energy > 0:
		snake_speed = 300
	else:
		snake_speed = 100

#==============================================================================#

# Spawn the whole snake body and nudge it
func generate_snake():
	snake_body.clear()
	
	add_head(current_pos, snake_width, snake_length)
	add_segments(snake_length)
	add_camera(init_zoom)
	
	snake_body[0].velocity = Vector2(snake_speed, 0)

func add_segments(length):
	for i in range(1, length):
		add_segment(current_pos + Vector2(0, i), snake_width, last_z - 1)

# Spawn a snake segment
func add_segment(pos, scale, z_index):
	var seg = snake_seg.instance()
	seg.scale = scale
	seg.position = pos
	seg.z_index = z_index
	last_z = z_index
	add_child(seg)
	snake_body.append(seg)
	return seg

# Spawn a snake head
func add_head(pos, scale, z_index):
	var head = snake_head.instance()
	head.scale = scale
	head.position = pos
	head.z_index = z_index
	last_z = z_index
	add_child(head)
	snake_body.append(head)
	return head

# Init player cam, make it follow the snake head
func add_camera(zoom):
	playercam.make_current()
	playercam.zoom = zoom
	snake_body[0].add_child(playercam)

# Move the snake frame by frame
func move_snake():
	
	current_velocity = drive_SnakeHead(snake_body[0].velocity)
	snake_body[0].velocity = current_velocity
	
	var segment_vect : Vector2
	for i in range(1, snake_length):
		segment_vect = snake_body[i-1].global_position - snake_body[i].global_position
		if segment_vect.length() > snake_seg_offset:
			snake_body[i].velocity = (segment_vect).normalized()*snake_speed
		else:
			snake_body[i].velocity = snake_body[i].velocity.normalized()*snake_speed
	
	current_pos = snake_body[0].global_position
	
	if snake_speed == 300 and boost_energy >= 2:
		boost_energy -= 2
	elif boost_energy < max_boost_energy:
		boost_energy += recover_speed
	snake_body[0].energy = Vector2((boost_energy/max_boost_energy), 1.0)

# Drive the snake (head) base on player's mouse position
func drive_SnakeHead(snake_velocity):
	
	var heading_vect : Vector2
	heading_vect = get_global_mouse_position() - (snake_body[0].global_position)
	snake_body[0].heading.rect_rotation = rad2deg(heading_vect.angle() + PI/2)
	
	var dif = rad2deg(snake_velocity.angle() - heading_vect.angle())
	if dif < 0 and dif > -180 or dif > 180:
		if snake_rotation_speed < abs(dif):
			snake_velocity = snake_velocity.rotated(deg2rad(snake_rotation_speed))
		else:
			snake_velocity = snake_velocity.rotated(deg2rad(abs(dif)))
	elif dif > 0 and dif < 180 or dif < -180:
		if snake_rotation_speed < abs(dif):
			snake_velocity = snake_velocity.rotated(-deg2rad(snake_rotation_speed))
		else:
			snake_velocity = snake_velocity.rotated(-deg2rad(abs(dif)))
	
	snake_velocity = (snake_velocity).normalized()*snake_speed
	return snake_velocity
	
# Level up the snake when invoked
func update_snake_params():
	
	add_segment(snake_body[-1].position, snake_width, last_z - 1)
	
	snake_length += 1
	max_boost_energy = snake_length*100
	recover_speed += 1
	snake_rotation_speed *= 0.89
	
	for i in range(0, snake_length):
		snake_body[i].scale += Vector2(0.1, 0.1)
	
	snake_width = snake_body[0].scale
	snake_seg_offset += 5
	




