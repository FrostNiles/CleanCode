extends "res://scripts/general_level.gd"

func get_level_data() -> Dictionary:
	return {
		"journal_text": """\
Den 1:

Zásoby jsou téměř pryč. Voda dochází, oheň sotva hoří.
Noc byla neklidná – někdo slyšel kroky za táborem. Možná zvířata. Možná ne.

Musíte jednat. Možná tam venku něco je – opuštěný sklad, lékárnička, šance na přežití.
Ale cesta je nebezpečná.

Kdo půjde?""",
		
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
			1: {"injury_chance": 50, "medkit_chance": 30, "injury_amount": 50, "member_index": 0, "member_name": "George"},
			2: {"injury_chance": 50, "medkit_chance": 30, "injury_amount": 50, "member_index": 1, "member_name": "John"},
			3: {"injury_chance": 50, "medkit_chance": 30, "injury_amount": 50, "member_index": 2, "member_name": "David"},
			4: {"injury_chance": 50, "medkit_chance": 30, "injury_amount": 50, "member_index": 3, "member_name": "Mark"},
			5: {}
		}
	}


func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level2.tscn")
