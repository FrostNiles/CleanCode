extends "res://scripts/general_level.gd"

func get_level_data() -> Dictionary:
	return {
		"journal_text": """\
Den 5:

Situace je kritická. Některé zásoby jsme ztratili a morálka klesá.
Musíme udělat pokus o získání zásob na druhé straně ostrova.

Kdo půjde na výpravu?""",

		"choices": [
			"Vyslat George",
			"Vyslat Johna",
			"Vyslat Davida",
			"Vyslat Marka",
			"Nikdo"
		],

		"results": [
			"George šel na výpravu.",
			"John šel na výpravu.",
			"David šel na výpravu.",
			"Mark šel na výpravu.",
			"Nikdo nešel."
		],

		"outcomes": {
			1: {"injury_chance": 50, "medkit_chance": 20, "injury_amount": 50, "member_index": 0, "member_name": "George"},
			2: {"injury_chance": 50, "medkit_chance": 20, "injury_amount": 50, "member_index": 1, "member_name": "John"},
			3: {"injury_chance": 50, "medkit_chance": 20, "injury_amount": 50, "member_index": 2, "member_name": "David"},
			4: {"injury_chance": 50, "medkit_chance": 20, "injury_amount": 50, "member_index": 3, "member_name": "Mark"},
			5: {}
		}
	}
func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/natives.tscn")
