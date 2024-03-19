extends KinematicBody2D

export var velocity = Vector2(0,0)


var snake_skin

func _ready():
	change_skin(snake_skin)
		
	
	
	
func change_skin(snake_skin):
	var snake = get_node("Sprite")
	var path = "res://images/snake_skin/ball_" + str(snake_skin) + ".png"
	snake.texture = load(path)
	snake.scale.x = -0.22
	snake.scale.y = 0.25
	
	
func _physics_process(_delta):
	rotation = velocity.angle() + PI/2
	velocity = move_and_slide(velocity)
