extends Control

@onready var journal = $Journal
@onready var continue_button = $ContinueButton

var outcomes = {}  
# Override this function in child scenes to provide level-specific data

func get_level_data() -> Dictionary:
	return {
		"journal_text": "",
		"choices": [],
		"results": [],
		"outcomes": {}
	}
# Called when a player makes a choice
func apply_choice_effect(choice_id: int) -> void:
	var result_text = ""
	var rand = randi() % 100

	if outcomes.has(choice_id):
		var outcome = outcomes[choice_id]
		if rand < outcome["injury_chance"]:
			Healthbars.change_health(outcome["member_index"], -outcome["injury_amount"])
			result_text = "%s byl zraněn!" % outcome.get("member_name", "Člen")
		elif rand < outcome["injury_chance"] + outcome["medkit_chance"]:
			Healthbars.add_medkit(1)
			result_text = "%s našel lékárničku!" % outcome.get("member_name", "Člen")
		else:
			result_text = "%s se vrátil bez zranění." % outcome.get("member_name", "Člen")
	else:
		result_text = "Nikdo nevyrazil."

	journal.set_journal_text(result_text)
# Initialization logic
func _ready():
	randomize()
	var data = get_level_data()

	journal.set_journal_text(data["journal_text"])
	var choices = data.get("choices", [])
	while choices.size() < 5:
		choices.append("")
	journal.set_choice_texts(choices[0], choices[1], choices[2], choices[3], choices[4])

	if "results" in data:
		var results = data["results"]
		while results.size() < 5:
			results.append("")
		journal.set_choice_result_texts(results[0], results[1], results[2], results[3], results[4])

	outcomes = data.get("outcomes", {})

	journal.apply_choice_effect_func = Callable(self, "apply_choice_effect")
	journal.decision_made.connect(_on_decision_done)

	continue_button.visible = false
	continue_button.pressed.connect(_on_continue_pressed)

func _on_decision_done(selected_choice: int) -> void:
	continue_button.visible = true

func _on_continue_pressed() -> void:
	pass  
