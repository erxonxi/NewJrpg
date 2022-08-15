extends Node2D
class_name Character

export var index: int = 1 

var character_name: String
var stats: CharacterStats = null 
var level: int = 1
var experience: int = 1
var attacks_ids := [1]
var magics_ids := [1]

onready var skin = $Skin
onready var attacks = $Attacks
onready var magics = $Magics
onready var selector = $Skin/Selector

func initialize(charater_index: int, character_experience: int, character_attacks_ids: Array, character_magics_ids: Array):
	index = charater_index
	experience = character_experience
	attacks_ids = character_attacks_ids
	magics_ids = character_magics_ids
	
	var character_data = load("res://resources/characters/Char%s.tres" % index) as CharacterData
	
	stats = character_data.create_stats(experience)
	$Skin/Sprite.texture = character_data.texture
	character_name = character_data.name
	
	setup_attacks()
	setup_magics()
	
	$Skin/Selector.hide()
	$Skin/Bars/Health.max_value = stats.health
	$Skin/Bars/Health.value = stats.health
	
	stats.connect("health_changed", self, "on_health_changed")

func on_health_changed(new_health, old_health):
	$Skin/Bars/Health.value = stats.health

func play_damaged():
	$Skin/AnimationPlayer.play("damaged")

func setup_attacks():
	var attack_skill_scene = preload("res://src/characters/skills/AttackSkill.tscn")
	
	# clear existent attacks
	for attack in $Attacks.get_attacks():
		attack.queue_free()
	
	# create nodes attacks
	for attack_id in attacks_ids:
		var attack = attack_skill_scene.instance() as AttackSkill
		attack.initialize(attack_id)
		$Attacks.add_child(attack)
		
func setup_magics():
	var magic_skill_scene = preload("res://src/characters/skills/MagicSkill.tscn")
	
	# clear existent magics
	for magic in $Magics.get_magics():
		magic.queue_free()
	
	# create nodes attacks
	for magic_id in magics_ids:
		var magic = magic_skill_scene.instance() as MagicSkill
		magic.initialize(magic_id)
		$Magics.add_child(magic)
