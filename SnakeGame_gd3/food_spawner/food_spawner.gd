class_name Food_Spawer extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var food_scene: PackedScene = preload("res://food/food.tscn")
var max_food = 100
# food size
var max_food_size = 4
var min_food_size = 1

func spawn_food():
	var position_of_food = food_position()
	var size_of_food = food_size()
	var food = food_scene.instance()
	food.position = position_of_food
	food.size = size_of_food
	get_parent().get_node("arena").get_node("foods").add_child(food)
	
	
# find position to spawn food
func food_position():
	# bound
	var arena = get_parent().get_node("arena")
	var height = arena.height
	var width = arena.width
	# ignore the snake first
	# snake position
	# var player = get_parent().get_node("SnakePlayer")
	# var player_position = player.current_pos
	var buffer = 20
	var spawn_position: Vector2 = Vector2.ZERO
	spawn_position.x = rand_range(buffer, width - buffer)
	spawn_position.y = rand_range(buffer, height - buffer)
	return spawn_position
	
# random generate food size	
func food_size():
	var size = 0
	size = rand_range(min_food_size, max_food_size)
	return size
	
# check if total food number > food size
func exceed_max_food():
	var current_number = get_parent().get_node("arena").get_node("foods").get_child_count()
	if current_number < max_food:
		return false
	return true
	
func _ready():
	var room = 20
	# generate max_food - room number of food
	for i in range(max_food - room):
		spawn_food()

# continuously generate food until food number = max_food 
func _on_Timer_timeout():
	if !exceed_max_food():
		spawn_food()
	# print(get_parent().get_node("arena").get_node("foods").get_child_count())

# when a snake eat a food, should remove the food from parent node foods

