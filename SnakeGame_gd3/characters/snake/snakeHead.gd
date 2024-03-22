extends KinematicBody2D

onready var head = $headCollision
onready var energy_bar = $energy_bar
onready var heading = $heading
onready var snakename = $snakename

export var velocity = Vector2(0,0)
export var score = 0
export var energy = Vector2(0, 1)
export var uname : String

func _ready():
	change_skin("3")
	snakename.text = uname
	
func energy_bar_update():
	energy_bar.rect_scale = energy
	if int(energy.x) == 1:
		energy_bar.modulate.a8 -= 10
	else:
		energy_bar.modulate.a8 = 255
	
func _on_headcollision_area_entered(area):
	if area.is_in_group("food"):
		score = score + area.score

func change_skin(skin_id):
	var collosion_circle = get_node("headCollision/CollisionShape2D")
	var snake = get_node("headCollision/head")
	print(skin_id)
	var path = "res://images/snake_skin/ball_" + skin_id + ".png"
	snake.texture = load(path)
	snake.scale.x = 0.25
	snake.scale.y = -0.25
	
func _physics_process(_delta):
	head.rotation = velocity.angle() + PI/2
	velocity = move_and_slide(velocity)
	energy_bar_update()
