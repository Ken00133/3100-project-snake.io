extends KinematicBody2D

export var velocity = Vector2(0,0)


func _ready():
	# for debuging
	var dum = GlobalVariable.username

	
	var data = DatabaseUtils.database.execute("""
	BEGIN;
	SELECT * FROM %s;
	COMMIT;
	""" % ["user_profile"] )
	
	
	for d in data[1].data_row:
		print(d)
		pass
		
	change_skin("4")
	
	
func change_skin(skin_id):
	var collosion_circle = get_node("CollisionShape2D")
	var snake = get_node("Sprite")
	print(skin_id)
	var path = "res://images/snake_skin/ball_" + skin_id + ".png"
	snake.texture = load(path)
	snake.scale.x = -0.22
	snake.scale.y = 0.25
	
	
func _physics_process(_delta):
	rotation = velocity.angle() + PI/2
	velocity = move_and_slide(velocity)
