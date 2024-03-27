class_name PlayerSnake extends "res://characters/snake/Snake.gd"

# Player score and level
var player_score = 0
var player_level = 1

# Player's camera
var username = GlobalVariable.username
var playercam = Camera2D.new()
var init_zoom = Vector2(1,1)

#===============================engine functions===============================#

func _ready():
	generate_snake(username)
	add_camera(init_zoom)

func _process(_delta):
	player_score = snake_body[0].score
	var level = 1 + round(player_score/10)
	if player_level < level:
		update_snake_params()
		player_level = level
		playercam.zoom += Vector2(0.1, 0.1)
	if snake_body[0].is_dead:
		end_game()

func _physics_process(_delta):
	var current_velocity = drive_player_snake_head(snake_body[0].velocity)
	move_snake(current_velocity)

func _input(_event):
	if Input.is_action_pressed("speed_boost") and boost_energy > 0:
		snake_speed = 300
	else:
		snake_speed = 100

# Drive the snake (head) base on player's mouse position
func drive_player_snake_head(snake_velocity):
	
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

# Init player cam, make it follow the snake head
func add_camera(zoom):
	playercam.make_current()
	playercam.zoom = zoom
	snake_body[0].add_child(playercam)

func end_game():
	# update high_score, highest_length and highest_number_of_kills
	# compare them with those in db
	# achievement_condition_check() - > achievement_list
	# update the global variable
	# change scene
	var end_game_scene: PackedScene = preload("res://end_game_page/end_game_page.tscn")
	get_tree().change_scene_to(end_game_scene)


