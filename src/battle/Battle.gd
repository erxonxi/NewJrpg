extends Control
class_name Battle

var characters: Array = []
var enemies: Array = []

func initialize(battle_characters: Array, battle_enemies: Array):
	characters = battle_characters
	enemies = battle_enemies
	
	init_characters(characters)
	init_enemies(enemies)
	init_first_character_menu()
		
func init_characters(characters: Array):
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
	
func init_enemies(enemies: Array):
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

# User Menu Buttons
func _on_Attack_pressed():
	$PlayerPanel/Container/Tabs.current_tab = 0

func _on_Magics_pressed():
	$PlayerPanel/Container/Tabs.current_tab = 1

func _on_Exit_pressed():
	print("Exiting battle...")

# Attacks Buttons
func _on_Attack1_pressed():
	pass

func _on_Attack2_pressed():
	pass

func _on_Attack3_pressed():
	pass

func _on_Attack4_pressed():
	pass

# Magics Buttons
func _on_Magic1_pressed():
	pass

func _on_Magic2_pressed():
	pass

func _on_Magic3_pressed():
	pass

func _on_Magic4_pressed():
	pass
