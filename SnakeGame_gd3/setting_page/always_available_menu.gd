extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("MenuButton").get_popup().add_item("Reset")
	get_node("MenuButton").get_popup().add_item("Clear High Score")
	get_node("MenuButton").get_popup().add_item("Exit")
	$MenuButton.get_popup().connect("id_pressed", self, "_on_item_pressed")
	
func _on_item_pressed(id):
	var item_name = get_node("MenuButton").get_popup().get_item_text(id)
	if item_name == "Reset":
		get_tree().change_scene("res://title_page/title_page.tscn")
	elif item_name == "Clear High Score":
		GlobalVariable.high_score = 0
		
	elif item_name == "Exit":
		get_tree().quit()
