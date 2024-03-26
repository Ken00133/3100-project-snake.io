class_name npc_spawner extends Node2D

var snake_npc : PackedScene = preload("res://characters/snake/SnakeNPC.tscn") 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var max_npc_num = 20
var init_spawn_num = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(init_spawn_num):
		spawn_npc()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawn_npc():
	var npc = snake_npc.instance()
	add_child(npc)

func _on_Timer_timeout():
	var npc_num = get_child_count()
	if npc_num < max_npc_num:
		spawn_npc()
