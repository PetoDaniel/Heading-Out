extends Control



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		GameManager.trip_count += 1
		GameManager.returning_home = true
		
		if GameManager.trip_count == 1:
			print("First comeback")
		elif GameManager.trip_count == 2:
			print("Second comeback")
		elif GameManager.trip_count > 2:
			print("You left too much stuff at home LOL")

		get_tree().change_scene_to_file(GameManager.get_home_scene())
