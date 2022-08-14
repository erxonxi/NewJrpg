extends Node2D
class_name Character

export var index: int = 1 

var character_name: String
var stats: CharacterStats = null 
var level: int = 1
var experience: int = 1

onready var skin = $Skin

func initialize(charater_index: int, character_experience: int):
	index = charater_index
	experience = character_experience
	var character_data = load("res://resources/characters/Char%s.tres" % index) as CharacterData
	stats = character_data.create_stats(experience)
	$Skin/Sprite.texture = character_data.texture
	character_name = character_data.name

func play_damaged():
	$Skin/AnimationPlayer.play("damaged")
