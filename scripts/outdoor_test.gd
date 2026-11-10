extends Node2D

@onready var text_label: Label = %TextLabel
@onready var player: CharacterBody2D = %Player
@onready var interaction_label: Label = $InteractionLabel

var player_reached_sidewalk := false
var player_near_home := false

func _on_sidewalk_collision_body_entered(body: Node2D) -> void:
	if body == player:
		if not player_reached_sidewalk:
			text_label.show()
		player_reached_sidewalk = true
		

func _on_home_collision_body_entered(body: Node2D) -> void:
	if body == player and player_reached_sidewalk:
		text_label.hide()
		interaction_label.show()
		player_near_home = true
	
func _on_home_collision_body_exited(body: Node2D) -> void:
	if body == player and player_reached_sidewalk:
		interaction_label.hide()
		player_near_home = false
	
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_near_home:
		GameManager.trip_count += 1
		GameManager.returning_home = true
			
		if GameManager.trip_count == 1:
			print("First comeback")
		elif GameManager.trip_count == 2:
			print("Second comeback")
		elif GameManager.trip_count > 2:
			print("You left too much stuff at home LOL")
				
		get_tree().change_scene_to_file(GameManager.get_home_scene())
		
