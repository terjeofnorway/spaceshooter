extends Area2D

var explosion_scene = preload("res://explosion.tscn")
var move_speed = 50
var score_emitted = false

signal score

func _ready():
	randomize()
	var random = int(rand_range(1,3))
	get_node("sprite" + str(random)).show()
	

func _process(delta):
	position -= Vector2(move_speed * delta, 0)

func _on_astroid_area_entered(area):
	if area.is_in_group("shot") and score_emitted == false:
		emit_signal("score")
		score_emitted = true
	
	if area.is_in_group("shot") or area.is_in_group("player"):
		var scene = get_parent()
		var explosion_instance = explosion_scene.instance()
		explosion_instance.position = position
		scene.add_child(explosion_instance)
		queue_free()
	