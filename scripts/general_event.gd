extends Control

@onready var text_box = $RichTextLabel
@onready var continue_button = $ContinueButton

func _ready():
	Healthbars.game_over.connect(_on_game_over)

	text_box.text = get_event_text()
	apply_event_effect()

	continue_button.visible = true
	continue_button.pressed.connect(_on_continue_pressed)

func get_event_text() -> String:
	return "Nastala událost."

func apply_event_effect():
	pass

func get_next_scene_path() -> String:
	return "res://scenes/next_scene.tscn" 

func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file(get_next_scene_path())

func _on_game_over(reason: String) -> void:
	text_box.text = "Konec hry: %s" % reason
	call_deferred("_change_to_game_over_scene")

func _change_to_game_over_scene() -> void:
	if get_tree() != null:
		get_tree().change_scene_to_file("res://scenes/game_over_1.tscn")
