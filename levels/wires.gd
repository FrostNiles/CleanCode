extends Control

@onready var inputs = $Inputs
@onready var outputs = $Outputs
@onready var drawing_layer = $DrawingLayer
@onready var success_label = $SuccessLabel
@onready var continue_button = $ContinueButton

var current_input : String = ""
var connections : Dictionary = {}

# Definuj správná spojení
var correct_connections := {
	"A1": "B2",
	"A2": "B3",
	"A3": "B1"
}

# Barvy drátů
var wire_colors := {
	"A1": Color.RED,
	"A2": Color.GREEN,
	"A3": Color.BLUE}

func _ready():
	success_label.visible = false
	continue_button.visible = false
	continue_button.pressed.connect(_on_continue_pressed)

	
	for input_name in correct_connections.keys():
		var btn = inputs.get_node(input_name)
		btn.pressed.connect(func(): _on_input_selected(input_name))
		btn.modulate = wire_colors.get(input_name, Color.WHITE)

	
	for input_name in correct_connections:
		var output_name = correct_connections[input_name]
		var btn = outputs.get_node(output_name)
		btn.pressed.connect(func(): _on_output_selected(output_name))
		btn.modulate = wire_colors.get(input_name, Color.WHITE)

func _on_input_selected(name: String):
	current_input = name

func _on_output_selected(name: String):
	if current_input == "":
		return
	connections[current_input] = name
	current_input = ""
	drawing_layer.queue_redraw()
	_check_success()

func _check_success():
	if connections.size() < correct_connections.size():
		return

	for key in correct_connections:
		if connections.get(key, "") != correct_connections[key]:
			return

	success_label.text = "ÚSPĚCH!"
	success_label.visible = true
	continue_button.visible = true

func _on_continue_pressed():
	get_tree().change_scene_to_file("res://scenes/end.tscn")
