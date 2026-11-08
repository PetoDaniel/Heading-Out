extends Node2D


@onready var player: CharacterBody2D = %Player
@onready var interaction_label: Label = %InteractionLabel
@onready var start_position: Marker2D = %StartPosition
@onready var door_spawn: Marker2D = %DoorSpawn

var player_near_door := false

func _ready() -> void:
	if GameManager.returning_home:
		player.global_position = door_spawn.global_position
		GameManager.returning_home = false
	else:
		player.global_position = start_position.global_position


func _on_door_body_entered(body: Node2D) -> void:
	if body == player:
		interaction_label.show()
		player_near_door = true


func _on_door_body_exited(body: Node2D) -> void:
	if body == player:
		interaction_label.hide()
		player_near_door = false


func _process(_delta: float) -> void:
	if player_near_door and Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file(GameManager.get_outdoor_scene())
