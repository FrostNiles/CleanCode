extends Control

@onready var journal = $Journal
@onready var continue_button = $ContinueButton

var outcomes = {}  

func get_level_data() -> Dictionary:
	return {
		"journal_text": "",
		"choices": [],
		"results": [],
		"outcomes": {}
	}

func apply_choice_effect(choice_id: int) -> void:
	var result_text = ""
	var rand = randi() % 100

	if outcomes.has(choice_id) and !outcomes[choice_id].is_empty():
		var outcome = outcomes[choice_id]
		var member_name = outcome.get("member_name", "Člen")
		var injury_chance = outcome.get("injury_chance", 0)
		var medkit_chance = outcome.get("medkit_chance", 0)
		var injury_amount = outcome.get("injury_amount", 0)
		var member_index = outcome.get("member_index", 0)
		Healthbars.change_morale(10)

		if rand < outcome["injury_chance"]:
			Healthbars.change_health(outcome["member_index"], -outcome["injury_amount"])
			result_text = "%s byl zraněn!" % member_name
		elif rand < outcome["injury_chance"] + outcome["medkit_chance"]:
			Healthbars.add_medkit(1)
			Healthbars.change_morale(5)  
			result_text = "%s našel lékárničku!" % member_name
		else:
			result_text = "%s se vrátil bez zranění." % member_name
	else:
		Healthbars.change_morale(-30)
		result_text = "Nikdo nevyrazil."

	journal.set_journal_text(result_text)

func _ready():
	randomize()
	var data = get_level_data()
	Healthbars.game_over.connect(_on_game_over)

	journal.set_journal_text(data.get("journal_text", ""))

	var choices = data.get("choices", [])
	while choices.size() < 6:
		choices.append("")
	journal.set_choice_texts(choices[0], choices[1], choices[2], choices[3], choices[4], choices[5])

	if "results" in data:
		var results = data["results"]
		while results.size() < 6:
			results.append("")
		journal.set_choice_result_texts(results[0], results[1], results[2], results[3], results[4], results[5])

	outcomes = data.get("outcomes", {})

	journal.apply_choice_effect_func = Callable(self, "apply_choice_effect")
	journal.decision_made.connect(_on_decision_done)

	continue_button.visible = false
	continue_button.pressed.connect(_on_continue_pressed)

func _on_decision_done(_selected_choice: int) -> void:
	continue_button.visible = true

func _on_continue_pressed() -> void:
	pass

func _on_game_over(reason: String) -> void:
	journal.set_journal_text("Konec hry: %s" % reason)
	
	
	call_deferred("_change_to_game_over_scene")

func _change_to_game_over_scene() -> void:
	if get_tree() != null:
		get_tree().change_scene_to_file("res://scenes/game_over_1.tscn")
