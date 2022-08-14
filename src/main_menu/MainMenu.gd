extends Control
class_name MainMenu

signal new_game

func _on_NewGame_pressed():
	emit_signal("new_game")
	hide()

func _on_Exit_pressed():
	get_tree().quit()
