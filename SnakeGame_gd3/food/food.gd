extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var size = 1
# the score of food if snake eat
var score = size

# Called when the node enters the scene tree for the first time.
func _ready():
	var image = get_node("Sprite")
	var collision = get_node("CollisionShape2D")
	image.scale.x = size * 0.02
	image.scale.y = size * 0.02
	collision.scale.x = size
	collision.scale.y = size


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# snake eat food
func _on_food_body_entered(body):
	if body.name == "snakeHead":
		self.queue_free()
	# print(body.name)
