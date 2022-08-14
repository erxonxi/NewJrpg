extends Node
class_name Game

var battle_scene = preload("res://src/battle/Battle.tscn")
var character_scene = preload("res://src/characters/Character.tscn")

func _ready():
	$MainMenu.connect("new_game", self, "new_game")
	
func new_game():
	start_battle()
	
func start_battle():
	var battle: Battle = battle_scene.instance()
	var first_character: Character = character_scene.instance()
	first_character.initialize(1, 64)
	$Party.add_child(first_character)
	battle.initialize($Party.get_children(), [])
	get_parent().add_child(battle)
