extends KinematicBody2D

onready var body = $segmentCollision

export var velocity = Vector2(0,0)
# var snake_skin = GlobalVariable.snake_skin
var snake_skin = 1
var character_id : String

func _ready():
	change_skin(snake_skin)
	character_id = String(get_parent().id)
	body.add_to_group(character_id)
	
func change_skin(skin_id):
	var snake = get_node("Sprite")
	var path = "res://images/snake_skin/ball_" + str(skin_id) + ".png"
	snake.texture = load(path)
	snake.scale.x = -0.25
	snake.scale.y = 0.25
	
func _physics_process(_delta):
	rotation = velocity.angle() + PI/2
	velocity = move_and_slide(velocity)
