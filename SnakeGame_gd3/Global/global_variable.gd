extends Node

# This script is used for sharing global variables

var username 
var master_volume 
var snake_skin
var background_theme
var high_score
var highest_length
var highest_number_of_kills
var achievement:Array

signal OK_to_set_master_volume

#func _ready():
	# To do: get username form backend
	#username = "wosy"
	#DatabaseUtils.connect("databaseConnected", self, "get_user_attribute")

var ws = WebSocketClient.new()

func _ready():
	ws.connect("connection_established", self, "_on_connection_established")
	ws.connect("connection_error", self, "_on_connection_error")
	ws.connect("connection_closed", self, "_on_connection_closed")
	ws.connect("server_close_request", self, "_on_server_close_request")
	ws.connect("data_received", self, "_on_data_received")

	var url = "ws://localhost:5000" # Change this to your WebSocket server URL
	ws.connect_to_url(url)
	print("Attempting to connect to WebSocket server at ", url)

func _process(delta):
	ws.poll()

func _on_connection_established(protocol):
	print("Connected to the WebSocket server with protocol: ", protocol)

func _on_connection_error():
	print("Failed to connect to the WebSocket server.")

func _on_connection_closed(was_clean_close):
	print("WebSocket connection closed. Clean close: ", was_clean_close)

func _on_server_close_request(code, reason):
	print("Server requested to close the connection. Code: ", code, ", Reason: ", reason)
	ws.close(code, reason)

func _on_data_received():
	var data = ws.get_peer(1).get_packet().get_string_from_utf8()
	print("Data received from the WebSocket server: ", data)
	var message = parse_json(data)
	if message and message.type == "user-login":
		var username = message.username
		# Display username here or perform further actions
		print("User logged in: ", username)
		
func _exit_tree():
	update_user_profile_database()


func update_user_achievement_in_db():
	var achievement_temp:String = String()
	for i in achievement.size() - 1:
		if achievement[i] == true:
			achievement_temp = achievement_temp + "t, "
		elif achievement[i] == false:
			achievement_temp = achievement_temp + "f, "
	if achievement[-1] == true:
		achievement_temp = achievement_temp + "t"
	elif achievement[-1] == false:
		achievement_temp = achievement_temp + "f"
		
	DatabaseUtils.database.execute("""
	BEGIN;
	UPDATE %s SET achievement='{%s}'WHERE username='%s';
	COMMIT;
	""" % ["user_profile", achievement_temp, username] 
	)
func update_user_profile_database():
	DatabaseUtils.database.execute("""
	BEGIN;
	UPDATE %s SET high_score=%d, highest_length=%d, highest_number_of_kills=%d, 
	master_volume=%d, snake_skin=%d, background_theme=%d WHERE username='%s';
	COMMIT;
	""" % ["user_profile", high_score, highest_length, highest_number_of_kills,master_volume,
		snake_skin, background_theme, username] 
	)
	
	update_user_achievement_in_db()
	
func get_user_attribute():
	set_master_volume()
	emit_signal("OK_to_set_master_volume")
	set_snake_skin()
	set_background_theme()
	set_achievement()
	set_high_score()
	set_highest_length()
	set_highest_number_of_kills()
	
func set_master_volume():
	# query master volume of the user 
	var master_volume_data = DatabaseUtils.database.execute("""
	BEGIN;
	SELECT master_volume FROM %s WHERE username='%s';
	COMMIT;
	""" % ["user_profile", GlobalVariable.username] )
	for temp in master_volume_data[1].data_row:
		master_volume = temp[0] 
	
func set_highest_length():
	
	var highest_length_data = DatabaseUtils.database.execute("""
	BEGIN;
	SELECT highest_length FROM %s WHERE username='%s';
	COMMIT;
	""" % ["user_profile", username] )
	
	for temp in highest_length_data[1].data_row:
		highest_length = temp[0]
		
func set_snake_skin():
	
	# query snake skin of the user 
	var snake_skin_data = DatabaseUtils.database.execute("""
	BEGIN;
	SELECT snake_skin FROM %s WHERE username='%s';
	COMMIT;
	""" % ["user_profile", username] )
	
	# set snake_skin
	for temp in snake_skin_data[1].data_row:
		snake_skin = temp[0]
		
func set_highest_number_of_kills():
	
	var highest_number_of_kills_data = DatabaseUtils.database.execute("""
	BEGIN;
	SELECT highest_number_of_kills FROM %s WHERE username='%s';
	COMMIT;
	""" % ["user_profile", username] )
	
	for temp in highest_number_of_kills_data[1].data_row:
		highest_number_of_kills = temp[0]
		
func set_background_theme():
	var background_theme_data = DatabaseUtils.database.execute("""
	BEGIN;
	SELECT background_theme FROM %s WHERE username='%s';
	COMMIT;
	""" % ["user_profile", username] )
	
	for temp in background_theme_data[1].data_row:
		background_theme = temp[0]
		
func set_high_score():
	var high_score_data = DatabaseUtils.database.execute("""
	BEGIN;
	SELECT high_score FROM %s WHERE username='%s';
	COMMIT;
	""" % ["user_profile", username] )
	
	for temp in high_score_data[1].data_row:
		high_score = temp[0]
		
func set_achievement():
	var achievement_data = DatabaseUtils.database.execute("""
	BEGIN;
	SELECT achievement FROM %s WHERE username='%s';
	COMMIT;
	""" % ["user_profile", username] )
	
	achievement = parse_achievement(achievement_data[1].data_row[0][0])
	
func parse_achievement(achievement_list):
	var temp_list = []
	for num in achievement_list:
		if num == 116:
			temp_list.append(true)
		elif num == 102:
			temp_list.append(false)
			
	return temp_list
	
