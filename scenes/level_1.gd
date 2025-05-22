extends Control

@onready var journal = $Journal
@onready var continue_button = $ContinueButton

func _ready():
	journal.set_journal_text("Den 1: Zásoby dochází. Měl by někdo vyrazit na průzkum?")
	journal.set_choice_texts("Vyslat George", "Zůstat všichni")

	
	journal.apply_choice_effect_func = Callable(self, "apply_choice_effect")

	journal.decision_made.connect(_on_decision_done)

	continue_button.visible = false
	continue_button.pressed.connect(_on_continue_pressed)

func apply_choice_effect(choice_id: int) -> void:
	if choice_id == 1:
		Healthbars.change_health(0, -20)  
	elif choice_id == 2:
		pass  

func _on_decision_done(selected_choice: int) -> void:
	continue_button.visible = true

func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level2.tscn")
	
