extends Node
class_name Game

var battle_scene = preload("res://src/battle/Battle.tscn")

func _ready():
	$MainMenu.connect("new_game", self, "new_game")
	
func new_game():
	start_battle()
	
func start_battle():
	var battle: Battle = battle_scene.instance()
	battle.initialize()
	get_parent().add_child(battle)
