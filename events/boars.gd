extends "res://scripts/general_event.gd"

func get_event_text() -> String:
	return "V noci vtrhla do tábora divoká prasata a zaútočila!"

func apply_event_effect():
	var living = []
	for i in range(Healthbars.health_values.size()):
		if Healthbars.get_health(i) > 0:
			living.append(i)

	living.shuffle()
	for i in range(min(2, living.size())):
		Healthbars.change_health(living[i], -50)

func get_next_scene_path() -> String:
	var all_dead = true
	for hp in Healthbars.health_values:
		if hp > 0:
			all_dead = false
			break
	if all_dead:
		return "res://scenes/game_over_1.tscn"
	else:
		return "res://scenes/level4.tscn"

func _on_game_over(reason: String) -> void:
	pass
