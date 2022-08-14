extends Node
class_name MagicSkill

var magic_name := "MagicSkill"
var index := 1
var multiplier := 0

func initialize(magic_index: int):
	index = magic_index
	var magic = load("res://resources/magics/Magic%s.tres" % index) as Skill
	multiplier = magic.multiplier
	magic_name = magic.name
	
func get_hit(value: int) -> int:
	return int(value * multiplier)
