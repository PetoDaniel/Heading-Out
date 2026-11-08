extends Node


var returning_home := false
var trip_count: int = 0

func get_home_scene() -> String:
	match trip_count:
		1:
			return "res://scenes/levels/home_second_test.tscn"
		2:
			return "res://scenes/levels/home_topdown_2d.tscn"
		_:
			return "res://scenes/levels/home_topdown_2d.tscn"

func get_outdoor_scene() -> String:
	match trip_count:
		0:
			return "res://scenes/levels/outdoor_test.tscn"
		1:
			return "res://scenes/levels/outdoor_second_test.tscn"
		_:
			return "res://scenes/levels/outdoor_test.tscn"
