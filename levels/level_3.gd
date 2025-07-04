extends "res://scripts/general_level.gd"

func get_level_data() -> Dictionary:
	return {
		"journal_text": """\
Den 3:

V noci jsme slyšeli něco většího než zvíře — těžké kroky a tiché mumlání.
Nikdo nespal. Napětí v táboře roste, stejně jako hlad a žízeň.

Nedaleko jsme zahlédli opuštěnou rybářskou chýši. Možná v ní zůstaly nějaké zásoby.
Ale co když není prázdná?

Kdo to půjde zjistit?""",

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
			1: {"injury_chance": 45, "medkit_chance": 30, "injury_amount": 50, "member_index": 0, "member_name": "George"},
			2: {"injury_chance": 45, "medkit_chance": 30, "injury_amount": 50, "member_index": 1, "member_name": "John"},
			3: {"injury_chance": 45, "medkit_chance": 30, "injury_amount": 50, "member_index": 2, "member_name": "David"},
			4: {"injury_chance": 45, "medkit_chance": 30, "injury_amount": 50, "member_index": 3, "member_name": "Mark"},
			5: {}
		}
	}
func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/boars.tscn")
