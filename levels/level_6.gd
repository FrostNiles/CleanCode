extends "res://scripts/general_level.gd"

func get_level_data() -> Dictionary:
	return {
		"journal_text": """\
Den 6:

Dnes ráno jsme našli podivné stopy kolem tábora. Nejsou naše... a vedou do džungle.

Měli bychom někoho vyslat, aby je prozkoumal?""",

		"choices": [
			"Vyslat George",
			"Vyslat Johna",
			"Vyslat Davida",
			"Vyslat Marka",
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
			1: {"injury_chance": 40, "medkit_chance": 25, "injury_amount": 50, "member_index": 0, "member_name": "George"},
			2: {"injury_chance": 40, "medkit_chance": 30, "injury_amount": 50, "member_index": 1, "member_name": "John"},
			3: {"injury_chance": 40, "medkit_chance": 20, "injury_amount": 50, "member_index": 2, "member_name": "David"},
			4: {"injury_chance": 40, "medkit_chance": 40, "injury_amount": 50, "member_index": 3, "member_name": "Mark"},
			5: {}
		}
	}

func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level7.tscn")
