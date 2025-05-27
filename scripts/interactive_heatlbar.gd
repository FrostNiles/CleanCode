extends ProgressBar

@export var member_index: int = 0

func _ready():
	set_mouse_filter(Control.MOUSE_FILTER_STOP)

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if Healthbars.use_medkit(member_index):
			value = Healthbars.get_health(member_index)
