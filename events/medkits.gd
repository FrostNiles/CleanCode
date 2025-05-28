extends "res://scripts/general_event.gd"

func get_event_text() -> String:
	return "V táboře byly nalezeny 2 lékárničky!"

func apply_event_effect():
	Healthbars.add_medkit(2)

func get_next_scene_path() -> String:
	return "res://scenes/level5.tscn"  
