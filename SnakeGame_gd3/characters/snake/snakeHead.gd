class_name SnakeHead extends KinematicBody2D

onready var head = $headCollision
onready var energy_bar = $energy_bar
onready var heading = $heading
onready var snakename = $snakename

export var velocity = Vector2(0,0)
export var score = 0
export var energy = Vector2(0, 1)
export var uname : String

var character_id : String
var is_dead = false

var snake_skin = GlobalVariable.snake_skin
func _ready():
	change_head_skin(snake_skin)
	snakename.text = uname
	character_id = String(get_parent().id)
	head.add_to_group(character_id)

func _on_headcollision_area_entered(area):
	if area.is_in_group("food"):
		score = score + area.score
	elif area.is_in_group("snakehead") or area.is_in_group("snakeSeg") or area.is_in_group("bounds"):
		if not area.is_in_group(character_id):
			is_dead = true

func energy_bar_update():
	energy_bar.rect_scale = energy
	if int(energy.x) == 1:
		energy_bar.modulate.a8 -= 10
	else:
		energy_bar.modulate.a8 = 255

func change_head_skin(skin_id):
	var snake_head = get_node("headCollision/head")
	var path = "res://images/snake_skin/skin_" + str(skin_id) + ".png"
	snake_head.texture = load(path)
	snake_head.scale.x = 0.25
	snake_head.scale.y = -0.25
	
func _physics_process(_delta):
	head.rotation = velocity.angle() + PI/2
	velocity = move_and_slide(velocity)
	energy_bar_update()
