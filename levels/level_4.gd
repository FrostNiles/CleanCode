extends "res://scripts/general_level.gd"

func get_level_data() -> Dictionary:
	return {
		"journal_text": """\
Den 4:

Nalezeny zbytky starého přístřešku uprostřed džungle.
Možná tam najdeme nějaké zásoby nebo nástroje, ale cesta je plná nebezpečí.

Kdo se vydá to prozkoumat?""",

		"choices": [
			"Vyslat George",
			"Vyslat John",
			"Vyslat David",
			"Vyslat Mark",
			"Neposílat nikoho"
		],
		
		"results": [
			"George vyrazil.",
			"John vyrazil.",
			"David vyrazil.",
			"Mark vyrazil.",
			"Nikdo nevyrazil."
		],

		"outcomes": {
			1: {"injury_chance": 50, "medkit_chance": 30, "injury_amount": 50, "member_index": 0, "member_name": "George"},
			2: {"injury_chance": 50, "medkit_chance": 30, "injury_amount": 50, "member_index": 1, "member_name": "John"},
			3: {"injury_chance": 50, "medkit_chance": 30, "injury_amount": 50, "member_index": 2, "member_name": "David"},
			4: {"injury_chance": 50, "medkit_chance": 30, "injury_amount": 50, "member_index": 3, "member_name": "Mark"},
			5: {}
		}
	}
func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level5.tscn")
