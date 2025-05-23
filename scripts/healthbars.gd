extends Node

signal medkits_changed  
signal morale_changed  

var health_values = [10, 0, 100, 100]
var medkits = 100
var morale = 10

func change_health(member_index: int, amount: int):
	if member_index >= 0 and member_index < health_values.size():
		health_values[member_index] = clamp(health_values[member_index] + amount, 0, 100)

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

func get_morale() -> int:
	return morale
