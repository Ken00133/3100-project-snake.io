class_name NPCsnake extends "res://characters/snake/Snake.gd"

# score and level
var score = 0
var level = 1

onready var _player : PlayerSnake = get_tree().get_root().get_node("game_play/SnakePlayer")
onready var _arena : Node2D = get_tree().get_root().get_node("game_play/arena")
onready var _detectionArea : Area2D = $detection

# NPC params
var rng = RandomNumberGenerator.new()
var isEating = false
var isFighting = false
var nearestFoodPos : Vector2
var RandomPos : Vector2
var target_enemy : KinematicBody2D
var possible_names = ["Jake", "Josh", "Peter", "Nat", "Ken", "Alex", "xXSnakeSlayerXx"]

#==============================================================================#

func _ready():
	RandomPos = gen_random_position()
	current_pos = gen_random_position()
	var snake_name = gen_random_name()
	generate_snake(snake_name)

func _physics_process(_delta):
	var current_velocity = drive_npc_snake_head(snake_body[0].velocity)
	move_snake(current_velocity)
	_detectionArea.position = snake_body[0].position

func _process(_delta):
	var new_score = snake_body[0].score
	if score < new_score:
		isEating = false
		score = new_score
		var new_lv = 1 + round(score/10)
		if level < new_lv:
			update_snake_params()
			level = new_lv
	if snake_body[0].is_dead:
		self.queue_free()

func _on_detection_area_entered(area):
	if area.is_in_group("food") and not isEating:
		nearestFoodPos = area.global_position
		isEating = true
	elif area.is_in_group("snakehead") and level > 1:
		target_enemy = area.get_parent()
		isFighting = true
		isEating = false

func _on_detection_area_exited(area):
	if area.is_in_group("snakehead"):
		target_enemy = null
		isFighting = false

# Drive the snake (head) base on player's mouse position
func drive_npc_snake_head(snake_velocity):
	
	var heading_vect : Vector2
	if isFighting and target_enemy:
		heading_vect = (target_enemy.global_position + target_enemy.velocity*1.5) - snake_body[0].global_position
	elif isEating:
		heading_vect = nearestFoodPos - snake_body[0].global_position
	else:
		heading_vect = RandomPos - snake_body[0].global_position
		if heading_vect.length() < 100:
			RandomPos = gen_random_position()
	
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

func gen_random_name():
	rng.randomize()
	var rand_ind = rng.randf_range(0, possible_names.size() - 1)
	return possible_names[rand_ind]
	
func gen_random_position():
	var pos : Vector2
	var arena_height = _arena.height
	var arena_width = _arena.width
	rng.randomize()
	pos.x = rng.randf_range(0, arena_width)
	pos.y = rng.randf_range(0, arena_height)
	
	return pos


