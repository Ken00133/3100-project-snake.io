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
	var bar_width = 10
	# shape
	left_bound.shape.extents.x = bar_width
	left_bound.shape.extents.y = height
	right_bound.shape.extents.x = bar_width
	right_bound.shape.extents.y = height
	top_bound.shape.extents.x = width
	top_bound.shape.extents.y = bar_width
	bottom_bound.shape.extents.x = width
	bottom_bound.shape.extents.y = bar_width
	# position
	left_bound.position.x = -1 * bar_width
	left_bound.position.y = height / 2
	right_bound.position.x = width + bar_width
	right_bound.position.y = height / 2
	top_bound.position.x = width / 2
	top_bound.position.y = -1 * bar_width
	bottom_bound.position.x = width / 2
	bottom_bound.position.y = height + bar_width
	
	
func set_bounds():
	var left = get_node("bounds/left")
	var right = get_node("bounds/right")
	var top = get_node("bounds/top")
	var bottom = get_node("bounds/bottom")
	var bar_width = 1
	# shape
	left.shape.extents.x = bar_width
	left.shape.extents.y = height
	right.shape.extents.x = bar_width
	right.shape.extents.y = height
	top.shape.extents.x = width
	top.shape.extents.y = bar_width
	bottom.shape.extents.x = width
	bottom.shape.extents.y = bar_width
	# position
	left.position.x = bar_width
	left.position.y = height / 2
	right.position.x = width - bar_width
	right.position.y = height / 2
	top.position.x = width / 2
	top.position.y = bar_width
	bottom.position.x = width / 2
	bottom.position.y = height - bar_width
	

# func _on_bounds_body_entered(body):
	# if body.name == "SnakeSegment":
		# end_game()
		
func end_game():
	var end_game_scene: PackedScene = preload("res://end_game_page/end_game_page.tscn")
	get_tree().change_scene_to(end_game_scene)


func _on_bounds_area_entered(area):
	if area.is_in_group("snakehead"):
		end_game()
