extends Node2D

# Snake componements
export var snake_seg : PackedScene
export var snake_head : PackedScene
export var energy_bar : PackedScene

# Snake motion vars
var snake_length = 5 # initial snake length
var snake_width = Vector2(0.6, 0.6)
var snake_seg_offset = 20
var snake_speed = 100 # initial snake speed
var snake_rotation_speed = 2 # initial rotational speed

# Speed boost parameters
var max_boost_energy : float = snake_length*100
var boost_energy = max_boost_energy
var recover_speed = 1 #How fast speed boost energy is replenished

# Snake body and position
var snake_body : Array
var current_pos : Vector2 = global_position

# Player score and level
var score = 0
var level = 1

# First (head) z-index
var last_z = 100

func _ready():
	generate_snake()

func _process(_delta):
	score = snake_body[0].score
	var new_lv = 1 + round(score/10)
	if level < new_lv:
		update_snake_params()
		level = new_lv
