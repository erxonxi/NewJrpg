extends Node
class_name AttackSkill

var attack_name := "AttackSkill"
var index := 1
var multiplier := 0

func initialize(attack_index: int):
	index = attack_index
	var attack = load("res://resources/attacks/Attack%s.tres" % index) as Skill
	multiplier = attack.multiplier
	attack_name = attack.name
	
func get_hit(value: int) -> int:
	return int(value * multiplier)
