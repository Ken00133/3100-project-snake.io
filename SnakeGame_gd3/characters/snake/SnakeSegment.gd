extends KinematicBody2D

export var velocity = Vector2(0,0)


func _ready():
	# for debuging
	var dum = GlobalVariable.username

	
	var snake_skin_data = DatabaseUtils.database.execute("""
	BEGIN;
	SELECT snake_skin FROM %s WHERE username='%s';
	COMMIT;
	""" % ["user_profile", GlobalVariable.username] )
	
	
	for snake_skin in snake_skin_data[1].data_row:
		print(snake_skin)
		change_skin(snake_skin[0])
		
	
	
	
func change_skin(skin_id):
	var snake = get_node("Sprite")
	var path = "res://images/snake_skin/ball_" + str(skin_id) + ".png"
	snake.texture = load(path)
	snake.scale.x = -0.22
	snake.scale.y = 0.25
	
	
func _physics_process(_delta):
	rotation = velocity.angle() + PI/2
	velocity = move_and_slide(velocity)
