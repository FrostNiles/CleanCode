extends Node

signal medkits_changed
signal morale_changed
signal game_over

var health_values = [0, 10, 0, 0]
var medkits = 3
var morale = 5

func change_health(member_index: int, amount: int):
	if member_index >= 0 and member_index < health_values.size():
		health_values[member_index] = clamp(health_values[member_index] + amount, 0, 100)
		_check_game_over()

func get_health(member_index: int) -> int:
	if member_index >= 0 and member_index < health_values.size():
		return health_values[member_index]
	return 0

func add_medkit(amount: int = 1):
	medkits += amount
	emit_signal("medkits_changed")

func use_medkit(member_index: int) -> bool:
	if medkits > 0 and member_index >= 0 and member_index < health_values.size():
		if health_values[member_index] < 100 and health_values[member_index] > 0:
			change_health(member_index, 30)
			medkits -= 1
			emit_signal("medkits_changed")
			return true
	return false

func change_morale(amount: int):
	morale = clamp(morale + amount, 0, 100)
	emit_signal("morale_changed")
	_check_game_over()

func get_morale() -> int:
	return morale

func _check_game_over():
	
	if morale <= 0:
		emit_signal("game_over", "Morálka týmu klesla na nulu.")
		return

	
	var all_dead = true
	for hp in health_values:
		if hp > 0:
			all_dead = false
			break
	if all_dead:
		emit_signal("game_over", "Všichni členové výpravy jsou mrtví.")
