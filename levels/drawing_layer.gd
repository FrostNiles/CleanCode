extends Node2D

@onready var inputs = get_parent().get_node("Inputs")
@onready var outputs = get_parent().get_node("Outputs")
@onready var connections = get_parent().connections
@onready var wire_colors = get_parent().wire_colors

func _draw():
	for input_name in connections.keys():
		var output_name = connections[input_name]

		var input_button = inputs.get_node(input_name)
		var output_button = outputs.get_node(output_name)

		if input_button and output_button:
			var start = input_button.get_global_position() + input_button.size / 2 - global_position
			var end = output_button.get_global_position() + output_button.size / 2 - global_position

			var color = wire_colors.get(input_name, Color.WHITE)
			draw_line(start, end, color, 3.0)
