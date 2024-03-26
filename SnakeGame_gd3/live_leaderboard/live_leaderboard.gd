extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	modify_player_score()

# get the score and name of player
func player_score_name():
	var player = get_parent().get_node("SnakePlayer")
	var score = int(player.player_score)
	var name = player.get_node("snakeHead").uname
	return [score, name]

# modify the player score on the left live leaderboard
func modify_player_score():
	var label = get_node("player_score")
	var score = player_score_name()[0]
	label.text = "Your score: " + str(score)
	
func npc_score_name():
	# SnakeNPCs are the children of npc_spawner
	# but the first child of npc_spawner is Timer
	# so SnakeNPCs are the children of npc_spawner after its first child
	var npc_spawner_children = get_parent().get_node("npc_spawner").get_children()
	var NPCs = npc_spawner_children.slice(1, npc_spawner_children.size(), 1)
	var number_NPC = NPCs.size()
	var score_name = []
	for i in range(number_NPC):
		var score = int(NPCs[i].score)
		var name = NPCs[i].get_node("snakeHead").uname
		score_name.append([score, name])
	return score_name

func compare_score():
	pass
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
	npc_score_name()
