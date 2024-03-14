extends KinematicBody2D

export var velocity = Vector2(0,0)


func _ready():
	var dum = get_tree().get_nodes_in_group("res://customization/customization.tscn")
	print(dum)
	change_skin("2")
	
	
func change_skin(skin_id):
	var collosion_circle = get_node("CollisionShape2D")
	var snake = get_node("Sprite")
	print(skin_id)
	var path = "res://images/snake_skin/circle_" + skin_id + ".png"
	snake.texture = load(path)
	snake.scale.x = -0.1
	snake.scale.y = 0.1
	
	
func _physics_process(_delta):
	rotation = velocity.angle() + PI/2
	velocity = move_and_slide(velocity)
