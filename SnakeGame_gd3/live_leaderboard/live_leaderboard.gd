extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	update_player_score()
	update_player_rank(player_rank())
	update_live_leaderboard()

# get the score and name of player
func player_score_name():
	var player = get_parent().get_node("SnakePlayer")
	var score = int(player.player_score)
	var name = player.get_node("snakeHead").uname
	return [score, name]

# update the player score on the left live leaderboard
func update_player_score():
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

# customize sorting function
class MyCustomSorter:
	static func sort_score(a, b):
		if a[0] > b[0]:
			return true
		return false

func sort_NPC():
	var NPCs_sn = npc_score_name()
	# sort NPC score name
	NPCs_sn.sort_custom(MyCustomSorter, "sort_score")
	return NPCs_sn
	
func player_rank():
	var player_sn = player_score_name()
	var NPCs_sn = sort_NPC()
	var rank = 1
	for NPC_sn in NPCs_sn:
		if player_sn[0] > NPC_sn[0]:
			return rank
		rank = rank + 1
	return rank

func update_player_rank(rank):
	var label = get_node("player_rank")
	label.text = "Your rank: " + str(rank)

func update_live_leaderboard_label(rank, name, score):
	var rank_label = get_node("rank")
	var name_label = get_node("name")
	var score_label = get_node("score")
	rank_label.text += "\n" + str(rank)
	name_label.text += "\n" + name
	score_label.text += "\n" + str(score)
	
func clear_live_leaderboard():
	var rank_label = get_node("rank")
	var name_label = get_node("name")
	var score_label = get_node("score")
	rank_label.text = "Rank"
	name_label.text = "Snake Name"
	score_label.text = "Score"
	
func update_live_leaderboard():
	var NPCs_sn = sort_NPC()
	var player_sn = player_score_name()
	var player_r = player_rank()
	var snake_number = NPCs_sn.size()
	
	clear_live_leaderboard()
	
	var current_rank = 1
	for i in range(5):
		if i > snake_number:
			return
		if player_r == i + 1:
			update_live_leaderboard_label(player_r, player_sn[1], player_sn[0])
		else:
			update_live_leaderboard_label(i + 1, NPCs_sn[current_rank - 1][1], NPCs_sn[current_rank - 1][0])
			current_rank += 1


func _on_Timer_timeout():
	update_player_score()
	update_player_rank(player_rank())
	update_live_leaderboard()
