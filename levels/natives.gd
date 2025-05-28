extends "res://scripts/general_level.gd"

var current_stage = "choose_action"  
var pending_choice = 0 

func get_level_data() -> Dictionary:
	return {
		"journal_text": "Přicházejí domorodci a požadují oběť. Buď jim dáte 3 lékárničky, nebo jednoho člena výpravy.",
		"choices": [
			"",
			"", "", "", "Obětovat člena týmu", "Obětovat 3 lékárničky"
		],
		"results": [
			"",
			"", "", "", "Vyberte člena k obětování.", "Domorodci odešli spokojeni."
		],
		"outcomes": {}  
	}

func apply_choice_effect(choice_id: int) -> void:
	if current_stage == "choose_action":
		pending_choice = choice_id
		if choice_id == 6:
			if Healthbars.medkits >= 3:
				Healthbars.medkits -= 3
				Healthbars.change_morale(10)
				journal.set_journal_text("Domorodci vzali lékárničky a odešli v míru. Morálka +10.")
				continue_button.visible = true
			#!!!
			else:
				journal.set_journal_text("Nemáte dostatek lékárniček!")
				continue_button.visible = false  

		elif choice_id == 5:
			current_stage = "choose_member"
			journal.set_journal_text("Vyberte člena k obětování:")
			journal.set_choice_texts("George", "John", "David", "Mark", "")
			continue_button.visible = false

	elif current_stage == "choose_member":
		var names = ["George", "John", "David", "Mark"]
		var idx = choice_id - 1
		if idx >= 0 and idx < names.size():
			Healthbars.change_health(idx, -100)
			Healthbars.change_morale(-15)
			journal.set_journal_text("%s byl obětován. Morálka -15." % names[idx])
			
			if Healthbars.morale <= 0 or Healthbars.health_values.count(0) == Healthbars.health_values.size():
				get_tree().change_scene_to_file("res://scenes/game_over_1.tscn")
				return
			
			current_stage = "done"
			continue_button.visible = true
		else:
			journal.set_journal_text("Neplatná volba člena.")
			continue_button.visible = false

func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/boars.tscn")
