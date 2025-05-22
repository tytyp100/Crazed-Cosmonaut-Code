extends Control

signal startGame
signal exit

func _ready():
	pass 

func _on_Start_pressed():
	get_tree().change_scene("res://World.tscn")

func _on_Exit_pressed():
	get_tree().quit()
