extends Node
class_name Game

var battle_scene = preload("res://src/battle/Battle.tscn")
var character_scene = preload("res://src/characters/Character.tscn")

var battle: Battle = null
var level: int = 0

func _ready():
	$Overlay.hide()
	$MainMenu.connect("new_game", self, "new_game")
	
func new_game():
	Team.members.append({
		'id': 2,
		'experience': 64,
		'attacks_ids': [1],
		'magics_ids': [1]
	})
	
	start_battle()
	
func start_battle():
	set_up_party()
	set_up_enemies()
	set_up_battle()

func set_up_party():
	for children in $Party.get_children():
		$Party.remove_child(children)
		children.queue_free()
		
	for member in Team.members:
		var character: Character = character_scene.instance()
		character.initialize(
			member['id'],
			member['experience'],
			member['attacks_ids'],
			member['magics_ids']
		)
		$Party.add_child(character)

func set_up_enemies():
	for children in $Enemies.get_children():
		children.queue_free()
		
	for enemy in Levels.enemies[level]:
		var character: Character = character_scene.instance()
		character.initialize(
			enemy['id'],
			enemy['experience'],
			enemy['attacks_ids'],
			enemy['magics_ids']
		)
		$Enemies.add_child(character)

func set_up_battle():
	battle = battle_scene.instance()
	battle.initialize($Party.get_children(), $Enemies.get_children())
	battle.connect("victory", self, "_on_vicotry")
	battle.connect("defeat", self, "_on_defeat")
	
	get_parent().add_child(battle)

func game_complated():
	battle.queue_free()
	$Overlay/Panel/Label.text = "Game Completed"
	$Overlay/Panel/Buttons.hide()
	$Overlay.show()

func _on_vicotry():
	battle.queue_free()
	$Overlay/Panel/Label.text = "Victory"
	$Overlay.show()

func _on_defeat():
	battle.queue_free()
	$Overlay/Panel/Label.text = "Defeat"
	$Overlay/Panel/Buttons/NextLevel.hide()
	$Overlay.show()

func _on_NextLevel_pressed():
	if (level < Levels.enemies.size()):
		level += 1
		set_up_party()
		set_up_enemies()
		set_up_battle()
		$Overlay.hide()
	else:
		game_complated()

func _on_Restart_pressed():
	level = 0
	Team.members = []
	new_game()

func _on_Exit_pressed():
	get_tree().quit()
