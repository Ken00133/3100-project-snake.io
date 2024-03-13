extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	display_message()
	
# display player's rank, level and score
func display_message():
	var died_message = get_node("died_message")
	died_message.text = "You died\n" + "Your rank is ..."
	var label_length = died_message.rect_size.x
	var label_height = died_message.rect_size.y
	var window_length = OS.get_window_size()[0]
	var window_height = OS.get_window_size()[1]
	# put label in the center
	died_message.rect_position.x = window_length / 2 - label_length
	died_message.rect_position.y = window_height / 2 - label_height
