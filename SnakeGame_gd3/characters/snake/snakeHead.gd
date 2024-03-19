extends KinematicBody2D

export var velocity = Vector2(0,0)
export var score = 0
export var energy = Vector2(0, 1)

onready var head = $headCollision
onready var energy_bar = $energy_bar

func _physics_process(delta):
	head.rotation = velocity.angle() + PI/2
	
	energy_bar_update()
	
	velocity = move_and_slide(velocity)
	
func energy_bar_update():
	energy_bar.rect_scale = energy
	if int(energy.x) == 1:
		energy_bar.modulate.a8 -= 10
	else:
		energy_bar.modulate.a8 = 255
	

func _on_headcollision_area_entered(area):
	if area.is_in_group("food"):
		score = score + area.score
