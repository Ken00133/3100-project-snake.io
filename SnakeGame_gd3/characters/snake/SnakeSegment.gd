extends KinematicBody2D

export var velocity = Vector2(0,0)

func _physics_process(delta):
	rotation = velocity.angle() + PI/2
	velocity = move_and_slide(velocity)
