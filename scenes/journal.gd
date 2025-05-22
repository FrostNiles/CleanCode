extends Control

signal decision_made(selected_choice : int)

@onready var text_box = $Panel/RichTextLabel
@onready var button_1 = $Panel/Button
@onready var button_2 = $Panel/Button2
@onready var button_3 = $Panel/Button3
@onready var button_4 = $Panel/Button4
@onready var button_5 = $Panel/Button5
@onready var medkit_label = $Panel/MedkitLabel

@onready var health_bars = [
	$VBoxContainer/HealthBar1,
	$VBoxContainer/HealthBar2,
	$VBoxContainer/HealthBar3,
	$VBoxContainer/HealthBar4
]

var apply_choice_effect_func : Callable = Callable()

func _ready():
	button_1.pressed.connect(_on_choice_1)
	button_2.pressed.connect(_on_choice_2)
	Healthbars.medkits_changed.connect(_update_medkit_label)
	_update_health_bars()

func set_journal_text(text : String):
	text_box.text = text

func set_choice_texts(choice1 : String, choice2 : String):
	button_1.text = choice1
	button_2.text = choice2

func _on_choice_1():
	button_1.visible = false
	button_2.visible = false
	text_box.text = "Výsledek volby 1"
	if apply_choice_effect_func.is_valid():
		apply_choice_effect_func.call(1)
	_update_health_bars()
	emit_signal("decision_made", 1)

func _on_choice_2():
	button_1.visible = false
	button_2.visible = false
	text_box.text = "Výsledek volby 2"
	if apply_choice_effect_func.is_valid():
		apply_choice_effect_func.call(2)
	_update_health_bars()
	emit_signal("decision_made", 2)

func _update_health_bars():
	for i in health_bars.size():
		health_bars[i].value = Healthbars.get_health(i)
	_update_medkit_label()

func _update_medkit_label():
	if medkit_label:
		medkit_label.text = "Lékárničky: %d" % Healthbars.medkits
