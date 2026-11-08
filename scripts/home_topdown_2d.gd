extends Node2D


@onready var player: CharacterBody2D = %Player
@onready var interaction_label: Label = %InteractionLabel
var player_near_door: bool = false


func _on_door_body_entered(body: Node2D) -> void:
	if body == player:
		interaction_label.show()
		player_near_door = true

func _on_door_body_exited(body: Node2D) -> void:
	if body == player:
		interaction_label.hide()
		player_near_door = false
		

func _process(_delta: float) -> void:
	if player_near_door and Input.is_action_just_pressed("shift"):
		interaction_label.hide()
		print("Shift key is pressed")
