extends Control

@onready var journal = $Journal
@onready var continue_button = $ContinueButton

func _ready():
	journal.set_journal_text("Den 2: V noci byla slyšet bouřka. Něco je jinak.")
	journal.set_choice_texts("Zkontrolovat zásoby", "Ignorovat a spát dál")

	# Přiřadíme funkci zpracování efektů volby
	journal.apply_choice_effect_func = Callable(self, "apply_choice_effect")

	journal.decision_made.connect(_on_decision_done)

	continue_button.visible = false
	continue_button.pressed.connect(_on_continue_pressed)

func apply_choice_effect(choice_id: int) -> void:
	# Zpracuj dopad volby na zdraví jednotlivých členů
	if choice_id == 1:
		Healthbars.change_health(2, -15) 
	elif choice_id == 2:
		pass

func _on_decision_done(selected_choice: int) -> void:
	continue_button.visible = true

func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level3.tscn")
