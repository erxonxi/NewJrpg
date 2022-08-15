extends Node
class_name Game

var battle_scene = preload("res://src/battle/Battle.tscn")
var character_scene = preload("res://src/characters/Character.tscn")

var battle: Battle = null
var level: int = 0

func _ready():
	$MainMenu.show()
	$Overlay.hide()
	$Rewards.hide()
	$MainMenu.connect("new_game", self, "new_game")
	
func new_game():
	Team.members.append({
		'id': 2,
		'experience': 1,
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
		$Enemies.remove_child(children)
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

func show_rewards():
	$Rewards.show()
	$Party.hide()
	$Rewards/Entities.hide()
	set_reward_by_index(1, 1, 75 * level)
	set_reward_by_index(2, 2, 75 * level)
	set_reward_by_index(3, 3, 75 * level)
	
func set_reward_by_index(index, character_index, experience):
	var character: Character = character_scene.instance()
	character.initialize(
		character_index,
		experience,
		[1],
		[1]
	)
	$Rewards/Entities.add_child(character)
	
	if (index == 1):
		$Rewards/Panel/Container/Char1/Name.text = character.character_name
		$Rewards/Panel/Container/Char1/Level.text = "LVL %s" % String(character.level)
		$Rewards/Panel/Container/Char1/TextureRect.texture = character.get_texture()
	elif index == 2:
		$Rewards/Panel/Container/Char2/Name.text = character.character_name
		$Rewards/Panel/Container/Char2/Level.text = "LVL %s" % String(character.level)
		$Rewards/Panel/Container/Char2/TextureRect.texture = character.get_texture()
	elif index == 3:
		$Rewards/Panel/Container/Char3/Name.text = character.character_name
		$Rewards/Panel/Container/Char3/Level.text = "LVL %s" % String(character.level)
		$Rewards/Panel/Container/Char3/TextureRect.texture = character.get_texture()

func _on_vicotry():
	for memmber in Team.members:
		memmber.experience += 100 * level
	
	battle.queue_free()
	$Overlay/Panel/Label.text = "Victory"
	$Overlay/Panel/Buttons.show()
	$Overlay/Panel/Buttons/NextLevel.show()
	$Overlay/Panel/Buttons/Restart.show()
	$Overlay/Panel/Buttons/Exit.show()
	
	if level == Levels.enemies.size() - 1:
		$Overlay/Panel/Buttons/NextLevel.hide()
		$Overlay/Panel/Label.text = "Game Completed!"
	
	$Overlay.show()

func _on_defeat():
	battle.queue_free()
	$Overlay/Panel/Label.text = "You lose"
	$Overlay/Panel/Buttons.show()
	$Overlay/Panel/Buttons/NextLevel.hide()
	$Overlay/Panel/Buttons/Restart.show()
	$Overlay/Panel/Buttons/Exit.show()
	$Overlay.show()

func _on_NextLevel_pressed():
	if (level < Levels.enemies.size()):
		level += 1
		
		if (level % 5 == 0):
			show_rewards()
		else:
			start_battle()
		
		$Overlay.hide()
	else:
		game_complated()

func _on_Restart_pressed():
	level = 0
	Team.members = []
	new_game()
	$Overlay.hide()

func _on_Exit_pressed():
	get_tree().quit()

func _on_Select_Character1_pressed():
	var reward: Character = $Rewards/Entities.get_children()[0]
	
	Team.members.append({
		'id': reward.index,
		'experience': reward.experience,
		'attacks_ids': reward.attacks_ids,
		'magics_ids': reward.magics_ids
	})
	
	start_battle()
	$Rewards.hide()
	$Party.show()

func _on_Select_Character2_pressed():
	var reward: Character = $Rewards/Entities.get_children()[1]
	
	Team.members.append({
		'id': reward.index,
		'experience': reward.experience,
		'attacks_ids': reward.attacks_ids,
		'magics_ids': reward.magics_ids
	})
	
	start_battle()
	$Rewards.hide()
	$Party.show()


func _on_Select_Character3_pressed():
	var reward: Character = $Rewards/Entities.get_children()[2]
	
	Team.members.append({
		'id': reward.index,
		'experience': reward.experience,
		'attacks_ids': reward.attacks_ids,
		'magics_ids': reward.magics_ids
	})
	
	start_battle()
	$Rewards.hide()
	$Party.show()
