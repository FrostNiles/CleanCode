extends Node

signal medkits_changed  

var health_values = [100, 100, 100, 100]
var medkits = 5  

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
		if health_values[member_index] < 100:
			change_health(member_index, 30)
			medkits -= 1
			emit_signal("medkits_changed")
			return true
	return false
