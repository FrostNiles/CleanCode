extends Control


func _on_restart_pressed() -> void:
	Healthbars.reset()
	get_tree().change_scene_to_file("res://scenes/level1.tscn")



func _on_end_pressed() -> void:
	get_tree().quit()
