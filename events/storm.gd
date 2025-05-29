extends "res://scripts/general_event.gd"

func get_event_text() -> String:
	var lost = min(Healthbars.medkits, randi() % 3 + 1)
	return "Bouře zasáhla tábor a poškodila zásoby. Ztratili jsme %d lékárniček." % lost

func apply_event_effect():
	var lost = min(Healthbars.medkits, randi() % 3 + 1)
	Healthbars.add_medkit(-lost)

func get_next_scene_path() -> String:
	return "res://scenes/level9.tscn"
