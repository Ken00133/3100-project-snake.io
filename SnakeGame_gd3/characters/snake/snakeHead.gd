extends KinematicBody2D

export var velocity = Vector2(0,0)
export var score = 0

func _physics_process(delta):
	rotation = velocity.angle() + PI/2
	velocity = move_and_slide(velocity)
	
func _on_headcollision_area_entered(area):
	if area.is_in_group("food"):
		score = score + area.score
