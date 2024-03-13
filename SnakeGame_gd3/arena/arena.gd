extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var height = 2000
var width = 3000

# Called when the node enters the scene tree for the first time.
func _ready():
	set_arena_size()
	

func set_arena_size():
	var left_bound = get_node("StaticBody2D/left_bound")
	var right_bound = get_node("StaticBody2D/right_bound")
	var top_bound = get_node("StaticBody2D/top_bound")
	var bottom_bound = get_node("StaticBody2D/bottom_bound")
	# to be continued
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
