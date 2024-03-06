extends CharacterBody2D

func _physics_process(delta):
	rotation = velocity.angle() + PI/2
	move_and_slide()
