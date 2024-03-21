extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	modify_player_score()

func player_score():
	var player = get_parent().get_node("SnakePlayer")
	return int(player.player_score)

func modify_player_score():
	var label = get_node("player_score")
	var score = player_score()
	label.text = "Your score: " + str(score)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	var id_label = get_node("id")
#	var score_label = get_node("score")
#	var level_label = get_node("level")
#	var rank_label = get_node("rank")
#	var player = get_node("../Snake")
	
#	id_label.text = "Snake ID\n" + str(player.player_id)
#	score_label.text = "Score\n" + str(player.player_score)
#	level_label.text = "Level\n" + str(player.player_level)
#	rank_label.text = "Rank\n1"


func _on_Timer_timeout():
	modify_player_score()
