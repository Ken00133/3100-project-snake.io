extends Node2D

var database = PostgreSQLClient.new()
var user = "postgres"
var host = "localhost"
var password = "csci3100"
var port = 5432
var databaseConnection = "postgres"



# Called when the node enters the scene tree for the first time.
func _ready():
	database.connect("connection_established", self, "successConnection")
	database.connect("connection_closed", self, "closedConnection")
	
	database.connect_to_host("postgresql://%s:%s@%s:%d/%s" % [user, password, host, port, databaseConnection])
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	database.poll()
	
func _exit_tree():
	database.close()
	
func successConnection():
	print("Connection is successful")
	
func closedConnection(was_closed):
	print("Connection is closed")
	
func select_from(table_name):
	
	var data = database.execute("""
	BEGIN;
	SELECT * FROM %s;
	COMMIT;
	""" % [table_name] )
	
	
	for d in data[1].data_row:
		print(d)
		pass
	
func insert_into_db(table_name, username, score, sound):
	var data = database.execute("""
	BEGIN;
	INSERT INTO %s (username, score, sound) VALUES ('%s', %d, %d);
	COMMIT;
	""" % [table_name, username, score, sound] 
	)
func update_db(table_name, username, score, sound):
	var data = database.execute("""
	BEGIN;
	UPDATE %s SET score=%d, sound=%d WHERE username='%s';
	COMMIT;
	""" % [table_name, score, sound, username] 
	)
	
	
func _on_Button_button_down():
	select_from("user_profile")
	


func _on_Quit_button_button_down():
	get_tree().quit()


func _on_insert_button_down():
	insert_into_db("user_profile", "jelly", 100, 10)


func _on_update_button_down():
	update_db("user_profile", "lovy", 0, 0)
