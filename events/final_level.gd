extends "res://scripts/general_level.gd"

var correct_member_index = -1
var final_mission_index = -1

func get_level_data() -> Dictionary:
	final_mission_index = randi() % 4  

	var journal_text := ""
	var results := ["", "", "", "", "", ""]
	var choices := ["George", "John", "David", "Mark", "", ""]

	match final_mission_index:
		0:
			journal_text = "Finální den, jde do tuhýho. V troskách vysílače našli kus funkční techniky. Jeden z vás se může pokusit ho opravit..."
			results[0] = "George se pokusí opravit vysílač."
			results[1] = "John se pokusí opravit vysílač."
			results[2] = "David se pokusí opravit vysílač."
			results[3] = "Mark se pokusí opravit vysílač."
			correct_member_index = 3 

		1:
			journal_text = "Šance na záchranu jsou tu. Na východním útesu plápolá oheň. Může jít o zraněné nebo nemocné. Někdo zkušený s první pomocí by tam měl vyrazit.."
			results[0] = "George jde navázat kontakt."
			results[1] = "John jde navázat kontakt."
			results[2] = "David jde navázat kontakt."
			results[3] = "Mark jde navázat kontakt."
			correct_member_index = 0  

		2:
			journal_text = "Šance na záchranu jsou stále a stále větší, jenže se blíží tropická nemoc. Jeden z vás se musí pokusit najít a připravit lék z místních rostlin."
			results[0] = "George hledá léčivé byliny."
			results[1] = "John hledá léčivé byliny."
			results[2] = "David hledá léčivé byliny."
			results[3] = "Mark hledá léčivé byliny."
			correct_member_index = 1 

		3:
			journal_text = "V jeskyni pod ostrovem je silný signál. Někdo se tam musí vydat a lokalizovat zdroj."
			results[0] = "George se vydává do jeskyně."
			results[1] = "John se vydává do jeskyně."
			results[2] = "David se vydává do jeskyně."
			results[3] = "Mark se vydává do jeskyně."
			correct_member_index = 2 

	return {
		"journal_text": journal_text,
		"choices": choices,
		"results": results,
		"outcomes": {} 
	}

func apply_choice_effect(choice_id: int) -> void:
	var selected_index = choice_id - 1

	if selected_index == correct_member_index:
		journal.set_journal_text("Akce byla úspěšná! Zachránili jste celou výpravu.")
		continue_button.visible = true
		await get_tree().create_timer(2.0).timeout 
		get_tree().change_scene_to_file("res://scenes/end.tscn")
	else:
		journal.set_journal_text("Mise selhala. Člen nebyl vhodný pro tuto akci...")
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://scenes/game_over_1.tscn")

func _on_continue_pressed() -> void:
	pass 
