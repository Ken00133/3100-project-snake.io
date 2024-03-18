extends KinematicBody2D  
export var velocity = Vector2(0,0)   

func _ready(): 	# for debuging 	
	var dum = GlobalVariable.username 
	print("in snake segment: ", dum) 
	change_skin() 

func change_skin(): 	
	var collosion_circle = get_node("CollisionShape2D") 
	var npc_snake = get_node("Sprite") 
	var path = "res://images/snake_skin/npc_ball_1.png" 
	npc_snake.texture = load(path) 	
	npc_snake.scale.x = -0.22 	
	npc_snake.scale.y = 0.25 	 	 
	
func _physics_process(_delta): 	
	rotation = velocity.angle() + PI/2 	
	velocity = move_and_slide(velocity)
