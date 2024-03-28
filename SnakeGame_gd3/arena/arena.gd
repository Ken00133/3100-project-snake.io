extends Node2D



var height = 2000 * 4
var width = 3000 * 4

# Called when the node enters the scene tree for the first time.
func _ready():
	set_bounds()
	set_arena_background()

func set_bounds():
	var left = get_node("bounds/left")
	var right = get_node("bounds/right")
	var top = get_node("bounds/top")
	var bottom = get_node("bounds/bottom")
	var bar_width = 10
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
	left.position.x = -0.5 * bar_width
	left.position.y = height / 2
	right.position.x = width + bar_width / 2
	right.position.y = height / 2
	top.position.x = width / 2
	top.position.y = -0.5 * bar_width
	bottom.position.x = width / 2
	bottom.position.y = height + bar_width / 2
	

# func _on_bounds_body_entered(body):
	# if body.name == "SnakeSegment":
		# end_game()
		
func end_game():
	# update high_score, highest_length and highest_number_of_kills
	# compare them with those in db
	# achievement_condition_check() - > achievement_list
	# update the global variable
	
	
	
	# change scene
	var end_game_scene: PackedScene = preload("res://end_game_page/end_game_page.tscn")
	get_tree().change_scene_to(end_game_scene)
	
func achievement_condition_check():
	pass
	
	
#func _on_bounds_area_entered(area):
	#if area.is_in_group("snakehead"):
		#end_game()
		
func set_arena_background():
	var b = get_node("Panel/background")
	b.texture = load("res://images/gui/arena_background/bg_" + str(GlobalVariable.background_theme)+ ".png")

