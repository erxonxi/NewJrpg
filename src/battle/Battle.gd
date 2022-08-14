extends Control
class_name Battle

signal characters_turn
signal enemy_turn

var characters: Array = []
var enemies: Array = []

var turn := 1
var enemy_selected := 0
var player_selected := 0

func initialize(battle_characters: Array, battle_enemies: Array):
	characters = battle_characters
	enemies = battle_enemies
	
	init_characters()
	init_enemies()
	init_first_character_menu()
	
	connect("characters_turn", self, "_on_characters_turn")
	connect("enemy_turn", self, "_on_enemy_turn")
		
func init_characters():
	var character_positions := [
		$Positions/Character1,
		$Positions/Character2,
		$Positions/Character3,
		$Positions/Character4
	]
	
	var index = 0
	for character in characters:
		character.skin.position = character_positions[index].position
		index += 1
	
func init_enemies():
	var enemy_positions := [
		$Positions/Enemy1,
		$Positions/Enemy2,
		$Positions/Enemy3,
		$Positions/Enemy4
	]
	
	var index = 0
	for enemy in enemies:
		enemy.skin.position = enemy_positions[index].position
		index += 1

func init_first_character_menu():
	var first_character: Character = characters[0]
	var attacks_names := ["", "", "", ""]
	var index = 0
	for attack in first_character.attacks.get_attacks():
		attack.initialize(1)
		attacks_names[index] = attack.attack_name
		index += 1
		
	set_attacks_names(attacks_names[0], attacks_names[1],attacks_names[2], attacks_names[3])
	
	var magics_names := ["", "", "", ""]
	index = 0
	for magic in first_character.magics.get_magics():
		magic.initialize(1)
		magics_names[index] = magic.magic_name
		index += 1
		
	set_magics_names(magics_names[0], magics_names[1],magics_names[2], magics_names[3])	

func set_attacks_names(attack1, attack2, attack3, attack4):
	$PlayerPanel/Container/Tabs/Attacks/Container1/Attack1.text = attack1
	$PlayerPanel/Container/Tabs/Attacks/Container1/Attack2.text = attack2
	$PlayerPanel/Container/Tabs/Attacks/Container2/Attack3.text = attack3
	$PlayerPanel/Container/Tabs/Attacks/Container2/Attack4.text = attack4

	if attack1 == "":
		$PlayerPanel/Container/Tabs/Attacks/Container1/Attack1.disabled = true
	if attack2 == "":
		$PlayerPanel/Container/Tabs/Attacks/Container1/Attack2.disabled = true
	if attack3 == "":
		$PlayerPanel/Container/Tabs/Attacks/Container2/Attack3.disabled = true
	if attack4 == "":
		$PlayerPanel/Container/Tabs/Attacks/Container2/Attack4.disabled = true
	
func set_magics_names(magic1, magic2, magic3, magic4):
	$PlayerPanel/Container/Tabs/Magics/Container1/Magic1.text = magic1
	$PlayerPanel/Container/Tabs/Magics/Container1/Magic2.text = magic2
	$PlayerPanel/Container/Tabs/Magics/Container2/Magic3.text = magic3
	$PlayerPanel/Container/Tabs/Magics/Container2/Magic4.text = magic4
	
	if magic1 == "":
		$PlayerPanel/Container/Tabs/Magics/Container1/Magic1.disabled = true
	if magic2 == "":
		$PlayerPanel/Container/Tabs/Magics/Container1/Magic2.disabled = true
	if magic3 == "":
		$PlayerPanel/Container/Tabs/Magics/Container2/Magic3.disabled = true
	if magic4 == "":
		$PlayerPanel/Container/Tabs/Magics/Container2/Magic4.disabled = true

func next_turn():
	var max_turn = characters.size() + enemies.size()
	if (turn < max_turn):
		turn += 1
	else:
		turn = 1
		
	if turn == 1:
		emit_signal("character_turn")
	elif turn == 2:
		emit_signal("enemy_turn")
	elif turn == 3:
		emit_signal("character_turn")
	elif turn == 4:
		emit_signal("enemy_turn")
	elif turn == 5:
		emit_signal("character_turn")
	elif turn == 6:
		emit_signal("enemy_turn")
	elif turn == 7:
		emit_signal("character_turn")
	elif turn == 8:
		emit_signal("enemy_turn")

func get_character_of_turn() -> Character:
	var character: Character
	if turn == 1:
		character = characters[0]
	elif turn == 3:
		character = characters[1]
	elif turn == 5:
		character = characters[2]
	elif turn == 7:
		character = characters[3]
	return character

func get_enemie_selected() -> Character:
	return enemies[enemy_selected] as Character

func attack_by_index(index: int):
	var character = get_character_of_turn()
	var attack: AttackSkill = character.attacks.get_attacks()[index]
	var hit = attack.get_hit(character.stats._get_strength())
	var enemy = get_enemie_selected()
	enemy.stats.take_damage(hit)

# Logic
func _on_characters_turn():
	$PlayerPanel/Container/Tabs.show()

func _on_enemy_turn():
	$PlayerPanel/Container/Tabs.hide()
	
	yield(get_tree().create_timer(2), "timeout")
	

# User Menu Buttons
func _on_Attack_pressed():
	$PlayerPanel/Container/Tabs.current_tab = 0

func _on_Magics_pressed():
	$PlayerPanel/Container/Tabs.current_tab = 1

func _on_Exit_pressed():
	print("Exiting battle...")

# Attacks Buttons
func _on_Attack1_pressed():
	attack_by_index(0)
	next_turn()

func _on_Attack2_pressed():
	attack_by_index(1)
	next_turn()

func _on_Attack3_pressed():
	attack_by_index(2)
	next_turn()

func _on_Attack4_pressed():
	attack_by_index(3)
	next_turn()

# Magics Buttons
func _on_Magic1_pressed():
	next_turn()

func _on_Magic2_pressed():
	next_turn()

func _on_Magic3_pressed():
	next_turn()

func _on_Magic4_pressed():
	next_turn()

