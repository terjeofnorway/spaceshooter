extends Node2D

const MOVE_SPEED = 500

func _process(delta):
	var screen_width = get_viewport().size.x
	position += Vector2(MOVE_SPEED * delta, 0);

	if position.x > screen_width:
		queue_free()
	

func _on_shot_area_entered(area):
	if area.is_in_group("astroid"):
		queue_free()