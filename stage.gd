extends Node

var is_game_over = false
var astroid = preload("res://astroid.tscn")
var score = 0

func _ready():
	randomize()
	get_node("player").connect("destroyed", self, "_on_player_destroyed")
	pass
	
func _process(delta):
	get_node("spawn_timer").connect("timeout",self,"_on_spawn_timer_timeout")
	pass
	
func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	if is_game_over and Input.is_key_pressed(KEY_ENTER):
		get_tree().change_scene("res://stage.tscn")
	
func _on_player_destroyed():
	get_node("ui/retry").show()
	is_game_over = true
	
func _on_spawn_timer_timeout():
	var screen_size = get_viewport().size
	var astroid_instance = astroid.instance()
	astroid_instance.position = Vector2(screen_size.x,rand_range(0,screen_size.y))
	astroid_instance.connect("score", self, "_on_player_score")
	add_child(astroid_instance)
	
func _on_player_score():
	score += 1
	get_node("ui/score").text = "Score:" + str(score)