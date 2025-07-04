extends Control

signal decision_made(selected_choice : int)

@onready var text_box = $Panel/RichTextLabel
@onready var button_1 = $Panel/Button
@onready var button_2 = $Panel/Button2
@onready var button_3 = $Panel/Button3
@onready var button_4 = $Panel/Button4
@onready var button_5 = $Panel/Button5
@onready var button_6 = $Panel/Button6
@onready var medkit_label = $Panel/MedkitLabel
@onready var morale_label = $Panel/MoraleLabel

@onready var health_bars = [
	$VBoxContainerHealth/HBoxContainerG/HealthBarG,
	$VBoxContainerHealth/HBoxContainerJ/HealthBarJ,
	$VBoxContainerHealth/HBoxContainerD/HealthBarD,
	$VBoxContainerHealth/HBoxContainerM/HealthBarM
]

var apply_choice_effect_func : Callable = Callable()

func _ready():
	button_1.pressed.connect(_on_choice_1)
	button_2.pressed.connect(_on_choice_2)
	button_3.pressed.connect(_on_choice_3)
	button_4.pressed.connect(_on_choice_4)
	button_5.pressed.connect(_on_choice_5)
	button_6.pressed.connect(_on_choice_6)

	Healthbars.medkits_changed.connect(_update_medkit_label)
	Healthbars.morale_changed.connect(_update_morale_label)
	_update_health_bars()
	_update_morale_label()
	_update_buttons_enabled()

func set_journal_text(text : String):
	text_box.text = text

func set_choice_texts(choice1 : String, choice2 : String, choice3 : String = "", choice4 : String = "", choice5 : String = "", choice6 : String = ""):
	button_1.text = choice1
	button_2.text = choice2
	button_3.text = choice3
	button_4.text = choice4
	button_5.text = choice5
	button_6.text = choice6
	
	button_1.visible = choice1 != ""
	button_2.visible = choice2 != ""
	button_3.visible = choice3 != ""
	button_4.visible = choice4 != ""
	button_5.visible = choice5 != ""
	button_6.visible = choice6 != ""

	_update_buttons_enabled()

func _on_choice_1(): _process_choice(1)
func _on_choice_2(): _process_choice(2)
func _on_choice_3(): _process_choice(3)
func _on_choice_4(): _process_choice(4)
func _on_choice_5(): _process_choice(5)
func _on_choice_6(): _process_choice(6)

func _process_choice(choice_id : int):
	button_1.visible = false
	button_2.visible = false
	button_3.visible = false
	button_4.visible = false
	button_5.visible = false
	button_6.visible = false
	
	text_box.text = "Výsledek volby %d" % choice_id
	
	if apply_choice_effect_func.is_valid():
		apply_choice_effect_func.call(choice_id)
	
	_update_health_bars()
	_update_buttons_enabled()

	emit_signal("decision_made", choice_id)

func _update_health_bars():
	for i in range(health_bars.size()):
		health_bars[i].value = Healthbars.get_health(i)
	_update_medkit_label()

func _update_medkit_label():
	if medkit_label:
		medkit_label.text = "Lékárničky: %d" % Healthbars.medkits

func _update_morale_label():
	if morale_label:
		morale_label.value = Healthbars.get_morale()

func _update_buttons_enabled():
	for i in range(health_bars.size()):
		var health = Healthbars.get_health(i)
		match i:
			0: button_1.disabled = health <= 0
			1: button_2.disabled = health <= 0
			2: button_3.disabled = health <= 0
			3: button_4.disabled = health <= 0

	button_6.disabled = Healthbars.medkits < 3

func set_choice_result_texts(result1 : String, result2 : String, result3 : String = "", result4 : String = "", result5 : String = "", result6 : String = ""):
	pass
