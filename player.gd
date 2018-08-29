extends Area2D

var move_speed = 70
var direction = 0
var shot_scene = preload("res://shot.tscn")
var explosion_scene = preload("res://explosion.tscn")
var ready_to_fire = true

signal destroyed

func _process(delta):
	var screen_height = get_viewport().size.y
	var input_dir = Vector2();
	if direction !=0:
		input_dir.y += direction;
		move_speed += 5;
		position += input_dir * move_speed * delta;
		position.y = clamp(position.y, 0 + 10, screen_height - 0);
	else:
		move_speed = 70

func _input(event):
	if Input.is_key_pressed(KEY_UP) or Input.is_joy_button_pressed(0,JOY_BUTTON_8):
		direction = -1
	elif Input.is_key_pressed(KEY_DOWN) or Input.is_joy_button_pressed(0,JOY_BUTTON_9):
		direction = 1
	else:
		direction = 0

	if Input.is_key_pressed(KEY_SPACE) or Input.is_joy_button_pressed(0,JOY_R2):
		if ready_to_fire == true:
			var stage_node = get_parent()
			var shot_instance = shot_scene.instance()
			shot_instance.position = position
			stage_node.add_child(shot_instance)
			ready_to_fire = false
			$reload_timer.start()



func _on_player_area_entered(area):
	if area.is_in_group("astroid"):
		var scene = get_parent()
		var explosion_instance = explosion_scene.instance()
		explosion_instance.position = position
		scene.add_child(explosion_instance)
		emit_signal("destroyed")
		queue_free()


func _on_reload_timer_timeout():
	ready_to_fire = true
